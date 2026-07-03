-- ShadowfangKeep.lua defines the static dungeon metadata used by the addon.

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
DungeonOracleData.dungeons.shadowfang_keep = {
    id = "shadowfang_keep",
    name = "Shadowfang Keep",
    bosses = {
        -- Shadowfang Keep tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 3914,
            name = "Rethilgore",
            recorded_loot = {
                -- no loot to be rolled
            },
        },
        {
            id = 3865,
            name = "Fel Steed",
            recorded_loot = {
                [6341] = true, -- Eerie Stable Lantern
            },
        },
        {
            id = 3864,
            name = "Shadow Charger",
            recorded_loot = {
                [6341] = true, -- Eerie Stable Lantern
            },
        },
        {
            id = 3886,
            name = "Razorclaw the Butcher",
            recorded_loot = {
                [1292] = true, -- Butcher's Cleaver
                [6226] = true, -- Bloody Apron
                [6633] = true, -- Butcher's Slicer
            },
        },
        {
            id = 3887,
            name = "Baron Silverlaine",
            recorded_loot = {
                [6321] = true, -- Silverlaine's Family Seal
                [6323] = true, -- Baron's Scepter
            },
        },
        {
            id = 4278,
            name = "Commander Springvale",
            recorded_loot = {
                [6320] = true, -- Commander's Crest
                [3191] = true, -- Arced War Axe
            },
        },
        {
            id = 4279,
            name = "Odo the Blindwatcher",
            recorded_loot = {
                [6318] = true, -- Odo's Ley Staff
                [6319] = true, -- Girdle of the Blindwatcher
            },
        },
        {
            id = 3872,
            name = "Deathsworn Captain",
            recorded_loot = {
                [6642] = true, -- Phantom Armor
                [6641] = true, -- Haunting Blade
            },
        },
        {
            id = 4274,
            name = "Fenrus the Devourer",
            recorded_loot = {
                [6340] = true, -- Fenrus' Hide
                [3230] = true, -- Black Wolf Bracers
            },
        },
        {
            id = 3927,
            name = "Wolf Master Nandos",
            recorded_loot = {
                [3748] = true, -- Feline Mantle
                [6314] = true, -- Wolfmaster Cape
            },
        },
        {
            id = 4275,
            name = "Archmage Arugal",
            recorded_loot = {
                [6324] = true, -- Robes of Arugal
                [6392] = true, -- Belt of Arugal
                [6220] = true, -- Meteor Shard
            },
        },
    },
}
