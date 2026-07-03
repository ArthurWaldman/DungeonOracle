-- Tracker.lua owns the first stage of the rebuilt dungeon algorithm.
--
-- Implemented here:
-- 1. identify when the player is inside a supported dungeon
-- 2. ask other addon users for shared dungeon state on instance entry
-- 3. wait briefly for peer replies before making a local reactivation decision
-- 4. keep the real game-provided instance_id as the fallback source of truth
-- 5. reactivate an existing run when dungeon_name and instance_id match
-- 6. complete an existing active run whenever the player enters a different supported dungeon context
-- 7. complete an active run after the player has been outside all instances for 30 minutes
-- 8. wait for the first combat entry before starting a run
-- 9. create and share run_id, dungeon_name, and started_at
--
-- Not implemented here yet:
-- - run end conditions beyond dungeon transitions and the outside-instance timeout
-- - boss timing
-- - loot mapping
-- - death tracking
-- - party snapshots

DungeonOracle = DungeonOracle or {}
DungeonOracle.Tracker = DungeonOracle.Tracker or {}

local Tracker = DungeonOracle.Tracker

local TRACKER_EVENTS = {
    "PLAYER_ENTERING_WORLD",
    "ZONE_CHANGED_NEW_AREA",
    "PLAYER_REGEN_DISABLED",
    "CHAT_MSG_ADDON",
}

local ADDON_MESSAGE_PREFIX = "DungeonOracle"
local MESSAGE_TYPE_REQUEST_ACTIVE_RUN = "REQUEST_ACTIVE_RUN"
local MESSAGE_TYPE_SHARE_ACTIVE_RUN = "SHARE_ACTIVE_RUN"
local MESSAGE_TYPE_REQUEST_INSTANCE_ID = "REQUEST_INSTANCE_ID"
local MESSAGE_TYPE_SHARE_INSTANCE_ID = "SHARE_INSTANCE_ID"
local ENTRY_SYNC_WINDOW_SECONDS = 2
local OUTSIDE_INSTANCE_TIMEOUT_SECONDS = 1800

Tracker.state = Tracker.state or nil

-- Returns the initial runtime state for the tracker.
local function createInitialState()
    return {
        current_dungeon = nil,
        active_run = nil,
        entry_sync = nil,
        outside_instance_token = nil,
    }
end

-- Sends all tracker status messages through the bootstrap print helper so chat
-- formatting remains consistent across modules.
local function printMessage(message)
    if DungeonOracle.PrintMessage then
        DungeonOracle.PrintMessage(message)
    end
end

-- Persists the active_run snapshot whenever tracker-owned metadata changes.
local function persistActiveRun()
    if DungeonOracle.Database and DungeonOracle.Database.SetActiveRun then
        DungeonOracle.Database.SetActiveRun(Tracker.state.active_run)
    end
end

-- Produces a simple UUID-like identifier that is sufficient for run identity.
local function createRunId()
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    local seed = tostring(time()) .. tostring(math.random(100000, 999999))
    local cursor = 1

    return string.gsub(template, "[xy]", function(token)
        local sourceByte = string.byte(seed, cursor) or math.random(48, 102)
        local nibble = sourceByte % 16

        cursor = cursor + 1

        if token == "x" then
            return string.format("%x", nibble)
        end

        return string.format("%x", (nibble % 4) + 8)
    end)
end

-- Normalizes dungeon names so formatting differences do not break matching.
local function normalizeDungeonName(name)
    if not name then
        return nil
    end

    name = string.lower(name)
    name = string.gsub(name, "^the%s+", "")
    name = string.gsub(name, "[^%w]", "")

    return name
end

-- Returns the current instance identity when the player is inside an instance.
local function getCurrentInstanceInfo()
    local inInstance = IsInInstance()

    if not inInstance then
        return nil
    end

    local instanceName, instanceType, _, _, _, _, _, instanceId = GetInstanceInfo()

    return {
        name = instanceName,
        type = instanceType,
        id = instanceId,
        mapId = C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player") or nil,
    }
end

-- Looks up the static dungeon definition for the current instance.
local function getDungeonDefinition(instanceInfo)
    local normalizedInstanceName
    local mapIdMatch = nil

    if not instanceInfo or not DungeonOracleData or not DungeonOracleData.dungeons then
        return nil
    end

    normalizedInstanceName = normalizeDungeonName(instanceInfo.name)

    for _, dungeon in pairs(DungeonOracleData.dungeons) do
        if dungeon.name and normalizeDungeonName(dungeon.name) == normalizedInstanceName then
            return dungeon
        end

        if dungeon.aliases then
            for _, aliasName in ipairs(dungeon.aliases) do
                if normalizeDungeonName(aliasName) == normalizedInstanceName then
                    return dungeon
                end
            end
        end

        if not mapIdMatch and dungeon.map_id and instanceInfo.mapId and dungeon.map_id == instanceInfo.mapId then
            mapIdMatch = dungeon
        end
    end

    return mapIdMatch
end

-- Returns the current group addon-message channel, if one exists.
local function getCommunicationChannel()
    if IsInRaid() then
        return "RAID"
    end

    if IsInGroup() then
        return "PARTY"
    end

    return nil
end

-- Sends a compact addon message using a tab-delimited payload so tracker state
-- exchanges stay easy to extend.
local function sendAddonMessage(messageType, ...)
    local channel = getCommunicationChannel()
    local payload = { messageType }
    local values = { ... }
    local index

    if not channel or not C_ChatInfo or not C_ChatInfo.SendAddonMessage then
        return
    end

    for index = 1, #values do
        payload[#payload + 1] = tostring(values[index] or "")
    end

    C_ChatInfo.SendAddonMessage(ADDON_MESSAGE_PREFIX, table.concat(payload, "\t"), channel)
end

-- Clears any in-flight entry sync attempt. A token is used so stale timers from
-- older dungeon-entry events cannot apply decisions after the player has moved.
local function clearEntrySync()
    Tracker.state.entry_sync = nil
end

-- Clears any in-flight outside-instance timeout. A token is used so stale
-- timers cannot complete runs after the player has returned.
local function clearOutsideInstanceTimeout()
    Tracker.state.outside_instance_token = nil

    if Tracker.state.active_run and Tracker.state.active_run.outside_instance_started_at then
        Tracker.state.active_run.outside_instance_started_at = nil
        persistActiveRun()
    end
end

-- Stores the current resolved instance identifier on the dungeon context.
-- If no peer response is available, the game's live instance_id remains the
-- value that gets used.
local function resolveCurrentInstanceId(sharedInstanceId)
    local actualInstanceId

    if not Tracker.state.current_dungeon then
        return nil
    end

    actualInstanceId = Tracker.state.current_dungeon.actual_instance_id
    if not actualInstanceId then
        return nil
    end

    if sharedInstanceId and sharedInstanceId == actualInstanceId then
        Tracker.state.current_dungeon.instance_id = sharedInstanceId
    else
        Tracker.state.current_dungeon.instance_id = actualInstanceId
    end

    return Tracker.state.current_dungeon.instance_id
end

-- Stores the active run in memory and persists the same state into the
-- database layer so later rebuild steps can rely on one shared shape.
local function setActiveRun(runId, dungeonName, instanceId, startedAt)
    Tracker.state.active_run = {
        run_id = runId,
        dungeon_name = dungeonName,
        instance_id = instanceId,
        started_at = startedAt,
        outside_instance_started_at = nil,
    }

    persistActiveRun()
end

-- Restores a locally known run into tracker state when the player enters the
-- same dungeon instance again.
local function reactivateKnownRunByInstance(dungeonName, instanceId)
    local existingRun

    if not DungeonOracle.Database or not DungeonOracle.Database.ReactivateRunByInstance then
        return false
    end

    existingRun = DungeonOracle.Database.ReactivateRunByInstance(dungeonName, instanceId)
    if not existingRun then
        return false
    end

    Tracker.state.active_run = {
        run_id = existingRun.run_id,
        dungeon_name = existingRun.dungeon_name or dungeonName,
        instance_id = existingRun.instance_id or instanceId,
        started_at = existingRun.started_at,
        outside_instance_started_at = nil,
    }

    persistActiveRun()
    return true
end

-- Clears local active-run state when the tracker truly needs to drop it.
local function clearActiveRun()
    Tracker.state.active_run = nil

    if DungeonOracle.Database and DungeonOracle.Database.ClearActiveRun then
        DungeonOracle.Database.ClearActiveRun()
    end
end

-- Completes the current active run after the player has remained outside all
-- instances for 30 minutes.
local function finalizeOutsideInstanceTimeout(timeoutToken)
    local activeRun = Tracker.state.active_run

    if not activeRun or Tracker.state.outside_instance_token ~= timeoutToken or Tracker.state.current_dungeon then
        return
    end

    Tracker.state.outside_instance_token = nil

    if DungeonOracle.Database and DungeonOracle.Database.CompleteActiveRun then
        DungeonOracle.Database.CompleteActiveRun(time())
    elseif DungeonOracle.Database and DungeonOracle.Database.ClearActiveRun then
        DungeonOracle.Database.ClearActiveRun()
    end

    Tracker.state.active_run = nil
    printMessage("previous run completed after being outside all instances for 30 minutes.")
end

-- Starts or resumes the 30-minute outside-instance timeout for the current
-- active run. If the timeout already elapsed while the addon was inactive, the
-- run is completed immediately on the next relevant event.
local function beginOutsideInstanceTimeout()
    local activeRun = Tracker.state.active_run
    local outsideStartedAt
    local remainingSeconds
    local timeoutToken

    if not activeRun then
        return
    end

    outsideStartedAt = activeRun.outside_instance_started_at or time()
    activeRun.outside_instance_started_at = outsideStartedAt
    persistActiveRun()

    remainingSeconds = OUTSIDE_INSTANCE_TIMEOUT_SECONDS - (time() - outsideStartedAt)
    if remainingSeconds <= 0 then
        finalizeOutsideInstanceTimeout(Tracker.state.outside_instance_token)
        return
    end

    timeoutToken = string.format("outside-%d-%d", time(), math.random(100000, 999999))
    Tracker.state.outside_instance_token = timeoutToken

    if C_Timer and C_Timer.After then
        C_Timer.After(remainingSeconds, function()
            finalizeOutsideInstanceTimeout(timeoutToken)
        end)
    else
        finalizeOutsideInstanceTimeout(timeoutToken)
    end
end

-- Completes the current active run when the player enters a different
-- supported dungeon context. That includes either a different instance of the
-- same dungeon or a completely different dungeon.
local function completeActiveRunForDungeonTransition()
    local activeRun = Tracker.state.active_run
    local currentDungeon = Tracker.state.current_dungeon
    local sameDungeon
    local sameInstance

    if not activeRun or not currentDungeon then
        return false
    end

    sameDungeon = normalizeDungeonName(activeRun.dungeon_name) == normalizeDungeonName(currentDungeon.name)
    sameInstance = activeRun.instance_id and activeRun.instance_id == currentDungeon.instance_id

    if sameDungeon and sameInstance then
        return false
    end

    clearEntrySync()
    Tracker.state.outside_instance_token = nil

    if DungeonOracle.Database and DungeonOracle.Database.CompleteActiveRun then
        DungeonOracle.Database.CompleteActiveRun(time())
    elseif DungeonOracle.Database and DungeonOracle.Database.ClearActiveRun then
        DungeonOracle.Database.ClearActiveRun()
    end

    Tracker.state.active_run = nil

    if sameDungeon then
        printMessage(string.format("previous run completed because a new %s instance was entered.", currentDungeon.name))
    else
        printMessage(string.format("previous run completed because %s was entered.", currentDungeon.name))
    end

    return true
end

-- Refreshes the current dungeon context from the player's location.
local function updateCurrentDungeon()
    local instanceInfo = getCurrentInstanceInfo()
    local dungeonDefinition = getDungeonDefinition(instanceInfo)

    if dungeonDefinition then
        Tracker.state.current_dungeon = {
            id = dungeonDefinition.id,
            name = dungeonDefinition.name,
            instance_id = instanceInfo.id,
            actual_instance_id = instanceInfo.id,
        }
        clearOutsideInstanceTimeout()
    else
        Tracker.state.current_dungeon = nil
        clearEntrySync()

        if not instanceInfo and Tracker.state.active_run then
            beginOutsideInstanceTimeout()
        end
    end
end

-- Requests the live instance_id from other addon users already inside the same
-- dungeon. Any reply is validated against the real game-provided instance_id.
local function requestSharedInstanceId()
    if not Tracker.state.current_dungeon then
        return
    end

    sendAddonMessage(MESSAGE_TYPE_REQUEST_INSTANCE_ID, Tracker.state.current_dungeon.name)
end

-- Requests the shared start state from other addon users already inside the
-- dungeon. This is used when the local player enters after the run has begun.
local function requestActiveRunState()
    if not Tracker.state.current_dungeon or Tracker.state.active_run then
        return
    end

    sendAddonMessage(MESSAGE_TYPE_REQUEST_ACTIVE_RUN, Tracker.state.current_dungeon.name)
end

-- Starts the run the first time this addon user enters combat inside a
-- supported dungeon, then shares the start details with the group.
local function startRunFromCombat()
    local startedAt
    local runId

    if not Tracker.state.current_dungeon or Tracker.state.active_run or Tracker.state.entry_sync then
        return
    end

    startedAt = time()
    runId = createRunId()

    setActiveRun(
        runId,
        Tracker.state.current_dungeon.name,
        Tracker.state.current_dungeon.instance_id,
        startedAt
    )
    printMessage(string.format("run started for %s.", Tracker.state.current_dungeon.name))
    sendAddonMessage(
        MESSAGE_TYPE_SHARE_ACTIVE_RUN,
        runId,
        Tracker.state.current_dungeon.name,
        startedAt
    )
end

-- Completes the entry-sync phase after the peer reply window closes. At that
-- point we fall back to the real game state if nobody answered, try local
-- reactivation by dungeon_name and instance_id, and only then allow a new run.
local function finalizeEntrySync(syncToken)
    local syncState

    syncState = Tracker.state.entry_sync
    if not syncState or syncState.token ~= syncToken then
        return
    end

    clearEntrySync()
    resolveCurrentInstanceId(nil)

    if not Tracker.state.active_run and Tracker.state.current_dungeon then
        if reactivateKnownRunByInstance(
            Tracker.state.current_dungeon.name,
            Tracker.state.current_dungeon.instance_id
        ) then
            printMessage(string.format("reactivated run for %s.", Tracker.state.current_dungeon.name))
        elseif InCombatLockdown and InCombatLockdown() then
            startRunFromCombat()
        end
    end
end

-- Starts a short peer-sync window on dungeon entry so the addon can ask first
-- and decide afterward, instead of making a local decision immediately.
local function beginEntrySync()
    local syncToken

    if not Tracker.state.current_dungeon or Tracker.state.active_run then
        return
    end

    syncToken = string.format("%d-%d", time(), math.random(100000, 999999))
    Tracker.state.entry_sync = {
        token = syncToken,
        dungeon_name = Tracker.state.current_dungeon.name,
    }

    requestSharedInstanceId()
    requestActiveRunState()

    if C_Timer and C_Timer.After then
        C_Timer.After(ENTRY_SYNC_WINDOW_SECONDS, function()
            finalizeEntrySync(syncToken)
        end)
    else
        finalizeEntrySync(syncToken)
    end
end

-- Responds to peer requests and accepts shared tracker state from other addon
-- users in the same dungeon.
local function handleAddonMessage(prefix, message)
    local messageType
    local firstValue
    local secondValue
    local thirdValue
    local runId
    local dungeonName
    local startedAt
    local sharedInstanceId

    if prefix ~= ADDON_MESSAGE_PREFIX or not message or not Tracker.state.current_dungeon then
        return
    end

    messageType, firstValue, secondValue, thirdValue = strsplit("\t", message)

    if messageType == MESSAGE_TYPE_REQUEST_INSTANCE_ID then
        dungeonName = firstValue

        if dungeonName
            and dungeonName ~= ""
            and normalizeDungeonName(dungeonName) == normalizeDungeonName(Tracker.state.current_dungeon.name) then
            sendAddonMessage(
                MESSAGE_TYPE_SHARE_INSTANCE_ID,
                Tracker.state.current_dungeon.name,
                Tracker.state.current_dungeon.instance_id
            )
        end

        return
    end

    if messageType == MESSAGE_TYPE_SHARE_INSTANCE_ID then
        dungeonName = firstValue
        sharedInstanceId = tonumber(secondValue)

        if not dungeonName or dungeonName == "" then
            return
        end

        if normalizeDungeonName(dungeonName) ~= normalizeDungeonName(Tracker.state.current_dungeon.name) then
            return
        end

        resolveCurrentInstanceId(sharedInstanceId)
        return
    end

    runId = firstValue
    dungeonName = secondValue
    startedAt = thirdValue

    if not dungeonName or dungeonName == "" then
        return
    end

    if normalizeDungeonName(dungeonName) ~= normalizeDungeonName(Tracker.state.current_dungeon.name) then
        return
    end

    if messageType == MESSAGE_TYPE_REQUEST_ACTIVE_RUN then
        if Tracker.state.active_run then
            sendAddonMessage(
                MESSAGE_TYPE_SHARE_ACTIVE_RUN,
                Tracker.state.active_run.run_id,
                Tracker.state.active_run.dungeon_name,
                Tracker.state.active_run.started_at
            )
        end
    elseif messageType == MESSAGE_TYPE_SHARE_ACTIVE_RUN then
        if Tracker.state.active_run or not runId or runId == "" then
            return
        end

        startedAt = tonumber(startedAt)
        if not startedAt then
            return
        end

        setActiveRun(runId, dungeonName, Tracker.state.current_dungeon.instance_id, startedAt)
        printMessage(string.format("adopted active run for %s.", dungeonName))
    end
end

function Tracker.Initialize(eventFrame)
    local persistedActiveRun

    if Tracker.is_initialized then
        return
    end

    if DungeonOracle.Database and DungeonOracle.Database.Initialize then
        DungeonOracle.Database.Initialize()
    end

    if C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then
        C_ChatInfo.RegisterAddonMessagePrefix(ADDON_MESSAGE_PREFIX)
    end

    Tracker.event_frame = eventFrame
    Tracker.state = createInitialState()

    if DungeonOracle.Database and DungeonOracle.Database.GetActiveRun then
        persistedActiveRun = DungeonOracle.Database.GetActiveRun()
        if persistedActiveRun then
            Tracker.state.active_run = persistedActiveRun
        end
    end

    for _, eventName in ipairs(TRACKER_EVENTS) do
        eventFrame:RegisterEvent(eventName)
    end

    Tracker.is_initialized = true
end

-- Public: central event entry point for the current first-combat start logic.
function Tracker.HandleEvent(event, ...)
    if event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
        updateCurrentDungeon()
        completeActiveRunForDungeonTransition()

        if Tracker.state.current_dungeon and not Tracker.state.active_run then
            beginEntrySync()
        end
    elseif event == "PLAYER_REGEN_DISABLED" then
        startRunFromCombat()
    elseif event == "CHAT_MSG_ADDON" then
        handleAddonMessage(...)
    end
end
