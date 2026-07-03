-- TempleOfAtalHakkar.lua defines the static dungeon metadata used by the addon.

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
DungeonOracleData.dungeons.temple_of_atalhakkar = {
    id = "temple_of_atalhakkar",
    name = "The Temple of Atal'Hakkar",
    map_id = 1477,
    aliases = {
        "Sunken Temple",
    },
    bosses = {
        -- Temple Of Atal'Hakkar tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 5712,
            name = "Zolo",
            recorded_loot = {
                [10783] = true, -- Atal'ai Spaulders
                [10784] = true, -- Atal'ai Breastplate
                [10787] = true, -- Atal'ai Gloves
                [10788] = true, -- Atal'ai Girdle
                [10785] = true, -- Atal'ai Leggings
                [10786] = true, -- Atal'ai Boots
            },
        },
        {
            id = 5713,
            name = "Gasher",
            recorded_loot = {
                [10783] = true, -- Atal'ai Spaulders
                [10784] = true, -- Atal'ai Breastplate
                [10787] = true, -- Atal'ai Gloves
                [10788] = true, -- Atal'ai Girdle
                [10785] = true, -- Atal'ai Leggings
                [10786] = true, -- Atal'ai Boots
            },
        },
        {
            id = 5714,
            name = "Loro",
            recorded_loot = {
                [10783] = true, -- Atal'ai Spaulders
                [10784] = true, -- Atal'ai Breastplate
                [10787] = true, -- Atal'ai Gloves
                [10788] = true, -- Atal'ai Girdle
                [10785] = true, -- Atal'ai Leggings
                [10786] = true, -- Atal'ai Boots
            },
        },
        {
            id = 5715,
            name = "Hukku",
            recorded_loot = {
                [10783] = true, -- Atal'ai Spaulders
                [10784] = true, -- Atal'ai Breastplate
                [10787] = true, -- Atal'ai Gloves
                [10788] = true, -- Atal'ai Girdle
                [10785] = true, -- Atal'ai Leggings
                [10786] = true, -- Atal'ai Boots
            },
        },
        {
            id = 5716,
            name = "Zul'Lor",
            recorded_loot = {
                [10783] = true, -- Atal'ai Spaulders
                [10784] = true, -- Atal'ai Breastplate
                [10787] = true, -- Atal'ai Gloves
                [10788] = true, -- Atal'ai Girdle
                [10785] = true, -- Atal'ai Leggings
                [10786] = true, -- Atal'ai Boots
            },
        },
        {
            id = 5717,
            name = "Mijan",
            recorded_loot = {
                [10783] = true, -- Atal'ai Spaulders
                [10784] = true, -- Atal'ai Breastplate
                [10787] = true, -- Atal'ai Gloves
                [10788] = true, -- Atal'ai Girdle
                [10785] = true, -- Atal'ai Leggings
                [10786] = true, -- Atal'ai Boots
            },
        },
        {
            id = 8580,
            name = "Atal'alarion",
            recorded_loot = {
                [10800] = true, -- Darkwater Bracers
                [10798] = true, -- Atal'alarion's Tusk Ring
                [10799] = true, -- Headspike
            },
        },
        {
            id = 5708,
            name = "Spawn of Hakkar",
            recorded_loot = {
                [10801] = true, -- Slitherscale Boots
                [10802] = true, -- Wingveil Cloak
            },
        },
        {
            id = 8443,
            name = "Avatar of Hakkar",
            recorded_loot = {
                [12462] = true, -- Embrace of the Wind Serpent
                [10843] = true, -- Featherskin Cape
                [10845] = true, -- Warrior's Embrace
                [10842] = true, -- Windscale Sarong
                [10846] = true, -- Bloodshot Greaves
                [10838] = true, -- Might of Hakkar
                [10844] = true, -- Spire of Hakkar
            },
        },
        {
            id = 5710,
            name = "Jammal'an the Prophet",
            recorded_loot = {
                [10806] = true, -- Vestments of the Atal'ai Prophet
                [10808] = true, -- Gloves of the Atal'ai Prophet
                [10807] = true, -- Kilt of the Atal'ai Prophet
            },
        },
        {
            id = 5711,
            name = "Ogom the Wretched",
            recorded_loot = {
                [10805] = true, -- Eater of the Dead
                [10803] = true, -- Blade of the Wretched
                [10804] = true, -- Fist of the Damned
            },
        },
        {
            id = 5721,
            name = "Dreamscythe",
            recorded_loot = {
                [12465] = true, -- Nightfall Drape
                [12466] = true, -- Dawnspire Cord
                [12464] = true, -- Bloodfire Talons
                [10797] = true, -- Firebreather
                [12463] = true, -- Drakefang Butcher
                [12243] = true, -- Smoldering Claw
                [10795] = true, -- Drakeclaw Band
                [10796] = true, -- Drakestone
            },
        },
        {
            id = 5720,
            name = "Weaver",
            recorded_loot = {
                [12465] = true, -- Nightfall Drape
                [12466] = true, -- Dawnspire Cord
                [12464] = true, -- Bloodfire Talons
                [10797] = true, -- Firebreather
                [12463] = true, -- Drakefang Butcher
                [12243] = true, -- Smoldering Claw
                [10795] = true, -- Drakeclaw Band
                [10796] = true, -- Drakestone
            },
        },
        {
            id = 5722,
            name = "Hazzas",
            recorded_loot = {
                [12465] = true, -- Nightfall Drape
                [12466] = true, -- Dawnspire Cord
                [12464] = true, -- Bloodfire Talons
                [10797] = true, -- Firebreather
                [12463] = true, -- Drakefang Butcher
                [12243] = true, -- Smoldering Claw
                [10795] = true, -- Drakeclaw Band
                [10796] = true, -- Drakestone
            },
        },
        {
            id = 5719,
            name = "Morphaz",
            recorded_loot = {
                [12465] = true, -- Nightfall Drape
                [12466] = true, -- Dawnspire Cord
                [12464] = true, -- Bloodfire Talons
                [10797] = true, -- Firebreather
                [12463] = true, -- Drakefang Butcher
                [12243] = true, -- Smoldering Claw
                [10795] = true, -- Drakeclaw Band
                [10796] = true, -- Drakestone
            },
        },
        {
            id = 5709,
            name = "Shade of Eranikus",
            recorded_loot = {
                [10847] = true, -- Dragon's Call
                [10833] = true, -- Horns of Eranikus
                [10829] = true, -- Dragon's Eye
                [10836] = true, -- Rod of Corrosion
                [10835] = true, -- Crest of Supremacy
                [10837] = true, -- Tooth of Eranikus
                [10828] = true, -- Dire Nail
            },
        },
    },
}
