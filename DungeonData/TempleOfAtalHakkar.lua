-- TempleOfAtalHakkar.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

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
    loot_to_bosses = {
        [10783] = { 5712, 5713, 5714, 5715, 5716, 5717 }, -- Atal'ai Spaulders -> Zolo, Gasher, Loro, Hukku, Zul'Lor, Mijan
        [10784] = { 5712, 5713, 5714, 5715, 5716, 5717 }, -- Atal'ai Breastplate -> Zolo, Gasher, Loro, Hukku, Zul'Lor, Mijan
        [10787] = { 5712, 5713, 5714, 5715, 5716, 5717 }, -- Atal'ai Gloves -> Zolo, Gasher, Loro, Hukku, Zul'Lor, Mijan
        [10788] = { 5712, 5713, 5714, 5715, 5716, 5717 }, -- Atal'ai Girdle -> Zolo, Gasher, Loro, Hukku, Zul'Lor, Mijan
        [10785] = { 5712, 5713, 5714, 5715, 5716, 5717 }, -- Atal'ai Leggings -> Zolo, Gasher, Loro, Hukku, Zul'Lor, Mijan
        [10786] = { 5712, 5713, 5714, 5715, 5716, 5717 }, -- Atal'ai Boots -> Zolo, Gasher, Loro, Hukku, Zul'Lor, Mijan

        [10800] = { 8580 }, -- Darkwater Bracers -> Atal'alarion
        [10798] = { 8580 }, -- Atal'alarion's Tusk Ring -> Atal'alarion
        [10799] = { 8580 }, -- Headspike -> Atal'alarion

        [10801] = { 5708 }, -- Slitherscale Boots -> Spawn of Hakkar
        [10802] = { 5708 }, -- Wingveil Cloak -> Spawn of Hakkar

        [12462] = { 8443 }, -- Embrace of the Wind Serpent -> Avatar of Hakkar
        [10843] = { 8443 }, -- Featherskin Cape -> Avatar of Hakkar
        [10845] = { 8443 }, -- Warrior's Embrace -> Avatar of Hakkar
        [10842] = { 8443 }, -- Windscale Sarong -> Avatar of Hakkar
        [10846] = { 8443 }, -- Bloodshot Greaves -> Avatar of Hakkar
        [10838] = { 8443 }, -- Might of Hakkar -> Avatar of Hakkar
        [10844] = { 8443 }, -- Spire of Hakkar -> Avatar of Hakkar

        [10806] = { 5710 }, -- Vestments of the Atal'ai Prophet -> Jammal'an the Prophet
        [10808] = { 5710 }, -- Gloves of the Atal'ai Prophet -> Jammal'an the Prophet
        [10807] = { 5710 }, -- Kilt of the Atal'ai Prophet -> Jammal'an the Prophet

        [10805] = { 5711 }, -- Eater of the Dead -> Ogom the Wretched
        [10803] = { 5711 }, -- Blade of the Wretched -> Ogom the Wretched
        [10804] = { 5711 }, -- Fist of the Damned -> Ogom the Wretched

        [12465] = { 5721, 5720, 5722, 5719 }, -- Nightfall Drape -> Dreamscythe, Weaver, Hazzas, Morphaz
        [12466] = { 5721, 5720, 5722, 5719 }, -- Dawnspire Cord -> Dreamscythe, Weaver, Hazzas, Morphaz
        [12464] = { 5721, 5720, 5722, 5719 }, -- Bloodfire Talons -> Dreamscythe, Weaver, Hazzas, Morphaz
        [10797] = { 5721, 5720, 5722, 5719 }, -- Firebreather -> Dreamscythe, Weaver, Hazzas, Morphaz
        [12463] = { 5721, 5720, 5722, 5719 }, -- Drakefang Butcher -> Dreamscythe, Weaver, Hazzas, Morphaz
        [12243] = { 5721, 5720, 5722, 5719 }, -- Smoldering Claw -> Dreamscythe, Weaver, Hazzas, Morphaz
        [10795] = { 5721, 5720, 5722, 5719 }, -- Drakeclaw Band -> Dreamscythe, Weaver, Hazzas, Morphaz
        [10796] = { 5721, 5720, 5722, 5719 }, -- Drakestone -> Dreamscythe, Weaver, Hazzas, Morphaz

        [10847] = { 5709 }, -- Dragon's Call -> Shade of Eranikus
        [10833] = { 5709 }, -- Horns of Eranikus -> Shade of Eranikus
        [10829] = { 5709 }, -- Dragon's Eye -> Shade of Eranikus
        [10836] = { 5709 }, -- Rod of Corrosion -> Shade of Eranikus
        [10835] = { 5709 }, -- Crest of Supremacy -> Shade of Eranikus
        [10837] = { 5709 }, -- Tooth of Eranikus -> Shade of Eranikus
        [10828] = { 5709 }, -- Dire Nail -> Shade of Eranikus
    },
}
