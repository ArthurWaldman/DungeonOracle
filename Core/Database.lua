-- Database.lua defines the new SavedVariables schema for Dungeon Oracle.
--
-- This file currently implements only the minimal behavior needed for the
-- first stage of the tracking algorithm: initializing the schema and storing
-- the shared active-run start state.

DungeonOracle = DungeonOracle or {}
DungeonOracle.Database = DungeonOracle.Database or {}

-- DungeonOracleDB schema:
-- {
--     settings = {
--         show_minimap_button = true,
--         show_tracker_window = true,
--     },
--     active_run = nil,
--     records = {
--         {
--             run_id = "550e8400-e29b-41d4-a716-446655440000",
--             dungeon_name = "The Deadmines",
--             instance_id = 36,
--             started_at = 0,
--             ended_at = 0,
--             party = {
--                 {
--                     class = "WARRIOR",
--                     level = 20,
--                     role = "TANK",
--                 },
--             },
--             deaths = {
--                 {
--                     player_name = "Player-Realm",
--                     killer_id = 644,
--                 },
--             },
--             replacements = 0,
--             hardcore = true,
--             first_death = {
--                 timestamp = 0,
--                 num_bosses_beaten = 0,
--                 class = "WARRIOR",
--             },
--             boss_timer = {
--                 {
--                     boss_id = 644,
--                     timestamp = 0,
--                 },
--             },
--             boss_loot = {
--                 [644] = 5191,
--             },
--         },
--     },
-- }
--
-- Field notes:
-- - settings: long-lived addon preferences unrelated to a specific run
-- - active_run: temporary snapshot used to preserve an in-progress run
-- - records: completed run exports waiting to be processed elsewhere
-- - instance_id: the game-provided live instance identifier for the run

DungeonOracleDB = DungeonOracleDB or {
    settings = {
        show_minimap_button = true,
        show_tracker_window = true,
    },
    active_run = nil,
    records = {},
}

local Database = DungeonOracle.Database

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

-- Public: ensures the top-level SavedVariables structure exists.
function Database.Initialize()
    DungeonOracleDB = DungeonOracleDB or {}
    DungeonOracleDB.settings = DungeonOracleDB.settings or {
        show_minimap_button = true,
        show_tracker_window = true,
    }
    DungeonOracleDB.active_run = DungeonOracleDB.active_run
    DungeonOracleDB.records = DungeonOracleDB.records or {}
end

-- Public: stores the current shared run-start state.
function Database.SetActiveRun(activeRun)
    Database.Initialize()
    DungeonOracleDB.active_run = activeRun
end

-- Public: returns the current shared run-start state, if present.
function Database.GetActiveRun()
    Database.Initialize()
    return DungeonOracleDB.active_run
end

-- Public: returns the locally stored run whose dungeon and live instance_id
-- match the player's current dungeon context.
function Database.FindRunByInstance(dungeonName, instanceId)
    local record

    Database.Initialize()

    if not dungeonName or dungeonName == "" or not instanceId then
        return nil
    end

    if DungeonOracleDB.active_run
        and DungeonOracleDB.active_run.dungeon_name == dungeonName
        and DungeonOracleDB.active_run.instance_id == instanceId then
        return DungeonOracleDB.active_run
    end

    for _, record in ipairs(DungeonOracleDB.records) do
        if record.dungeon_name == dungeonName
            and record.instance_id == instanceId then
            return record
        end
    end

    return nil
end

-- Public: restores a previously known run into the active_run slot by using
-- dungeon_name and instance_id as the reactivation key.
function Database.ReactivateRunByInstance(dungeonName, instanceId)
    local existingRun = Database.FindRunByInstance(dungeonName, instanceId)

    if not existingRun then
        return nil
    end

    DungeonOracleDB.active_run = existingRun
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

    completedRun = copyTable(DungeonOracleDB.active_run)
    completedRun.ended_at = endedAt or time()

    table.insert(DungeonOracleDB.records, completedRun)
    DungeonOracleDB.active_run = nil

    return completedRun
end

-- Public: clears the current shared run-start state.
function Database.ClearActiveRun()
    Database.Initialize()
    DungeonOracleDB.active_run = nil
end
