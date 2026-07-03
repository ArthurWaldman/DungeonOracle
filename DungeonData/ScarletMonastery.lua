-- ScarletMonastery.lua defines the shared Scarlet Monastery instance.

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
DungeonOracleData.dungeons.scarlet_monastery = {
    id = "scarlet_monastery",
    name = "Scarlet Monastery",
    map_id = 796,
    aliases = {
        "Scarlet Monastery - Graveyard",
        "Scarlet Monastery - Library",
        "Scarlet Monastery - Armory",
        "Scarlet Monastery - Cathedral",
    },
    bosses = {
        -- Scarlet Monastery tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 3983,
            name = "Interrogator Vishas",
            recorded_loot = {
                [7682] = true, -- Torturing Poker
            },
        },
        {
            id = 6490,
            name = "Azshir the Sleepless",
            recorded_loot = {
                [7709] = true, -- Blighted Leggings
                [7708] = true, -- Necrotic Wand
                [7731] = true, -- Ghostshard Talisman
            },
        },
        {
            id = 6488,
            name = "Fallen Champion",
            recorded_loot = {
                [7691] = true, -- Embalmed Shroud
                [7690] = true, -- Ebon Vise
                [7689] = true, -- Morbid Dawn
            },
        },
        {
            id = 6489,
            name = "Ironspine",
            recorded_loot = {
                [7688] = true, -- Ironspine's Ribcage
                [7687] = true, -- Ironspine's Fist
                [7686] = true, -- Ironspine's Eye
            },
        },
        {
            id = 4543,
            name = "Bloodmage Thalnos",
            recorded_loot = {
                [7685] = true, -- Orb of the Forgotten Seer
                [7684] = true, -- Bloodmage Mantle
            },
        },
        {
            id = 3974,
            name = "Houndmaster Loksey",
            recorded_loot = {
                [7710] = true, -- Loksey's Training Stick
                [7756] = true, -- Dog Training Gloves
                [3456] = true, -- Dog Whistle
            },
        },
        {
            id = 6487,
            name = "Arcanist Doan",
            recorded_loot = {
                [7714] = true, -- Hypnotic Blade
                [7713] = true, -- Illusionary Rod
                [7712] = true, -- Mantle of Doan
                [7711] = true, -- Robe of Doan
            },
        },
        {
            id = 3975,
            name = "Herod",
            recorded_loot = {
                [7719] = true, -- Raging Berserker's Helm
                [7718] = true, -- Herod's Shoulder
                [10330] = true, -- Scarlet Leggings
                [7717] = true, -- Ravager
            },
        },
        {
            id = 4542,
            name = "High Inquisitor Fairbanks",
            recorded_loot = {
                [19507] = true, -- Inquisitor's Shawl
                [19508] = true, -- Branded Leather Bracers
                [19509] = true, -- Dusty Mail Boots
            },
        },
        {
            id = 3976,
            name = "Scarlet Commander Mograine",
            recorded_loot = {
                [7724] = true, -- Gauntlets of Divinity
                [10330] = true, -- Scarlet Leggings
                [7726] = true, -- Aegis of the Scarlet Commander
                [7723] = true, -- Mograine's Might
            },
        },
        {
            id = 3977,
            name = "High Inquisitor Whitemane",
            recorded_loot = {
                [7720] = true, -- Whitemane's Chapeau
                [7722] = true, -- Triune Amulet
                [7721] = true, -- Hand of Righteousness
            },
        },
    },
}
