-- BlackfathomDeeps.lua defines the static dungeon metadata used by the addon.

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
DungeonOracleData.dungeons.blackfathom_deeps = {
    id = "blackfathom_deeps",
    name = "Blackfathom Deeps",
    bosses = {
        -- Blackfathom Deeps tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 4887,
            name = "Ghamoo-ra",
            recorded_loot = {
                [6907] = true, -- Tortoise Armor
                [6908] = true, -- Ghamoo-ra's Bind
            },
        },
        {
            id = 4831,
            name = "Lady Sarevess",
            recorded_loot = {
                [888] = true, -- Naga Battle Gloves
                [3078] = true, -- Naga Heartpiercer
                [11121] = true, -- Darkwater Talwar
            },
        },
        {
            id = 6243,
            name = "Gelihast",
            recorded_loot = {
                [6906] = true, -- Algae Fists
                [6905] = true, -- Reef Axe
            },
        },
        {
            id = 4832,
            name = "Twilight Lord Kelris",
            recorded_loot = {
                [1155] = true, -- Rod of the Sleepwalker
                [6903] = true, -- Gaze Dreamer Pants
            },
        },
        {
            id = 4830,
            name = "Old Serra'kis",
            recorded_loot = {
                [6901] = true, -- Glowing Thresher Cape
                [6904] = true, -- Bite of Serra'kis
                [6902] = true, -- Bands of Serra'kis
            },
        },
        {
            id = 4829,
            name = "Aku'mai",
            recorded_loot = {
                [6911] = true, -- Moss Cinch
                [6910] = true, -- Leech Pants
                [6909] = true, -- Strike of the Hydra
            },
        },
    },
}
