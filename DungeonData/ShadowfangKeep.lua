-- ShadowfangKeep.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

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
    loot_to_bosses = {
        [6341] = { 3865, 3864 }, -- Eerie Stable Lantern -> Fel Steed, Shadow Charger

        [1292] = { 3886 }, -- Butcher's Cleaver -> Razorclaw the Butcher
        [6226] = { 3886 }, -- Bloody Apron -> Razorclaw the Butcher
        [6633] = { 3886 }, -- Butcher's Slicer -> Razorclaw the Butcher

        [6321] = { 3887 }, -- Silverlaine's Family Seal -> Baron Silverlaine
        [6323] = { 3887 }, -- Baron's Scepter -> Baron Silverlaine

        [6320] = { 4278 }, -- Commander's Crest -> Commander Springvale
        [3191] = { 4278 }, -- Arced War Axe -> Commander Springvale

        [6318] = { 4279 }, -- Odo's Ley Staff -> Odo the Blindwatcher
        [6319] = { 4279 }, -- Girdle of the Blindwatcher -> Odo the Blindwatcher

        [6642] = { 3872 }, -- Phantom Armor -> Deathsworn Captain
        [6641] = { 3872 }, -- Haunting Blade -> Deathsworn Captain

        [6340] = { 4274 }, -- Fenrus' Hide -> Fenrus the Devourer
        [3230] = { 4274 }, -- Black Wolf Bracers -> Fenrus the Devourer

        [3748] = { 3927 }, -- Feline Mantle -> Wolf Master Nandos
        [6314] = { 3927 }, -- Wolfmaster Cape -> Wolf Master Nandos

        [6324] = { 4275 }, -- Robes of Arugal -> Archmage Arugal
        [6392] = { 4275 }, -- Belt of Arugal -> Archmage Arugal
        [6220] = { 4275 }, -- Meteor Shard -> Archmage Arugal
    },
}
