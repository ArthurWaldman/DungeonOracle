-- RagefireChasm.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

-- Dungeon schema:
-- {
--     id = "internal-key",
--     name = "Dungeon Name",
--     bosses = {
--         {
--             id = 123,
--             name = "Boss Name",
--             recorded_loot = {
--                 [456] = true,
--             },
--         },
--     },
-- }
--
-- Notes:
-- - id is the addon's internal dungeon identifier.
-- - name should match the player-facing dungeon name we want in exports.
-- - bosses must include every boss we want to track for this dungeon.
-- - boss.id is the NPC ID used for combat-log encounter matching.
-- - recorded_loot is a set of item IDs we explicitly care about for this boss.
DungeonOracleData.dungeons.ragefire_chasm = {
    id = "ragefire_chasm",
    name = "Ragefire Chasm",
    bosses = {
        -- Ragefire Chasm tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 11520,
            name = "Taragaman the Hungerer",
            recorded_loot = {
                [14149] = true, -- Subterranean Cape
                [14148] = true, -- Crystalline Cuffs
                [14145] = true, -- Cursed Felblade
            },
        },
        {
            id = 11518,
            name = "Jergosh the Invoker",
            recorded_loot = {
                [14150] = true, -- Robe of Evocation
                [14147] = true, -- Cavedweller Bracers
                [14151] = true, -- Chanting Blade
            },
        },
    },
}
