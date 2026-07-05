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
local WINDOW_HEIGHT = 340
local MINIMAP_RADIUS = 80
local MINIMAP_ICON = "Interface\\Icons\\INV_Misc_Note_01"
local UPLOAD_URL = "https://www.dropbox.com/request/2okeud4m0vplo6e8nsmk"
local PATH_FONT_SIZE = 9
local TRACKER_WINDOW_WIDTH = 360
local TRACKER_WINDOW_HEIGHT = 208
local TRACKER_LOG_LINE_LIMIT = 8

-- Tab definitions drive both the clickable tab buttons and the associated
-- content panes. New tabs should generally be added here first.
local TAB_DEFINITIONS = {
    { id = 1, text = "Settings" },
    { id = 2, text = "Upload Instructions" },
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

-- Anchors the small tracker window just above the primary chat frame when
-- that frame exists. A conservative fallback keeps the window readable even if
-- chat has been replaced or is unavailable during initialization.
local function positionTrackerWindow(frame)
    frame:ClearAllPoints()

    if ChatFrame1 then
        frame:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 22)
    else
        frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 32, 220)
    end
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
    pane:SetPoint("BOTTOMRIGHT", -16, 16)
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
        "Dungeon Oracle cannot automatically upload your dungeon run data to our database. "
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
        "Dropbox may ask for a name and email address before the upload begins. "
            .. "You may enter placeholder information if you prefer; it does not need to be real.\n\n"
            .. "When prompted to choose a file, navigate to the drive where World of Warcraft is installed, then open:\n"
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

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", 10, -8)
    title:SetText("Dungeon Oracle Tracker")

    local timerText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    timerText:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    timerText:SetText("Reset Timer: Inactive")

    local bossTimerText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    bossTimerText:SetPoint("TOPLEFT", timerText, "BOTTOMLEFT", 0, -6)
    bossTimerText:SetText("Boss Timer: Inactive")

    local runIdText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    runIdText:SetPoint("TOPLEFT", bossTimerText, "BOTTOMLEFT", 0, -6)
    runIdText:SetText("Run ID: Inactive")

    local zoneIdText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    zoneIdText:SetPoint("TOPLEFT", runIdText, "BOTTOMLEFT", 0, -6)
    zoneIdText:SetText("Zone ID: Inactive")

    local lootCounterText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    lootCounterText:SetPoint("TOPLEFT", zoneIdText, "BOTTOMLEFT", 0, -6)
    lootCounterText:SetText("Green: 0 | Blue: 0 | Purple: 0")

    local bossQueueText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    bossQueueText:SetPoint("TOPLEFT", lootCounterText, "BOTTOMLEFT", 0, -6)
    bossQueueText:SetText("Boss Queue: Inactive")

    local logText = frame:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    logText:SetPoint("TOPLEFT", bossQueueText, "BOTTOMLEFT", 0, -8)
    logText:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 10)
    logText:SetJustifyH("LEFT")
    logText:SetJustifyV("TOP")
    logText:SetSpacing(2)
    logText:SetText("No loot detected")

    positionTrackerWindow(frame)

    UI.trackerFrame = frame
    UI.trackerTimerText = timerText
    UI.trackerBossTimerText = bossTimerText
    UI.trackerRunIdText = runIdText
    UI.trackerZoneIdText = zoneIdText
    UI.trackerLootCounterText = lootCounterText
    UI.trackerBossQueueText = bossQueueText
    UI.trackerLogText = logText
    UI.trackerLogLines = { "No loot detected" }

    frame:SetScript("OnUpdate", function(self, elapsed)
        local activeRun
        local currentDungeon
        local remainingSeconds
        local bossTimer
        local pendingBossQueue
        local pendingBossNames
        local queueEntry
        local zoneId

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

        if UI.trackerBossTimerText then
            if bossTimer then
                UI.trackerBossTimerText:SetText(string.format("Boss Timer: %s %ds", bossTimer.boss_name or "-", bossTimer.duration or 0))
            else
                UI.trackerBossTimerText:SetText("Boss Timer: Inactive")
            end
        end

        activeRun = DungeonOracle
            and DungeonOracle.Tracker
            and DungeonOracle.Tracker.state
            and DungeonOracle.Tracker.state.active_run
        currentDungeon = DungeonOracle
            and DungeonOracle.Tracker
            and DungeonOracle.Tracker.state
            and DungeonOracle.Tracker.state.current_dungeon
        zoneId = (activeRun and activeRun.zone_id) or (currentDungeon and currentDungeon.zone_id) or nil

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

        if UI.trackerLootCounterText then
            if activeRun then
                UI.trackerLootCounterText:SetText(string.format(
                    "Green: %d | Blue: %d | Purple: %d",
                    tonumber(activeRun.green_drops) or 0,
                    tonumber(activeRun.blue_drops) or 0,
                    tonumber(activeRun.purple_drops) or 0
                ))
            else
                UI.trackerLootCounterText:SetText("Green: 0 | Blue: 0 | Purple: 0")
            end
        end

        pendingBossQueue = DungeonOracle
            and DungeonOracle.Tracker
            and DungeonOracle.Tracker.GetPendingBossQueue
            and DungeonOracle.Tracker.GetPendingBossQueue()

        if UI.trackerBossQueueText then
            if pendingBossQueue and #pendingBossQueue > 0 then
                pendingBossNames = {}

                for _, queueEntry in ipairs(pendingBossQueue) do
                    pendingBossNames[#pendingBossNames + 1] = queueEntry.boss_name or tostring(queueEntry.boss_id)
                end

                UI.trackerBossQueueText:SetText(string.format("Boss Queue: %s", table.concat(pendingBossNames, ", ")))
            else
                UI.trackerBossQueueText:SetText("Boss Queue: Inactive")
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
        positionTrackerWindow(UI.trackerFrame)
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

    positionTrackerWindow(UI.trackerFrame)
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

    populateSettingsPane(UI.contentPanes[1])
    populateUploadInstructionsPane(UI.contentPanes[2])

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
    UI.RefreshUploadInstructionsPane()

    UI.isInitialized = true
end
