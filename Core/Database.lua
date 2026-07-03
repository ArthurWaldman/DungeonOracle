-- Database.lua defines the new SavedVariables schema for Dungeon Oracle.
--
-- This file is schema-only for now. It does not implement the runtime logic
-- that will populate or mutate records during dungeon runs.

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

DungeonOracleDB = DungeonOracleDB or {
    settings = {
        show_minimap_button = true,
        show_tracker_window = true,
    },
    active_run = nil,
    records = {},
}

local Database = DungeonOracle.Database

-- Public: ensures the top-level SavedVariables structure exists.
-- This is the only behavior present right now because the rest of the database
-- logic will be designed around the new tracking algorithm later.
function Database.Initialize()
    DungeonOracleDB = DungeonOracleDB or {}
    DungeonOracleDB.settings = DungeonOracleDB.settings or {
        show_minimap_button = true,
        show_tracker_window = true,
    }
    DungeonOracleDB.active_run = DungeonOracleDB.active_run
    DungeonOracleDB.records = DungeonOracleDB.records or {}
end