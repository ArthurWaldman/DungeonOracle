-- Uldaman.lua defines the static dungeon metadata used by the addon.

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
DungeonOracleData.dungeons.uldaman = {
    id = "uldaman",
    name = "Uldaman",
    map_id = 1337,
    bosses = {
        -- Uldaman tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 6907,
            name = "Eric \"The Swift\"",
            recorded_loot = {
                [9394] = true, -- Horned Viking Helmet
                [9398] = true, -- Worn Running Boots
            },
        },
        {
            id = 6906,
            name = "Baelog",
            recorded_loot = {
                [9401] = true, -- Nordic Longshank
                [9399] = true, -- Precision Arrow
            },
        },
        {
            id = 6908,
            name = "Olaf",
            recorded_loot = {
                [9404] = true, -- Olaf's All Purpose Shield
            },
        },
        {
            id = 6910,
            name = "Revelosh",
            recorded_loot = {
                [9389] = true, -- Revelosh's Spaulders
                [9388] = true, -- Revelosh's Armguards
                [9390] = true, -- Revelosh's Gloves
                [9387] = true, -- Revelosh's Boots
            },
        },
        {
            id = 7228,
            name = "Ironaya",
            recorded_loot = {
                [9409] = true, -- Ironaya's Bracers
                [9407] = true, -- Stoneweaver Leggings
                [9408] = true, -- Ironshod Bludgeon
            },
        },
        {
            id = 7023,
            name = "Obsidian Sentinel",
            recorded_loot = {
                -- no loot to be rolled
            },
        },
        {
            id = 7206,
            name = "Ancient Stone Keeper",
            recorded_loot = {
                [9410] = true, -- Cragfists
                [9411] = true, -- Rockshard Pauldrons
            },
        },
        {
            id = 7291,
            name = "Galgann Firehammer",
            recorded_loot = {
                [11310] = true, -- Flameseer Mantle
                [9412] = true, -- Galgann's Fireblaster
                [11311] = true, -- Emberscale Cape
                [9419] = true, -- Galgann's Firehammer
            },
        },
        {
            id = 4854,
            name = "Grimlok",
            recorded_loot = {
                [9415] = true, -- Grimlok's Tribal Vestments
                [9416] = true, -- Grimlok's Charge
                [9414] = true, -- Oilskin Leggings
            },
        },
        {
            id = 2748,
            name = "Archaedas",
            recorded_loot = {
                [11118] = true, -- Archaedic Stone
                [9413] = true, -- The Rockpounder
                [9418] = true, -- Stoneslayer
            },
        },
    },
}
