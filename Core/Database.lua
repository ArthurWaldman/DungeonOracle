-- Database.lua stores the minimal SavedVariables used by the current tracker:
-- settings, one active run, and completed records.

DungeonOracle = DungeonOracle or {}
DungeonOracle.Database = DungeonOracle.Database or {}

-- Current SavedVariables write-out shape:
-- DungeonOracleDB = {
--     settings = {
--         show_minimap_button = true,
--         show_tracker_window = true,
--     },
--     active_run = {
--         dungeon_name = "The Stockade",
--         run_id = "17832434-8261-4444-9894-c5a70c25cc54",
--         zone_id = 13936,
--         started_at = 1783243482,
--         outside_instance_started_at = 1783243487,
--         hardcore = false,
--         party = {
--             {
--                 name = "Player-Realm",
--                 class = "WARRIOR",
--                 level = 60.5,
--                 role = "TANK",
--             },
--             {
--                 name = "Mage-Realm",
--                 class = "MAGE",
--                 level = 60,
--                 role = "DAMAGER",
--             },
--         },
--         replacements = 0,
--         deaths = {
--             {
--                 class = "WARRIOR",
--                 level = 28,
--             },
--         },
--         first_death = {
--             timestamp = 95, -- death time - start time
--             num_bosses_beaten = 2,
--             class = "WARRIOR",
--         },
--         boss_timer = {
--             {
--                 boss_id = 1716,
--                 duration = 42, -- -1 means the timer failed after spirit release
--             },
--         },
--         boss_loot = {
--             [1716] = 5191, -- -1 means no tracked loot was resolved before the run ended
--         },
--         green_drops = 3,
--         blue_drops = 1,
--         purple_drops = 0,
--         pending_boss_loot_queue = {
--             1716,
--         },
--     },
--     records = {
--         {
--             dungeon_name = "The Stockade",
--             run_id = "17832434-6632-4837-82c5-5da85f75b6a6",
--             zone_id = 13912,
--             started_at = 1783243466,
--             outside_instance_started_at = 1783243471,
--             ended_at = 1783243482,
--             hardcore = false,
--             party = {
--                 {
--                     name = "Player-Realm",
--                     class = "WARRIOR",
--                     level = 60.5,
--                     role = "TANK",
--                 },
--                 {
--                     name = "Mage-Realm",
--                     class = "MAGE",
--                     level = 60,
--                     role = "DAMAGER",
--                 },
--             },
--             replacements = 0,
--             deaths = {
--                 {
--                     class = "WARRIOR",
--                     level = 28,
--                 },
--             },
--             first_death = {
--                 timestamp = 95, -- death time - start time
--                 num_bosses_beaten = 2,
--                 class = "WARRIOR",
--             },
--             boss_timer = {
--                 {
--                     boss_id = 1716,
--                     duration = 42, -- -1 means the timer failed after spirit release
--                 },
--             },
--             boss_loot = {
--                 [1716] = 5191, -- -1 means no tracked loot was resolved before the run ended
--             },
--             green_drops = 3,
--             blue_drops = 1,
--             purple_drops = 0,
--         },
--     },
-- }

DungeonOracleDB = DungeonOracleDB or {
    settings = {
        show_minimap_button = true,
        show_tracker_window = true,
    },
    active_run = nil,
    records = {},
}

local Database = DungeonOracle.Database

-- Copies the party snapshot so nested member tables do not get shared across
-- active and archived run objects.
local function copyPartySnapshot(party)
    local copy = {}
    local index
    local member

    if not party then
        return copy
    end

    for index, member in ipairs(party) do
        copy[index] = {
            name = member.name,
            class = member.class,
            level = member.level,
            role = member.role,
        }
    end

    return copy
end

-- Copies the death snapshot list so archived and active runs do not share the
-- same nested tables.
local function copyDeathsSnapshot(deaths)
    local copy = {}
    local index
    local deathEntry

    if not deaths then
        return copy
    end

    for index, deathEntry in ipairs(deaths) do
        copy[index] = {
            class = deathEntry.class,
            level = deathEntry.level,
        }
    end

    return copy
end

local function copyFirstDeathSnapshot(firstDeath)
    if not firstDeath then
        return nil
    end

    return {
        timestamp = firstDeath.timestamp,
        num_bosses_beaten = firstDeath.num_bosses_beaten,
        class = firstDeath.class,
    }
end

-- Copies the boss timer list so completed and active runs do not share nested
-- timer entries.
local function copyBossTimerSnapshot(bossTimer)
    local copy = {}
    local index
    local timerEntry

    if not bossTimer then
        return copy
    end

    for index, timerEntry in ipairs(bossTimer) do
        copy[index] = {
            boss_id = timerEntry.boss_id,
            duration = timerEntry.duration,
        }
    end

    return copy
end

-- Copies the boss loot map so active and archived runs do not share the same
-- mutable boss-to-loot table.
local function copyBossLootSnapshot(bossLoot)
    local copy = {}
    local bossId
    local lootId

    if not bossLoot then
        return copy
    end

    for bossId, lootId in pairs(bossLoot) do
        copy[bossId] = lootId
    end

    return copy
end

-- Copies the pending boss loot queue so the unresolved boss state can survive
-- reloads while a run is still active.
local function copyPendingBossLootQueueSnapshot(queue)
    local copy = {}
    local index
    local bossId

    if not queue then
        return copy
    end

    for index, bossId in ipairs(queue) do
        copy[index] = bossId
    end

    return copy
end

local function hasAnyArrayEntries(values)
    if type(values) ~= "table" then
        return false
    end

    return next(values) ~= nil
end

-- Normalizes the replacements counter so the database always stores a
-- non-negative integer.
local function sanitizeReplacementCount(replacements)
    replacements = tonumber(replacements) or 0

    if replacements < 0 then
        return 0
    end

    return replacements
end

-- Normalizes the hardcore flag so the saved run always contains an explicit
-- true/false value instead of nil.
local function sanitizeHardcoreFlag(hardcore)
    return hardcore == true
end

local function sanitizeDropCount(value)
    value = tonumber(value) or 0

    if value < 0 then
        return 0
    end

    return math.floor(value)
end

local function copyRunSnapshot(runRecord)
    if not runRecord then
        return nil
    end

    return {
        dungeon_name = runRecord.dungeon_name,
        run_id = runRecord.run_id,
        zone_id = runRecord.zone_id,
        started_at = runRecord.started_at,
        outside_instance_started_at = runRecord.outside_instance_started_at,
        ended_at = runRecord.ended_at,
        hardcore = sanitizeHardcoreFlag(runRecord.hardcore),
        party = copyPartySnapshot(runRecord.party),
        replacements = sanitizeReplacementCount(runRecord.replacements),
        deaths = copyDeathsSnapshot(runRecord.deaths),
        first_death = copyFirstDeathSnapshot(runRecord.first_death),
        boss_timer = copyBossTimerSnapshot(runRecord.boss_timer),
        boss_loot = copyBossLootSnapshot(runRecord.boss_loot),
        green_drops = sanitizeDropCount(runRecord.green_drops),
        blue_drops = sanitizeDropCount(runRecord.blue_drops),
        purple_drops = sanitizeDropCount(runRecord.purple_drops),
        pending_boss_loot_queue = copyPendingBossLootQueueSnapshot(runRecord.pending_boss_loot_queue),
    }
end

-- Returns a shallow copy so archived runs are not later mutated through the
-- active_run reference.
local function copyTable(source)
    local copy = {}
    local key
    local value

    if not source then
        return copy
    end

    for key, value in pairs(source) do
        copy[key] = value
    end

    return copy
end

-- Removes the first completed record whose run_id matches the requested value.
-- This lets reactivation move a stored run back into active_run cleanly.
local function removeRecordByRunId(runId)
    local index
    local record

    if not runId or runId == "" then
        return nil
    end

    for index = #DungeonOracleDB.records, 1, -1 do
        record = DungeonOracleDB.records[index]
        if record and record.run_id == runId then
            table.remove(DungeonOracleDB.records, index)
            return record
        end
    end

    return nil
end

-- Rebuilds a completed record in a fixed key order so SavedVariables output is
-- easier to scan during testing.
local function createOrderedCompletedRun(activeRun, endedAt)
    return {
        dungeon_name = activeRun.dungeon_name,
        run_id = activeRun.run_id,
        zone_id = activeRun.zone_id,
        started_at = activeRun.started_at,
        outside_instance_started_at = activeRun.outside_instance_started_at,
        ended_at = endedAt or time(),
        hardcore = sanitizeHardcoreFlag(activeRun.hardcore),
        party = copyPartySnapshot(activeRun.party),
        replacements = sanitizeReplacementCount(activeRun.replacements),
        deaths = copyDeathsSnapshot(activeRun.deaths),
        first_death = copyFirstDeathSnapshot(activeRun.first_death),
        boss_timer = copyBossTimerSnapshot(activeRun.boss_timer),
        boss_loot = copyBossLootSnapshot(activeRun.boss_loot),
        green_drops = sanitizeDropCount(activeRun.green_drops),
        blue_drops = sanitizeDropCount(activeRun.blue_drops),
        purple_drops = sanitizeDropCount(activeRun.purple_drops),
    }
end

-- Public: ensures the top-level SavedVariables structure exists.
function Database.Initialize()
    DungeonOracleDB = DungeonOracleDB or {}
    DungeonOracleDB.settings = DungeonOracleDB.settings or {
        show_minimap_button = true,
        show_tracker_window = true,
    }
    DungeonOracleDB.records = DungeonOracleDB.records or {}
end

-- Public: reads one stored addon setting, returning nil when it does not
-- exist so callers can apply their own defaults.
function Database.GetSetting(settingName)
    Database.Initialize()

    if not settingName or settingName == "" then
        return nil
    end

    return DungeonOracleDB.settings[settingName]
end

-- Public: writes one stored addon setting.
function Database.SetSetting(settingName, value)
    Database.Initialize()

    if not settingName or settingName == "" then
        return
    end

    DungeonOracleDB.settings[settingName] = value
end

-- Public: stores the current shared run-start state.
function Database.SetActiveRun(activeRun)
    Database.Initialize()

    if activeRun then
        DungeonOracleDB.active_run = {
            dungeon_name = activeRun.dungeon_name,
            run_id = activeRun.run_id,
            zone_id = activeRun.zone_id,
            started_at = activeRun.started_at,
            outside_instance_started_at = activeRun.outside_instance_started_at,
            hardcore = sanitizeHardcoreFlag(activeRun.hardcore),
            party = copyPartySnapshot(activeRun.party),
            replacements = sanitizeReplacementCount(activeRun.replacements),
            deaths = copyDeathsSnapshot(activeRun.deaths),
            first_death = copyFirstDeathSnapshot(activeRun.first_death),
            boss_timer = copyBossTimerSnapshot(activeRun.boss_timer),
            boss_loot = copyBossLootSnapshot(activeRun.boss_loot),
            green_drops = sanitizeDropCount(activeRun.green_drops),
            blue_drops = sanitizeDropCount(activeRun.blue_drops),
            purple_drops = sanitizeDropCount(activeRun.purple_drops),
            pending_boss_loot_queue = copyPendingBossLootQueueSnapshot(activeRun.pending_boss_loot_queue),
        }
    else
        DungeonOracleDB.active_run = nil
    end

    if activeRun and activeRun.run_id then
        removeRecordByRunId(activeRun.run_id)
    end
end

-- Public: returns the current shared run-start state, if present.
function Database.GetActiveRun()
    Database.Initialize()

    if not DungeonOracleDB.active_run then
        return nil
    end

    return {
        dungeon_name = DungeonOracleDB.active_run.dungeon_name,
        run_id = DungeonOracleDB.active_run.run_id,
        zone_id = DungeonOracleDB.active_run.zone_id,
        started_at = DungeonOracleDB.active_run.started_at,
        outside_instance_started_at = DungeonOracleDB.active_run.outside_instance_started_at,
        hardcore = sanitizeHardcoreFlag(DungeonOracleDB.active_run.hardcore),
        party = copyPartySnapshot(DungeonOracleDB.active_run.party),
        replacements = sanitizeReplacementCount(DungeonOracleDB.active_run.replacements),
        deaths = copyDeathsSnapshot(DungeonOracleDB.active_run.deaths),
        first_death = copyFirstDeathSnapshot(DungeonOracleDB.active_run.first_death),
        boss_timer = copyBossTimerSnapshot(DungeonOracleDB.active_run.boss_timer),
        boss_loot = copyBossLootSnapshot(DungeonOracleDB.active_run.boss_loot),
        green_drops = sanitizeDropCount(DungeonOracleDB.active_run.green_drops),
        blue_drops = sanitizeDropCount(DungeonOracleDB.active_run.blue_drops),
        purple_drops = sanitizeDropCount(DungeonOracleDB.active_run.purple_drops),
        pending_boss_loot_queue = copyPendingBossLootQueueSnapshot(DungeonOracleDB.active_run.pending_boss_loot_queue),
    }
end

-- Public: returns the number of completed records currently stored.
function Database.GetRecordCount()
    Database.Initialize()
    return #DungeonOracleDB.records
end

function Database.GetRecords()
    local records = {}
    local index
    local record

    Database.Initialize()

    for index, record in ipairs(DungeonOracleDB.records) do
        records[index] = copyRunSnapshot(record)
    end

    return records
end

-- Public: returns the locally stored run whose dungeon name matches the
-- player's current dungeon context.
function Database.FindRunByDungeon(dungeonName, zoneId)
    local index
    local record

    Database.Initialize()

    if not dungeonName or dungeonName == "" then
        return nil
    end

    if DungeonOracleDB.active_run
        and DungeonOracleDB.active_run.dungeon_name == dungeonName
        and (not zoneId or DungeonOracleDB.active_run.zone_id == zoneId) then
        return DungeonOracleDB.active_run
    end

    -- Scan newest-first so reactivation prefers the most recent matching run.
    for index = #DungeonOracleDB.records, 1, -1 do
        record = DungeonOracleDB.records[index]
        if record.dungeon_name == dungeonName
            and (not zoneId or record.zone_id == zoneId) then
            return record
        end
    end

    return nil
end

-- Public: restores a previously known run into the active_run slot by using
-- dungeon_name as the reactivation key.
function Database.ReactivateRunByDungeon(dungeonName, zoneId)
    local existingRun = Database.FindRunByDungeon(dungeonName, zoneId)
    local restoredRun

    if not existingRun then
        return nil
    end

    if DungeonOracleDB.active_run and DungeonOracleDB.active_run.run_id == existingRun.run_id then
        return DungeonOracleDB.active_run
    end

    restoredRun = removeRecordByRunId(existingRun.run_id) or existingRun
    restoredRun = copyTable(restoredRun)
    restoredRun.ended_at = nil
    restoredRun.outside_instance_started_at = nil

    DungeonOracleDB.active_run = restoredRun
    return DungeonOracleDB.active_run
end

-- Public: archives the current active run into records as a completed run and
-- then clears the live active_run slot.
function Database.CompleteActiveRun(endedAt)
    local completedRun

    Database.Initialize()

    if not DungeonOracleDB.active_run then
        return nil
    end

    if not hasAnyArrayEntries(DungeonOracleDB.active_run.deaths)
        and not hasAnyArrayEntries(DungeonOracleDB.active_run.boss_timer) then
        DungeonOracleDB.active_run = nil
        return nil
    end

    completedRun = createOrderedCompletedRun(DungeonOracleDB.active_run, endedAt)

    table.insert(DungeonOracleDB.records, completedRun)
    DungeonOracleDB.active_run = nil

    return completedRun
end

-- Public: clears the current shared run-start state.
function Database.ClearActiveRun()
    Database.Initialize()
    DungeonOracleDB.active_run = nil
end

-- Public: clears all completed records while leaving settings intact.
function Database.ClearAllRecords()
    Database.Initialize()
    DungeonOracleDB.records = {}
end
