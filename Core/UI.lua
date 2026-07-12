-- UI.lua builds the visible addon interface.
--
-- Current responsibilities:
-- 1. minimap launcher button
-- 2. centered main window with tabs
-- 3. upload instructions pane
-- 4. compact in-dungeon tracker window
--
-- This module is intentionally presentation-focused. The tracker and database
-- modules decide what data exists; UI.lua only shows it and exposes controls.

DungeonOracle = DungeonOracle or {}
DungeonOracle.UI = DungeonOracle.UI or {}

local UI = DungeonOracle.UI

-- Window sizing is intentionally modest so the addon reads like a utility
-- panel instead of a full-screen interface.
local WINDOW_WIDTH = 460
local WINDOW_HEIGHT = 404
local MINIMAP_RADIUS = 80
local MINIMAP_ICON = "Interface\\Icons\\INV_Misc_Note_01"
local UPLOAD_URL = "https://www.dropbox.com/request/bhj770kopf5k3hpdhzrc"
local PATH_FONT_SIZE = 9
local TRACKER_WINDOW_WIDTH = 285
local TRACKER_WINDOW_HEIGHT = 192
local TRACKER_LOG_LINE_LIMIT = 8

-- Tab definitions drive both the clickable tab buttons and the associated
-- content panes. New tabs should generally be added here first.
local TAB_DEFINITIONS = {
    { id = 1, text = "My Data" },
    { id = 2, text = "Upload Instructions" },
    { id = 3, text = "Settings" },
}

-- Settings are read through small helper functions so UI code never reaches
-- directly into SavedVariables.
local function getShowMinimapButtonSetting()
    if DungeonOracle.Database and DungeonOracle.Database.GetSetting then
        return DungeonOracle.Database.GetSetting("show_minimap_button")
    end

    return true
end

local function setShowMinimapButtonSetting(value)
    if DungeonOracle.Database and DungeonOracle.Database.SetSetting then
        DungeonOracle.Database.SetSetting("show_minimap_button", value)
    end
end

local function getShowTrackerWindowSetting()
    if DungeonOracle.Database and DungeonOracle.Database.GetSetting then
        return DungeonOracle.Database.GetSetting("show_tracker_window")
    end

    return true
end

local function setShowTrackerWindowSetting(value)
    if DungeonOracle.Database and DungeonOracle.Database.SetSetting then
        DungeonOracle.Database.SetSetting("show_tracker_window", value)
    end
end

local function getRecordCount()
    if DungeonOracle.Database and DungeonOracle.Database.GetRecordCount then
        return DungeonOracle.Database.GetRecordCount()
    end

    return 0
end

local function getStoredRuns()
    if DungeonOracle.Database and DungeonOracle.Database.GetRecords then
        return DungeonOracle.Database.GetRecords()
    end

    return {}
end

local function getTrackerWindowPositionSetting()
    if DungeonOracle.Database and DungeonOracle.Database.GetSetting then
        return DungeonOracle.Database.GetSetting("tracker_window_position")
    end

    return nil
end

local function setTrackerWindowPositionSetting(position)
    if DungeonOracle.Database and DungeonOracle.Database.SetSetting then
        DungeonOracle.Database.SetSetting("tracker_window_position", position)
    end
end

-- Anchors the small tracker window just above the primary chat frame when
-- that frame exists. A conservative fallback keeps the window readable even if
-- chat has been replaced or is unavailable during initialization.
local function positionTrackerWindow(frame)
    local savedPosition = getTrackerWindowPositionSetting()

    frame:ClearAllPoints()

    if savedPosition and savedPosition.left and savedPosition.bottom then
        frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", savedPosition.left, savedPosition.bottom)
        UI.trackerHasCustomPosition = true
        return
    end

    if ChatFrame1 then
        frame:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 22)
    else
        frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 32, 220)
    end
end

local function ensureTrackerWindowPosition(frame)
    if not frame or UI.trackerHasCustomPosition then
        return
    end

    positionTrackerWindow(frame)
end

local function getColoredLootCounterText(greenDrops, blueDrops, purpleDrops)
    return string.format(
        "Uncommon: |cff1eff00%d|r | Rare: |cff0070dd%d|r | Epic: |cffa335ee%d|r",
        tonumber(greenDrops) or 0,
        tonumber(blueDrops) or 0,
        tonumber(purpleDrops) or 0
    )
end

local function getMoneyDisplayText(copperValue)
    local totalCopper = tonumber(copperValue) or 0
    local isNegative = totalCopper < 0
    local absoluteCopper = math.abs(totalCopper)
    local gold = math.floor(absoluteCopper / 10000)
    local silver = math.floor(math.fmod(absoluteCopper, 10000) / 100)
    local copper = math.fmod(absoluteCopper, 100)
    local signPrefix = isNegative and "-" or ""

    if gold > 0 then
        return string.format(
            "%s%d|TInterface\\MoneyFrame\\UI-GoldIcon:0:0:2:0|t %d|TInterface\\MoneyFrame\\UI-SilverIcon:0:0:2:0|t %d|TInterface\\MoneyFrame\\UI-CopperIcon:0:0:2:0|t",
            signPrefix,
            gold,
            silver,
            copper
        )
    end

    if silver > 0 then
        return string.format(
            "%s%d|TInterface\\MoneyFrame\\UI-SilverIcon:0:0:2:0|t %d|TInterface\\MoneyFrame\\UI-CopperIcon:0:0:2:0|t",
            signPrefix,
            silver,
            copper
        )
    end

    return string.format(
        "%s%d|TInterface\\MoneyFrame\\UI-CopperIcon:0:0:2:0|t",
        signPrefix,
        copper
    )
end

local function normalizeUiDungeonName(name)
    if not name then
        return nil
    end

    name = string.lower(name)
    name = string.gsub(name, "^the%s+", "")
    name = string.gsub(name, "[^%w]", "")

    return name
end

local function formatDurationClock(totalSeconds)
    local hours
    local minutes
    local seconds

    totalSeconds = math.max(0, tonumber(totalSeconds) or 0)
    hours = math.floor(totalSeconds / 3600)
    minutes = math.floor(math.fmod(totalSeconds, 3600) / 60)
    seconds = math.fmod(totalSeconds, 60)

    return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end

local function getBossNameForRun(dungeonName, bossId)
    local dungeonDefinition
    local boss

    if not dungeonName or not bossId or not DungeonOracleData or not DungeonOracleData.dungeons then
        return tostring(bossId or "-")
    end

    for _, dungeonDefinition in pairs(DungeonOracleData.dungeons) do
        if normalizeUiDungeonName(dungeonDefinition.name) == normalizeUiDungeonName(dungeonName) then
            if dungeonDefinition.bosses then
                for _, boss in ipairs(dungeonDefinition.bosses) do
                    if boss.id == bossId then
                        return boss.name or tostring(bossId)
                    end
                end
            end
        end
    end

    return tostring(bossId)
end

-- Creates the centered title text shown at the top of the main window.
local function createTitle(frame, text)
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    title:SetPoint("TOP", 0, -7)
    title:SetText(text)
end

-- Creates one content pane per tab. Panes are stacked in the same area and
-- shown or hidden as the active tab changes.
local function createContentPane(parent)
    local pane = CreateFrame("Frame", nil, parent, "InsetFrameTemplate3")
    pane:SetPoint("TOPLEFT", 16, -88)
    pane:SetPoint("BOTTOMRIGHT", -16, 20)
    pane:Hide()

    return pane
end

-- The settings pane only wires UI controls to setting helpers. It does not
-- contain any tracking logic itself.
local function populateSettingsPane(pane)
    local minimapCheckbox = CreateFrame("CheckButton", nil, pane, "UICheckButtonTemplate")
    minimapCheckbox:SetPoint("TOPLEFT", 16, -16)
    minimapCheckbox.text:SetText("Show minimap button")
    minimapCheckbox:SetChecked(getShowMinimapButtonSetting())
    minimapCheckbox:SetScript("OnClick", function(self)
        UI.SetMinimapButtonVisible(self:GetChecked())
    end)

    local trackerCheckbox = CreateFrame("CheckButton", nil, pane, "UICheckButtonTemplate")
    trackerCheckbox:SetPoint("TOPLEFT", minimapCheckbox, "BOTTOMLEFT", 0, -10)
    trackerCheckbox.text:SetText("Show in-dungeon tracker")
    trackerCheckbox:SetChecked(getShowTrackerWindowSetting())
    trackerCheckbox:SetScript("OnClick", function(self)
        UI.SetTrackerWindowVisible(self:GetChecked())
    end)

    UI.showMinimapButtonCheckbox = minimapCheckbox
    UI.showTrackerWindowCheckbox = trackerCheckbox
end

local function populateMyDataPane(pane)
    local scrollFrame = CreateFrame("ScrollFrame", nil, pane, "UIPanelScrollFrameTemplate")
    local content = CreateFrame("Frame", nil, scrollFrame)

    scrollFrame:SetPoint("TOPLEFT", 12, -12)
    scrollFrame:SetPoint("BOTTOMRIGHT", -28, 12)

    content:SetWidth(WINDOW_WIDTH - 90)
    content:SetHeight(1)
    scrollFrame:SetScrollChild(content)

    UI.myDataScrollFrame = scrollFrame
    UI.myDataContent = content
    UI.myDataRows = {}
end

-- The upload pane is informational. It explains manual export and gives the
-- player a way to clear local records after an upload is complete.
local function populateUploadInstructionsPane(pane)
    local intro = pane:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    intro:SetPoint("TOPLEFT", 16, -16)
    intro:SetPoint("RIGHT", pane, "RIGHT", -16, 0)
    intro:SetJustifyH("LEFT")
    intro:SetJustifyV("TOP")
    intro:SetSpacing(3)
    intro:SetText(
        "Dungeon Oracle cannot automatically upload your dungeon data to our database. "
            .. "If you would like to contribute data to this project, a manual upload is required.\n\n"
            .. "Upload your file at the following URL:"
    )

    local urlBox = CreateFrame("EditBox", nil, pane, "InputBoxTemplate")
    urlBox:SetPoint("TOPLEFT", intro, "BOTTOMLEFT", 0, -10)
    urlBox:SetPoint("RIGHT", pane, "RIGHT", -24, 0)
    urlBox:SetHeight(20)
    urlBox:SetAutoFocus(false)
    urlBox:SetFontObject("GameFontHighlightSmall")
    urlBox:SetText(UPLOAD_URL)
    urlBox:SetCursorPosition(0)
    urlBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
        self:HighlightText(0, 0)
    end)
    urlBox:SetScript("OnEditFocusGained", function(self)
        self:HighlightText()
    end)
    urlBox:SetScript("OnMouseUp", function(self)
        self:SetFocus()
        self:HighlightText()
    end)

    local body = pane:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    body:SetPoint("TOPLEFT", urlBox, "BOTTOMLEFT", 0, -12)
    body:SetPoint("RIGHT", pane, "RIGHT", -16, 0)
    body:SetJustifyH("LEFT")
    body:SetJustifyV("TOP")
    body:SetSpacing(3)
    body:SetText(
        "When prompted to choose a file, navigate to the drive where World of Warcraft is installed, then open:\n"
    )

    local pathText = pane:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    pathText:SetPoint("TOPLEFT", body, "BOTTOMLEFT", 0, -8)
    pathText:SetPoint("RIGHT", pane, "RIGHT", -16, 0)
    pathText:SetJustifyH("LEFT")
    pathText:SetJustifyV("TOP")
    pathText:SetSpacing(2)
    pathText:SetFont(STANDARD_TEXT_FONT, PATH_FONT_SIZE, "")
    pathText:SetText("World of Warcraft\\_classic_era_\\WTF\\Account\\<YOUR_ACCOUNT>\\SavedVariables")

    local fileLabel = pane:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    fileLabel:SetPoint("TOPLEFT", pathText, "BOTTOMLEFT", 0, -10)
    fileLabel:SetPoint("RIGHT", pane, "RIGHT", -16, 0)
    fileLabel:SetJustifyH("LEFT")
    fileLabel:SetJustifyV("TOP")
    fileLabel:SetSpacing(3)
    fileLabel:SetText("Select the file named:")

    local fileName = pane:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    fileName:SetPoint("TOPLEFT", fileLabel, "BOTTOMLEFT", 0, -6)
    fileName:SetPoint("RIGHT", pane, "RIGHT", -16, 0)
    fileName:SetJustifyH("LEFT")
    fileName:SetJustifyV("TOP")
    fileName:SetFont(STANDARD_TEXT_FONT, PATH_FONT_SIZE, "")
    fileName:SetText("DungeonOracle.lua")

    local submissionNote = pane:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    submissionNote:SetPoint("TOPLEFT", fileName, "BOTTOMLEFT", 0, -10)
    submissionNote:SetPoint("RIGHT", pane, "RIGHT", -16, 0)
    submissionNote:SetJustifyH("LEFT")
    submissionNote:SetJustifyV("TOP")
    submissionNote:SetSpacing(3)
    submissionNote:SetText(
        "Dropbox may ask for a name and email address before the upload begins. "
            .. "You may enter placeholder information if you prefer; it does not need to be real."
    )

    local clearLabel = pane:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    clearLabel:SetPoint("BOTTOMLEFT", 16, 18)
    clearLabel:SetJustifyH("LEFT")
    clearLabel:SetText("")

    local clearButton = CreateFrame("Button", nil, pane, "UIPanelButtonTemplate")
    clearButton:SetSize(150, 22)
    clearButton:SetPoint("LEFT", clearLabel, "RIGHT", 10, 0)
    clearButton:SetText("Delete existing data")
    clearButton:SetScript("OnClick", function()
        if DungeonOracle.Database and DungeonOracle.Database.ClearAllRecords then
            DungeonOracle.Database.ClearAllRecords()

            UI.RefreshUploadInstructionsPane()

            if UI.AppendTrackerLog then
                UI.AppendTrackerLog("local dungeon run data cleared. Reloading UI to save the updated file.")
            end

            ReloadUI()
        end
    end)

    UI.uploadClearLabel = clearLabel
    UI.uploadClearButton = clearButton
end

-- Builds the compact in-dungeon tracker window. The requested layout is very
-- simple: title on top, then a scrolling-style text area made from one font
-- string that shows recent log lines.
local function createTrackerWindow()
    local frame = CreateFrame("Frame", "DungeonOracleTrackerFrame", UIParent, "BackdropTemplate")
    frame:SetSize(TRACKER_WINDOW_WIDTH, TRACKER_WINDOW_HEIGHT)
    frame:SetFrameStrata("MEDIUM")
    frame:SetClampedToScreen(true)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    frame:SetBackdropColor(0.05, 0.05, 0.05, 0.9)
    frame:Hide()
    frame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(self)
        local left = self:GetLeft()
        local bottom = self:GetBottom()

        self:StopMovingOrSizing()
        if left and bottom then
            UI.trackerHasCustomPosition = true
            setTrackerWindowPositionSetting({
                left = math.floor(left + 0.5),
                bottom = math.floor(bottom + 0.5),
            })
        end
    end)

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", 10, -8)
    title:SetText("Dungeon Oracle Tracker")

    local runtimeText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    runtimeText:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    runtimeText:SetText("Runtime: Inactive")

    local timerText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    timerText:SetPoint("TOPLEFT", runtimeText, "BOTTOMLEFT", 0, -6)
    timerText:SetText("Reset Timer: Inactive")

    local bossTimerText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    bossTimerText:SetPoint("TOPLEFT", timerText, "BOTTOMLEFT", 0, -6)
    bossTimerText:SetText("Boss Timer: Inactive")

    local lastBossText = frame:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    lastBossText:SetPoint("TOPLEFT", bossTimerText, "BOTTOMLEFT", 0, -4)
    lastBossText:SetText("Last Boss: Inactive")

    local zoneIdText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    zoneIdText:SetPoint("TOPLEFT", lastBossText, "BOTTOMLEFT", 0, -8)
    zoneIdText:SetText("Zone ID: Inactive")

    local recorderText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    recorderText:SetPoint("TOPLEFT", zoneIdText, "BOTTOMLEFT", 0, -6)
    recorderText:SetText("Recorder: Inactive")

    local runIdText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    runIdText:SetPoint("TOPLEFT", recorderText, "BOTTOMLEFT", 0, -6)
    runIdText:SetText("Run ID: Inactive")

    local lootCounterText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    lootCounterText:SetPoint("TOPLEFT", runIdText, "BOTTOMLEFT", 0, -6)
    lootCounterText:SetText(getColoredLootCounterText(0, 0, 0))

    local moneyText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    moneyText:SetPoint("TOPLEFT", lootCounterText, "BOTTOMLEFT", 0, -6)
    moneyText:SetText("Money: 0|TInterface\\MoneyFrame\\UI-CopperIcon:0:0:2:0|t")

    local xpText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    xpText:SetPoint("TOPLEFT", moneyText, "BOTTOMLEFT", 0, -6)
    xpText:SetText("XP Gained: 0")

    local logText = frame:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    logText:SetPoint("TOPLEFT", xpText, "BOTTOMLEFT", 0, -8)
    logText:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 10)
    logText:SetJustifyH("LEFT")
    logText:SetJustifyV("TOP")
    logText:SetSpacing(2)
    logText:SetText("No loot detected")
    logText:Hide()

    ensureTrackerWindowPosition(frame)

    UI.trackerFrame = frame
    UI.trackerRuntimeText = runtimeText
    UI.trackerTimerText = timerText
    UI.trackerBossTimerText = bossTimerText
    UI.trackerLastBossText = lastBossText
    UI.trackerZoneIdText = zoneIdText
    UI.trackerRecorderText = recorderText
    UI.trackerRunIdText = runIdText
    UI.trackerLootCounterText = lootCounterText
    UI.trackerMoneyText = moneyText
    UI.trackerXpText = xpText
    UI.trackerLogText = logText
    UI.trackerLogLines = { "No loot detected" }

    frame:SetScript("OnUpdate", function(self, elapsed)
        local activeRun
        local currentDungeon
        local remainingSeconds
        local runtimeSeconds
        local runtimeHours
        local runtimeMinutes
        local runtimeRemainderSeconds
        local bossTimer
        local lastBossTimerEntry
        local lastBossName
        local zoneId
        local recorderName

        self.elapsedSinceTimerRefresh = (self.elapsedSinceTimerRefresh or 0) + elapsed
        if self.elapsedSinceTimerRefresh < 0.25 then
            return
        end

        self.elapsedSinceTimerRefresh = 0
        remainingSeconds = DungeonOracle
            and DungeonOracle.Tracker
            and DungeonOracle.Tracker.GetOutsideTimeoutRemainingSeconds
            and DungeonOracle.Tracker.GetOutsideTimeoutRemainingSeconds()

        if UI.trackerTimerText then
            if remainingSeconds ~= nil then
                UI.trackerTimerText:SetText(string.format("Reset Timer: %ds", remainingSeconds))
            else
                UI.trackerTimerText:SetText("Reset Timer: Inactive")
            end
        end

        bossTimer = DungeonOracle
            and DungeonOracle.Tracker
            and DungeonOracle.Tracker.GetCurrentBossTimer
            and DungeonOracle.Tracker.GetCurrentBossTimer()

        activeRun = DungeonOracle
            and DungeonOracle.Tracker
            and DungeonOracle.Tracker.state
            and DungeonOracle.Tracker.state.active_run
        currentDungeon = DungeonOracle
            and DungeonOracle.Tracker
            and DungeonOracle.Tracker.state
            and DungeonOracle.Tracker.state.current_dungeon
        zoneId = (activeRun and activeRun.zone_id) or (currentDungeon and currentDungeon.zone_id) or nil

        if UI.trackerBossTimerText then
            if bossTimer then
                UI.trackerBossTimerText:SetText(string.format("Boss Timer: %s %ds", bossTimer.boss_name or "-", bossTimer.duration or 0))
            else
                UI.trackerBossTimerText:SetText("Boss Timer: Inactive")
            end
        end

        if UI.trackerLastBossText then
            if activeRun and activeRun.boss_timer and #activeRun.boss_timer > 0 then
                lastBossTimerEntry = activeRun.boss_timer[#activeRun.boss_timer]
                lastBossName = getBossNameForRun(activeRun.dungeon_name, lastBossTimerEntry.boss_id)
                UI.trackerLastBossText:SetText(string.format(
                    "Last Boss: %s - %s",
                    lastBossName,
                    formatDurationClock(lastBossTimerEntry.duration)
                ))
            else
                UI.trackerLastBossText:SetText("Last Boss: Inactive")
            end
        end

        if UI.trackerRuntimeText then
            if activeRun and activeRun.started_at then
                if activeRun.outside_instance_started_at then
                    runtimeSeconds = math.max(0, activeRun.outside_instance_started_at - activeRun.started_at)
                else
                    runtimeSeconds = math.max(0, time() - activeRun.started_at)
                end

                runtimeHours = math.floor(runtimeSeconds / 3600)
                runtimeMinutes = math.floor(math.fmod(runtimeSeconds, 3600) / 60)
                runtimeRemainderSeconds = math.fmod(runtimeSeconds, 60)
                UI.trackerRuntimeText:SetText(string.format(
                    "Runtime: %02d:%02d:%02d",
                    runtimeHours,
                    runtimeMinutes,
                    runtimeRemainderSeconds
                ))
            else
                UI.trackerRuntimeText:SetText("Runtime: Inactive")
            end
        end

        if UI.trackerRunIdText then
            if activeRun and activeRun.run_id and activeRun.run_id ~= "" then
                UI.trackerRunIdText:SetText(string.format("Run ID: %s", activeRun.run_id))
            else
                UI.trackerRunIdText:SetText("Run ID: Inactive")
            end
        end

        if UI.trackerZoneIdText then
            if zoneId then
                UI.trackerZoneIdText:SetText(string.format("Zone ID: %d", zoneId))
            else
                UI.trackerZoneIdText:SetText("Zone ID: Inactive")
            end
        end

        recorderName = DungeonOracle
            and DungeonOracle.Tracker
            and DungeonOracle.Tracker.GetRecorderName
            and DungeonOracle.Tracker.GetRecorderName()

        if UI.trackerRecorderText then
            if recorderName and recorderName ~= "" then
                UI.trackerRecorderText:SetText(string.format("Recorder: %s", recorderName))
            else
                UI.trackerRecorderText:SetText("Recorder: Inactive")
            end
        end

        if UI.trackerLootCounterText then
            if activeRun then
                UI.trackerLootCounterText:SetText(getColoredLootCounterText(
                    tonumber(activeRun.green_drops) or 0,
                    tonumber(activeRun.blue_drops) or 0,
                    tonumber(activeRun.purple_drops) or 0
                ))
            else
                UI.trackerLootCounterText:SetText(getColoredLootCounterText(0, 0, 0))
            end
        end

        if UI.trackerMoneyText then
            if activeRun then
                UI.trackerMoneyText:SetText(string.format(
                    "Money: %s",
                    getMoneyDisplayText(activeRun.gold_earned)
                ))
            else
                UI.trackerMoneyText:SetText("Money: 0|TInterface\\MoneyFrame\\UI-CopperIcon:0:0:2:0|t")
            end
        end

        if UI.trackerXpText then
            if activeRun then
                UI.trackerXpText:SetText(string.format(
                    "XP Gained: %d",
                    tonumber(activeRun.xp_gained) or 0
                ))
            else
                UI.trackerXpText:SetText("XP Gained: 0")
            end
        end
    end)
end

-- Public: updates the upload tab footer so the clear prompt always reflects
-- the current number of stored run records.
function UI.RefreshUploadInstructionsPane()
    local recordCount = getRecordCount()

    if UI.uploadClearLabel then
        UI.uploadClearLabel:SetText("After upload, help prevent duplicate data =>")
    end

    if UI.uploadClearButton then
        UI.uploadClearButton:SetEnabled(recordCount > 0)
    end
end

function UI.RefreshMyDataPane()
    local activeRun = DungeonOracle
        and DungeonOracle.Database
        and DungeonOracle.Database.GetActiveRun
        and DungeonOracle.Database.GetActiveRun()
    local records = getStoredRuns()
    local index
    local record
    local rowIndex = 0
    local rowTop = -6
    local rowHeight = 20
    local columnRunIdX = 8
    local columnZoneIdX = 165
    local columnDungeonX = 240
    local columnRunIdWidth = 145
    local columnZoneIdWidth = 60
    local columnDungeonWidth = 118
    local visibleRows = 0

    local function normalizeDungeonName(name)
        if not name then
            return nil
        end

        name = string.lower(name)
        name = string.gsub(name, "^the%s+", "")
        name = string.gsub(name, "[^%w]", "")
        return name
    end

    local function getPartySize(runRecord)
        if type(runRecord) ~= "table" or type(runRecord.party) ~= "table" then
            return 0
        end

        return #runRecord.party
    end

    local function getDeathCount(runRecord)
        if type(runRecord) ~= "table" or type(runRecord.deaths) ~= "table" then
            return 0
        end

        return #runRecord.deaths
    end

    local function formatTimestamp(timestamp)
        if not timestamp then
            return "-"
        end

        return date("%Y-%m-%d %H:%M:%S", timestamp)
    end

    local function getRuntimeText(runRecord)
        local totalSeconds
        local hours
        local minutes
        local seconds

        if type(runRecord) ~= "table" or not runRecord.started_at then
            return "-"
        end

        if runRecord.outside_instance_started_at then
            totalSeconds = math.max(0, runRecord.outside_instance_started_at - runRecord.started_at)
        elseif runRecord.ended_at then
            totalSeconds = math.max(0, runRecord.ended_at - runRecord.started_at)
        else
            totalSeconds = math.max(0, time() - runRecord.started_at)
        end

        hours = math.floor(totalSeconds / 3600)
        minutes = math.floor(math.fmod(totalSeconds, 3600) / 60)
        seconds = math.fmod(totalSeconds, 60)

        return string.format("%02d:%02d:%02d", hours, minutes, seconds)
    end

    local function getClassColor(classFilename)
        local classColors = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS

        if classColors and classFilename and classColors[classFilename] then
            return classColors[classFilename]
        end

        return { r = 1, g = 1, b = 1 }
    end

    local function getClassColoredText(classFilename)
        local color = getClassColor(classFilename)
        local label = classFilename or "UNKNOWN"

        return string.format("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, label)
    end

    local function getPartyCompositionText(runRecord)
        local classes = {}
        local index
        local member

        if type(runRecord) ~= "table" or type(runRecord.party) ~= "table" then
            return "-"
        end

        for index, member in ipairs(runRecord.party) do
            classes[index] = getClassColoredText(member.class)
        end

        if #classes == 0 then
            return "-"
        end

        return table.concat(classes, ", ")
    end

    local function getBossDefinitionById(runRecord, bossId)
        local dungeonDefinition
        local boss

        if not runRecord or not bossId or not DungeonOracleData or not DungeonOracleData.dungeons then
            return nil
        end

        for _, dungeonDefinition in pairs(DungeonOracleData.dungeons) do
            if normalizeDungeonName(dungeonDefinition.name) == normalizeDungeonName(runRecord.dungeon_name) then
                if dungeonDefinition.bosses then
                    for _, boss in ipairs(dungeonDefinition.bosses) do
                        if boss.id == bossId then
                            return boss
                        end
                    end
                end

                return nil
            end
        end

        return nil
    end

    local function getBossBeatenCount(runRecord)
        if type(runRecord) ~= "table" or type(runRecord.boss_timer) ~= "table" then
            return 0
        end

        return #runRecord.boss_timer
    end

    local function getBossLootLines(runRecord)
        local lines = {}
        local bossId
        local lootId
        local bossDefinition
        local bossName
        local lootName

        if type(runRecord) ~= "table" or type(runRecord.boss_loot) ~= "table" then
            return lines
        end

        for bossId, lootId in pairs(runRecord.boss_loot) do
            bossDefinition = getBossDefinitionById(runRecord, tonumber(bossId))
            bossName = bossDefinition and bossDefinition.name or tostring(bossId)

            if lootId == -1 then
                lootName = "No tracked loot"
            else
                lootName = GetItemInfo and GetItemInfo(lootId) or nil
                lootName = lootName or string.format("Item %s", tostring(lootId))
            end

            lines[#lines + 1] = string.format("%s - %s", bossName, lootName)
        end

        table.sort(lines)
        return lines
    end

    local function getNonBossLootText(runRecord)
        local greenDrops = type(runRecord) == "table" and (runRecord.green_drops or 0) or 0
        local blueDrops = type(runRecord) == "table" and (runRecord.blue_drops or 0) or 0
        local purpleDrops = type(runRecord) == "table" and (runRecord.purple_drops or 0) or 0

        return string.format(
            "|cff1eff00%d|r | |cff0070dd%d|r | |cffa335ee%d|r",
            greenDrops,
            blueDrops,
            purpleDrops
        )
    end

    local function populateRunTooltip(row, runRecord)
        local bossLootLines
        local bossLootLine

        if not row or not runRecord then
            return
        end

        GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
        GameTooltip:ClearLines()
        GameTooltip:AddLine(runRecord.dungeon_name or "Dungeon Run", 1, 0.82, 0)
        GameTooltip:AddDoubleLine("Run ID", tostring(runRecord.run_id or "-"), 1, 1, 1, 1, 1, 1)
        GameTooltip:AddDoubleLine("Zone ID", runRecord.zone_id and tostring(runRecord.zone_id) or "-", 1, 1, 1, 1, 1, 1)
        GameTooltip:AddDoubleLine("Started", formatTimestamp(runRecord.started_at), 1, 1, 1, 1, 1, 1)

        if runRecord.ended_at then
            GameTooltip:AddDoubleLine("Ended", formatTimestamp(runRecord.ended_at), 1, 1, 1, 1, 1, 1)
        else
            GameTooltip:AddDoubleLine("Ended", "Active", 1, 1, 1, 0.5, 1, 0.5)
        end
        GameTooltip:AddDoubleLine("Runtime", getRuntimeText(runRecord), 1, 1, 1, 1, 1, 1)

        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Party Composition:", 1, 0.82, 0)
        GameTooltip:AddLine(getPartyCompositionText(runRecord), 1, 1, 1, true)

        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine("Number of Deaths", tostring(getDeathCount(runRecord)), 1, 1, 1, 1, 1, 1)
        GameTooltip:AddDoubleLine(
            "First Death",
            runRecord.first_death and getClassColoredText(runRecord.first_death.class) or "-",
            1,
            1,
            1,
            1,
            1,
            1
        )
        GameTooltip:AddDoubleLine("Bosses Beaten", tostring(getBossBeatenCount(runRecord)), 1, 1, 1, 1, 1, 1)
        GameTooltip:AddDoubleLine(
            "Money",
            getMoneyDisplayText(runRecord.gold_earned),
            1,
            1,
            1,
            1,
            1,
            1
        )
        GameTooltip:AddDoubleLine(
            "XP Gained",
            tostring(tonumber(runRecord.xp_gained) or 0),
            1,
            1,
            1,
            1,
            1,
            1
        )

        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Boss Loot:", 1, 0.82, 0)
        if type(runRecord.boss_loot) == "table" and next(runRecord.boss_loot) then
            bossLootLines = getBossLootLines(runRecord)

            for _, bossLootLine in ipairs(bossLootLines) do
                GameTooltip:AddLine(bossLootLine, 1, 1, 1, true)
            end
        else
            GameTooltip:AddLine("-", 1, 1, 1)
        end

        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine("Other Loot:", getNonBossLootText(runRecord), 1, 1, 1, 1, 1, 1)
        GameTooltip:Show()
    end

    local function ensureRow(rowNumber)
        local row = UI.myDataRows[rowNumber]

        if row then
            return row
        end

        row = CreateFrame("Frame", nil, UI.myDataContent)
        row:SetHeight(rowHeight)

        row.left = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        row.left:SetPoint("TOPLEFT", columnRunIdX, 0)
        row.left:SetWidth(columnRunIdWidth)
        row.left:SetJustifyH("LEFT")
        row.left:SetWordWrap(false)

        row.middle = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        row.middle:SetPoint("TOPLEFT", columnZoneIdX, 0)
        row.middle:SetWidth(columnZoneIdWidth)
        row.middle:SetJustifyH("LEFT")
        row.middle:SetWordWrap(false)

        row.right = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        row.right:SetPoint("TOPLEFT", columnDungeonX, 0)
        row.right:SetWidth(columnDungeonWidth)
        row.right:SetJustifyH("LEFT")
        row.right:SetWordWrap(false)

        row.separator = row:CreateTexture(nil, "ARTWORK")
        row.separator:SetHeight(1)
        row.separator:SetPoint("TOPLEFT", 8, -15)
        row.separator:SetPoint("TOPRIGHT", -12, -15)
        row.separator:SetColorTexture(1, 0.82, 0, 0.85)
        row.separator:Hide()

        row:SetScript("OnEnter", function(self)
            local runRecord = self.runRecord

            if not runRecord then
                return
            end

            self.tooltipElapsed = 0
            populateRunTooltip(self, runRecord)
        end)

        row:SetScript("OnLeave", function(self)
            self.tooltipElapsed = 0
            if self.runRecord then
                GameTooltip:Hide()
            end
        end)

        row:SetScript("OnUpdate", function(self, elapsed)
            if not self.runRecord or self.runRecord.ended_at or not GameTooltip:IsOwned(self) then
                return
            end

            self.tooltipElapsed = (self.tooltipElapsed or 0) + elapsed
            if self.tooltipElapsed < 0.2 then
                return
            end

            self.tooltipElapsed = 0
            populateRunTooltip(self, self.runRecord)
        end)

        UI.myDataRows[rowNumber] = row
        return row
    end

    local function setRow(rowNumber, leftText, middleText, rightText, fontObject, showSeparator, runRecord)
        local row = ensureRow(rowNumber)

        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", UI.myDataContent, "TOPLEFT", 0, rowTop - ((rowNumber - 1) * rowHeight))
        row:SetPoint("TOPRIGHT", UI.myDataContent, "TOPRIGHT", 0, rowTop - ((rowNumber - 1) * rowHeight))

        row.left:SetFontObject(fontObject or "GameFontNormalSmall")
        row.middle:SetFontObject(fontObject or "GameFontNormalSmall")
        row.right:SetFontObject(fontObject or "GameFontNormalSmall")

        if (not middleText or middleText == "") and (not rightText or rightText == "") then
            row.left:SetWidth((UI.myDataContent:GetWidth() or 0) - 20)
        else
            row.left:SetWidth(columnRunIdWidth)
        end
        row.middle:SetWidth(columnZoneIdWidth)
        row.right:SetWidth(columnDungeonWidth)

        row.left:SetText(leftText or "")
        row.middle:SetText(middleText or "")
        row.right:SetText(rightText or "")
        row.runRecord = runRecord
        if showSeparator then
            row.separator:Show()
        else
            row.separator:Hide()
        end
        row:Show()
        visibleRows = rowNumber
    end

    local function addSectionTitle(titleText)
        rowIndex = rowIndex + 1
        setRow(rowIndex, titleText, "", "", "GameFontHighlight", false)
    end

    local function addSectionDivider()
        rowIndex = rowIndex + 1
        setRow(rowIndex, "", "", "", "GameFontNormalSmall", true)
    end

    local function addSectionNote(noteText, showSeparator)
        rowIndex = rowIndex + 1
        setRow(rowIndex, noteText, "", "", "GameFontDisableSmall", showSeparator)
    end

    local function addHeaderRow()
        rowIndex = rowIndex + 1
        setRow(rowIndex, "Run ID", "Zone ID", "Dungeon Name", "GameFontNormalSmall", false)
    end

    local function addRunDataRow(runRecord)
        rowIndex = rowIndex + 1
        setRow(
            rowIndex,
            tostring(runRecord.run_id or "-"),
            runRecord.zone_id and tostring(runRecord.zone_id) or "-",
            tostring(runRecord.dungeon_name or "-"),
            "GameFontHighlightSmall",
            false,
            runRecord
        )
    end

    local function addSpacer()
        rowIndex = rowIndex + 1
        setRow(rowIndex, "", "", "", "GameFontNormalSmall", false)
    end

    if not UI.myDataContent or not UI.myDataRows then
        return
    end

    if activeRun and activeRun.run_id and activeRun.run_id ~= "" then
        addSectionTitle("Active Run")
        addSectionDivider()
        addHeaderRow()
        addRunDataRow(activeRun)
        addSpacer()
    end

    if #records > 0 then
        addSectionTitle(string.format("Completed Runs - %d", #records))
        if #records >= 5 then
            addSectionNote("Please consider uploading your data", true)
        else
            addSectionDivider()
        end
        addHeaderRow()

        for index = #records, 1, -1 do
            record = records[index]
            if record and record.run_id and record.run_id ~= "" then
                addRunDataRow(record)
            end
        end
    end

    if rowIndex == 0 then
        addSectionTitle("No run data recorded yet.")
    end

    for index = visibleRows + 1, #UI.myDataRows do
        UI.myDataRows[index]:Hide()
    end

    UI.myDataContent:SetHeight(math.max((visibleRows * rowHeight) + 12, 1))
end

-- Public: replaces the visible tracker log buffer with the supplied lines.
function UI.SetTrackerLogs(logLines)
    if not UI.trackerLogText then
        return
    end

    UI.trackerLogLines = {}

    if logLines then
        for _, line in ipairs(logLines) do
            UI.trackerLogLines[#UI.trackerLogLines + 1] = line
        end
    end

    if #UI.trackerLogLines == 0 then
        UI.trackerLogLines[1] = "No loot detected"
    end

    UI.trackerLogText:SetText(table.concat(UI.trackerLogLines, "\n"))
end

-- Public: appends one log line to the visible tracker window while keeping the
-- log bounded so the compact frame stays readable.
function UI.AppendTrackerLog(logLine)
    if not logLine or logLine == "" then
        return
    end

    UI.trackerLogLines = UI.trackerLogLines or {}

    if #UI.trackerLogLines == 1 and UI.trackerLogLines[1] == "No loot detected" then
        UI.trackerLogLines = {}
    end

    UI.trackerLogLines[#UI.trackerLogLines + 1] = logLine

    while #UI.trackerLogLines > TRACKER_LOG_LINE_LIMIT do
        table.remove(UI.trackerLogLines, 1)
    end

    UI.SetTrackerLogs(UI.trackerLogLines)
end

-- Public: resets the in-dungeon tracker logs to the requested starting state.
function UI.ResetTrackerLogs()
    UI.SetTrackerLogs({ "No loot detected" })
end

-- Public: applies the in-dungeon tracker visibility preference and keeps the
-- saved setting, live frame, and settings checkbox aligned.
function UI.SetTrackerWindowVisible(isVisible)
    local shouldShow = not not isVisible
    local hasActiveRun = DungeonOracle
        and DungeonOracle.Tracker
        and DungeonOracle.Tracker.state
        and (DungeonOracle.Tracker.state.active_run or DungeonOracle.Tracker.state.current_dungeon)

    setShowTrackerWindowSetting(shouldShow)

    if UI.showTrackerWindowCheckbox and UI.showTrackerWindowCheckbox:GetChecked() ~= shouldShow then
        UI.showTrackerWindowCheckbox:SetChecked(shouldShow)
    end

    if not UI.trackerFrame then
        return
    end

    if shouldShow and hasActiveRun then
        ensureTrackerWindowPosition(UI.trackerFrame)
        UI.trackerFrame:Show()
    else
        UI.trackerFrame:Hide()
    end
end

-- Public: shows the in-dungeon tracker when a run becomes active.
function UI.ShowTrackerWindow()
    if not UI.trackerFrame or not getShowTrackerWindowSetting() then
        return
    end

    ensureTrackerWindowPosition(UI.trackerFrame)
    UI.trackerFrame:Show()
end

-- Public: hides the in-dungeon tracker when no run is active.
function UI.HideTrackerWindow()
    if UI.trackerFrame then
        UI.trackerFrame:Hide()
    end
end

-- Switches the active tab and updates pane visibility to match.
local function selectTab(tabIndex)
    UI.selectedTab = tabIndex

    for index, tab in ipairs(UI.tabs) do
        if index == tabIndex then
            PanelTemplates_SelectTab(tab)
            UI.contentPanes[index]:Show()
        else
            PanelTemplates_DeselectTab(tab)
            UI.contentPanes[index]:Hide()
        end
    end

    if tabIndex == 1 then
        UI.RefreshMyDataPane()
    elseif tabIndex == 2 then
        UI.RefreshUploadInstructionsPane()
    end
end

-- Creates a single tab button and wires it to the shared tab-selection logic.
local function createTab(parent, definition, index)
    local tab = CreateFrame("Button", "$parentTab" .. index, parent, "OptionsFrameTabButtonTemplate")
    tab:SetID(index)
    tab:SetText(definition.text)
    tab:SetScript("OnClick", function(self)
        selectTab(self:GetID())
    end)

    PanelTemplates_TabResize(tab, 0)

    if index == 1 then
        tab:SetPoint("TOPLEFT", parent, "TOPLEFT", 14, -30)
    else
        tab:SetPoint("LEFT", UI.tabs[index - 1], "RIGHT", -10, 0)
    end

    return tab
end

-- Builds the main Dungeon Oracle window and all tab/pane children.
local function createMainWindow()
    local frame = CreateFrame("Frame", "DungeonOracleMainFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(WINDOW_WIDTH, WINDOW_HEIGHT)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 40)
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:Hide()
    table.insert(UISpecialFrames, frame:GetName())

    createTitle(frame, "Dungeon Oracle")

    UI.tabs = {}
    UI.contentPanes = {}
    UI.mainFrame = frame

    for index, definition in ipairs(TAB_DEFINITIONS) do
        UI.tabs[index] = createTab(frame, definition, index)
        UI.contentPanes[index] = createContentPane(frame)
    end

    populateMyDataPane(UI.contentPanes[1])
    populateUploadInstructionsPane(UI.contentPanes[2])
    populateSettingsPane(UI.contentPanes[3])

    PanelTemplates_SetNumTabs(frame, #TAB_DEFINITIONS)
    PanelTemplates_UpdateTabs(frame)
    selectTab(1)
end

-- Anchors the minimap button at a fixed angle around the minimap.
-- If we later support dragging, this helper can remain the single place that
-- converts saved position data into screen coordinates.
local function positionMinimapButton(button)
    local angle = math.rad(45)
    local xOffset = math.cos(angle) * MINIMAP_RADIUS
    local yOffset = math.sin(angle) * MINIMAP_RADIUS

    button:ClearAllPoints()
    button:SetPoint("CENTER", Minimap, "CENTER", xOffset, yOffset)
end

-- Builds the minimap launcher button used to open and close the main window.
local function createMinimapButton()
    local button = CreateFrame("Button", "DungeonOracleMinimapButton", Minimap)
    button:SetSize(32, 32)
    button:SetFrameStrata("MEDIUM")
    button:RegisterForClicks("LeftButtonUp")

    local icon = button:CreateTexture(nil, "BACKGROUND")
    icon:SetSize(20, 20)
    icon:SetPoint("CENTER")
    icon:SetTexture(MINIMAP_ICON)

    local overlay = button:CreateTexture(nil, "OVERLAY")
    overlay:SetSize(53, 53)
    overlay:SetPoint("TOPLEFT")
    overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    local highlight = button:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetBlendMode("ADD")
    highlight:SetSize(20, 20)
    highlight:SetPoint("CENTER")
    highlight:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    button:SetScript("OnClick", function()
        UI.ToggleMainWindow()
    end)

    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("Dungeon Oracle")
        GameTooltip:AddLine("Open the Dungeon Oracle menu.", 1, 1, 1)
        GameTooltip:Show()
    end)

    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    positionMinimapButton(button)
    UI.minimapButton = button
end

-- Public: applies the minimap visibility preference and keeps the saved
-- setting, live button, and settings checkbox aligned.
function UI.SetMinimapButtonVisible(isVisible)
    local shouldShow = not not isVisible

    setShowMinimapButtonSetting(shouldShow)

    if UI.showMinimapButtonCheckbox and UI.showMinimapButtonCheckbox:GetChecked() ~= shouldShow then
        UI.showMinimapButtonCheckbox:SetChecked(shouldShow)
    end

    if not UI.minimapButton then
        return
    end

    if shouldShow then
        UI.minimapButton:Show()
    else
        UI.minimapButton:Hide()
    end
end

-- Public: toggles the main Dungeon Oracle window.
function UI.ToggleMainWindow()
    if not UI.mainFrame then
        return
    end

    if UI.mainFrame:IsShown() then
        UI.mainFrame:Hide()
    else
        UI.RefreshMyDataPane()
        UI.RefreshUploadInstructionsPane()
        UI.mainFrame:Show()
    end
end

-- Public: initializes the UI once on player login.
-- This guard prevents duplicate frames if initialization is called twice.
function UI.Initialize()
    if UI.isInitialized then
        return
    end

    createMainWindow()
    createMinimapButton()
    createTrackerWindow()
    UI.SetMinimapButtonVisible(getShowMinimapButtonSetting())
    UI.SetTrackerWindowVisible(getShowTrackerWindowSetting())
    UI.RefreshMyDataPane()
    UI.RefreshUploadInstructionsPane()

    UI.isInitialized = true
end
