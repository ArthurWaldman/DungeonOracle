-- DungeonOracle.lua is the addon bootstrap.
--
-- Responsibilities here are intentionally small:
-- 1. create the shared addon namespace
-- 2. expose the common chat-print helper
-- 3. register the slash command
-- 4. initialize UI and tracker modules on login
--
-- Runtime dungeon behavior should stay in Core/Tracker.lua, while persistent
-- data shape should stay in Core/Database.lua.

DungeonOracle = DungeonOracle or {}

local eventFrame = CreateFrame("Frame")

-- Slash commands are kept thin and simply delegate to the UI module.
local function handleSlashCommand()
    if DungeonOracle.UI and DungeonOracle.UI.ToggleMainWindow then
        DungeonOracle.UI.ToggleMainWindow()
    end
end

SLASH_DUNGEONORACLE1 = "/dungeonoracle"
SlashCmdList.DUNGEONORACLE = handleSlashCommand

eventFrame:RegisterEvent("PLAYER_LOGIN")

-- PLAYER_LOGIN performs one-time startup. All later events are forwarded to the
-- tracker so dungeon logic can remain isolated from bootstrap concerns.
eventFrame:SetScript("OnEvent", function(_, event, ...)
    if event == "PLAYER_LOGIN" then
        if DungeonOracle.UI and DungeonOracle.UI.Initialize then
            DungeonOracle.UI.Initialize()
        end

        if DungeonOracle.Tracker and DungeonOracle.Tracker.Initialize then
            DungeonOracle.Tracker.Initialize(eventFrame)
        end
    elseif DungeonOracle.Tracker and DungeonOracle.Tracker.HandleEvent then
        DungeonOracle.Tracker.HandleEvent(event, ...)
    end
end)
