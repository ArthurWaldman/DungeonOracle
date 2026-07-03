-- WailingCaverns.lua defines the static dungeon metadata used by the addon.

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
DungeonOracleData.dungeons.wailing_caverns = {
    id = "wailing_caverns",
    name = "Wailing Caverns",
    bosses = {
        -- Wailing Caverns tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 3669,
            name = "Lord Cobrahn",
            recorded_loot = {
                [6460] = true, -- Cobrahn's Grasp
                [10410] = true, -- Leggings of the Fang
                [6465] = true, -- Robe of the Moccasin
            },
        },
        {
            id = 3671,
            name = "Lady Anacondra",
            recorded_loot = {
                [10412] = true, -- Belt of the Fang
            },
        },
        {
            id = 3653,
            name = "Kresh",
            recorded_loot = {
                [13245] = true, -- Kresh's Back
            },
        },
        {
            id = 3670,
            name = "Lord Pythas",
            recorded_loot = {
                [6472] = true, -- Stinging Viper
                [6473] = true, -- Armor of the Fang
            },
        },
        {
            id = 3674,
            name = "Skum",
            recorded_loot = {
                [6449] = true, -- Glowing Lizardscale Cloak
                [6448] = true, -- Tail Spike
            },
        },
        {
            id = 3673,
            name = "Lord Serpentis",
            recorded_loot = {
                [6469] = true, -- Venomstrike
                [5970] = true, -- Serpent Gloves
                [10411] = true, -- Footpads of the Fang
                [6459] = true, -- Savage Trodders
            },
        },
        {
            id = 5775,
            name = "Verdan the Everliving",
            recorded_loot = {
                [6630] = true, -- Seedcloud Buckler
                [6631] = true, -- Living Root
                [6629] = true, -- Sporid Cape
            },
        },
        {
            id = 3654,
            name = "Mutanus the Devourer",
            recorded_loot = {
                [6461] = true, -- Slime-encrusted Pads
                [6627] = true, -- Mutant Scale Breastplate
                [6463] = true, -- Deep Fathom Ring
            },
        },
        {
            id = 5912,
            name = "Deviate Faerie Dragon",
            recorded_loot = {
                [5243] = true, -- Firebelcher
                [6632] = true, -- Feyscale Cloak
            },
        },
    },
}
