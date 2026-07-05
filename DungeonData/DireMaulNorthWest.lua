-- DireMaulNorthWest.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

DungeonOracleData.dungeons.dire_maul_north_west = {
    id = "dire_maul_north_west",
    name = "Dire Maul",
    aliases = {
        "Dire Maul - North",
        "Dire Maul North",
        "Dire Maul - West",
        "Dire Maul West",
        "Dire Maul - North/West",
    },
    bosses = {
        -- Dire Maul North/West tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 11489,
            name = "Tendris Warpwood",
            recorded_loot = {
                [18393] = true, -- Warpwood Binding
                [18390] = true, -- Tanglemoss Leggings
                [18352] = true, -- Petrified Bark Shield
                [18353] = true, -- Stoneflower Staff
            },
        },
        {
            id = 11488,
            name = "Illyanna Ravenoak",
            recorded_loot = {
                [18383] = true, -- Force Imbued Gauntlets
                [18386] = true, -- Padre's Trousers
                [18349] = true, -- Gauntlets of Accuracy
                [18347] = true, -- Well Balanced Axe
            },
        },
        {
            id = 11487,
            name = "Magister Kalendris",
            recorded_loot = {
                [18374] = true, -- Mark of the Pariah
                [18397] = true, -- Elder Magus Pendant
                [18371] = true, -- Mindtap Talisman
                [18350] = true, -- Amplifying Cloak
                [18351] = true, -- Magically Sealed Bracers
                [22309] = true, -- Pattern: Big Bag of Enchantment
            },
        },
        {
            id = 11467,
            name = "Tsu'zee",
            recorded_loot = {
                [18387] = true, -- Brightspark Gloves
                [18346] = true, -- Threadbare Trousers
                [18345] = true, -- Murmuring Ring
            },
        },
        {
            id = 11496,
            name = "Immol'thar",
            recorded_loot = {
                [18381] = true, -- Evil Eye Pendant
                [18384] = true, -- Bile-Etched Spaulders
                [18389] = true, -- Cloak of the Cosmos
                [18385] = true, -- Robe of Everlasting Night
                [18394] = true, -- Demon Howl Wristguards
                [18377] = true, -- Quickdraw Quiver
                [18391] = true, -- Eyestalk Cord
                [18379] = true, -- Odious Greaves
                [18370] = true, -- Vigilance Charm
                [18372] = true, -- Blade of the New Moon
            },
        },
        {
            id = 11486,
            name = "Prince Tortheldrin",
            recorded_loot = {
                [18382] = true, -- Flamecrest Gauntlets
                [18373] = true, -- Chestplate of Tranquility
                [18375] = true, -- Bracers of the Eclipse
                [18378] = true, -- Silvermoon Leggings
                [18380] = true, -- Eldritch Reinforced Legplates
                [18395] = true, -- Emerald Flame Ring
                [18388] = true, -- Stoneshatter
                [18396] = true, -- Mind Carver
                [18376] = true, -- Timeworn Mace
                [18392] = true, -- Distracting Dagger
            },
        },
        {
            id = 14326,
            name = "Guard Mol'dar",
            recorded_loot = {
                [18494] = true, -- Denwatcher's Shoulders
                [18493] = true, -- Bulky Iron Spaulders
                [18496] = true, -- Helm of Restrained Power
                [18497] = true, -- Sublime Wristguards
                [18498] = true, -- Hedgecutter
                [18450] = true, -- Robe of Combustion
                [18458] = true, -- Modest Armguards
                [18459] = true, -- Gallant's Wristguards
                [18451] = true, -- Hyena Hide Jerkin
                [18462] = true, -- Jagged Bone Fist
                [18463] = true, -- Ogre Pocket Knife
                [18464] = true, -- Gordok Nose Ring
                [18460] = true, -- Unsophisticated Hand Cannon
            },
        },
        {
            id = 14322,
            name = "Stomper Kreeg",
            recorded_loot = {
                [18425] = true, -- Kreeg's Mug
            },
        },
        {
            id = 14321,
            name = "Guard Fengus",
            recorded_loot = {
                [18450] = true, -- Robe of Combustion
                [18458] = true, -- Modest Armguards
                [18459] = true, -- Gallant's Wristguards
                [18451] = true, -- Hyena Hide Jerkin
                [18462] = true, -- Jagged Bone Fist
                [18463] = true, -- Ogre Pocket Knife
                [18464] = true, -- Gordok Nose Ring
                [18460] = true, -- Unsophisticated Hand Cannon
            },
        },
        {
            id = 14323,
            name = "Guard Slip'kik",
            recorded_loot = {
                [18494] = true, -- Denwatcher's Shoulders
                [18493] = true, -- Bulky Iron Spaulders
                [18496] = true, -- Helm of Restrained Power
                [18497] = true, -- Sublime Wristguards
                [18498] = true, -- Hedgecutter
                [18450] = true, -- Robe of Combustion
                [18458] = true, -- Modest Armguards
                [18459] = true, -- Gallant's Wristguards
                [18451] = true, -- Hyena Hide Jerkin
                [18462] = true, -- Jagged Bone Fist
                [18463] = true, -- Ogre Pocket Knife
                [18464] = true, -- Gordok Nose Ring
                [18460] = true, -- Unsophisticated Hand Cannon
            },
        },
        {
            id = 14325,
            name = "Captain Kromcrush",
            recorded_loot = {
                [18503] = true, -- Kromcrush's Chestplate
                [18505] = true, -- Mugger's Belt
                [18507] = true, -- Boots of the Full Moon
                [18502] = true, -- Monstrous Glaive
            },
        },
        {
            id = 14324,
            name = "Cho'Rush the Observer",
            recorded_loot = {
                [18490] = true, -- Insightful Hood
                [18483] = true, -- Mana Channeling Wand
                [18485] = true, -- Observer's Shield
                [18484] = true, -- Cho'Rush's Blade
            },
        },
        {
            id = 11501,
            name = "King Gordok",
            recorded_loot = {
                [18526] = true, -- Crown of the Ogre King
                [18525] = true, -- Bracers of Prosperity
                [18527] = true, -- Harmonious Gauntlets
                [18524] = true, -- Leggings of Destruction
                [18521] = true, -- Grimy Metal Boots
                [18522] = true, -- Band of the Ogre King
                [18523] = true, -- Brightly Glowing Stone
                [18520] = true, -- Barbarous Blade
                [19258] = true, -- Ace of Warlords
                [18780] = true, -- Top Half of Advanced Armorsmithing: Volume III
            },
        },
    },
    loot_to_bosses = {
        [18393] = { 11489 }, -- Warpwood Binding -> Tendris Warpwood
        [18390] = { 11489 }, -- Tanglemoss Leggings -> Tendris Warpwood
        [18352] = { 11489 }, -- Petrified Bark Shield -> Tendris Warpwood
        [18353] = { 11489 }, -- Stoneflower Staff -> Tendris Warpwood

        [18383] = { 11488 }, -- Force Imbued Gauntlets -> Illyanna Ravenoak
        [18386] = { 11488 }, -- Padre's Trousers -> Illyanna Ravenoak
        [18349] = { 11488 }, -- Gauntlets of Accuracy -> Illyanna Ravenoak
        [18347] = { 11488 }, -- Well Balanced Axe -> Illyanna Ravenoak

        [18374] = { 11487 }, -- Mark of the Pariah -> Magister Kalendris
        [18397] = { 11487 }, -- Elder Magus Pendant -> Magister Kalendris
        [18371] = { 11487 }, -- Mindtap Talisman -> Magister Kalendris
        [18350] = { 11487 }, -- Amplifying Cloak -> Magister Kalendris
        [18351] = { 11487 }, -- Magically Sealed Bracers -> Magister Kalendris
        [22309] = { 11487 }, -- Pattern: Big Bag of Enchantment -> Magister Kalendris

        [18387] = { 11467 }, -- Brightspark Gloves -> Tsu'zee
        [18346] = { 11467 }, -- Threadbare Trousers -> Tsu'zee
        [18345] = { 11467 }, -- Murmuring Ring -> Tsu'zee

        [18381] = { 11496 }, -- Evil Eye Pendant -> Immol'thar
        [18384] = { 11496 }, -- Bile-Etched Spaulders -> Immol'thar
        [18389] = { 11496 }, -- Cloak of the Cosmos -> Immol'thar
        [18385] = { 11496 }, -- Robe of Everlasting Night -> Immol'thar
        [18394] = { 11496 }, -- Demon Howl Wristguards -> Immol'thar
        [18377] = { 11496 }, -- Quickdraw Quiver -> Immol'thar
        [18391] = { 11496 }, -- Eyestalk Cord -> Immol'thar
        [18379] = { 11496 }, -- Odious Greaves -> Immol'thar
        [18370] = { 11496 }, -- Vigilance Charm -> Immol'thar
        [18372] = { 11496 }, -- Blade of the New Moon -> Immol'thar

        [18382] = { 11486 }, -- Flamecrest Gauntlets -> Prince Tortheldrin
        [18373] = { 11486 }, -- Chestplate of Tranquility -> Prince Tortheldrin
        [18375] = { 11486 }, -- Bracers of the Eclipse -> Prince Tortheldrin
        [18378] = { 11486 }, -- Silvermoon Leggings -> Prince Tortheldrin
        [18380] = { 11486 }, -- Eldritch Reinforced Legplates -> Prince Tortheldrin
        [18395] = { 11486 }, -- Emerald Flame Ring -> Prince Tortheldrin
        [18388] = { 11486 }, -- Stoneshatter -> Prince Tortheldrin
        [18396] = { 11486 }, -- Mind Carver -> Prince Tortheldrin
        [18376] = { 11486 }, -- Timeworn Mace -> Prince Tortheldrin
        [18392] = { 11486 }, -- Distracting Dagger -> Prince Tortheldrin

        [18494] = { 14326, 14323 }, -- Denwatcher's Shoulders -> Guard Mol'dar, Guard Slip'kik
        [18493] = { 14326, 14323 }, -- Bulky Iron Spaulders -> Guard Mol'dar, Guard Slip'kik
        [18496] = { 14326, 14323 }, -- Helm of Restrained Power -> Guard Mol'dar, Guard Slip'kik
        [18497] = { 14326, 14323 }, -- Sublime Wristguards -> Guard Mol'dar, Guard Slip'kik
        [18498] = { 14326, 14323 }, -- Hedgecutter -> Guard Mol'dar, Guard Slip'kik

        [18450] = { 14326, 14321, 14323 }, -- Robe of Combustion -> Guard Mol'dar, Guard Fengus, Guard Slip'kik
        [18458] = { 14326, 14321, 14323 }, -- Modest Armguards -> Guard Mol'dar, Guard Fengus, Guard Slip'kik
        [18459] = { 14326, 14321, 14323 }, -- Gallant's Wristguards -> Guard Mol'dar, Guard Fengus, Guard Slip'kik
        [18451] = { 14326, 14321, 14323 }, -- Hyena Hide Jerkin -> Guard Mol'dar, Guard Fengus, Guard Slip'kik
        [18462] = { 14326, 14321, 14323 }, -- Jagged Bone Fist -> Guard Mol'dar, Guard Fengus, Guard Slip'kik
        [18463] = { 14326, 14321, 14323 }, -- Ogre Pocket Knife -> Guard Mol'dar, Guard Fengus, Guard Slip'kik
        [18464] = { 14326, 14321, 14323 }, -- Gordok Nose Ring -> Guard Mol'dar, Guard Fengus, Guard Slip'kik
        [18460] = { 14326, 14321, 14323 }, -- Unsophisticated Hand Cannon -> Guard Mol'dar, Guard Fengus, Guard Slip'kik

        [18425] = { 14322 }, -- Kreeg's Mug -> Stomper Kreeg

        [18503] = { 14325 }, -- Kromcrush's Chestplate -> Captain Kromcrush
        [18505] = { 14325 }, -- Mugger's Belt -> Captain Kromcrush
        [18507] = { 14325 }, -- Boots of the Full Moon -> Captain Kromcrush
        [18502] = { 14325 }, -- Monstrous Glaive -> Captain Kromcrush

        [18490] = { 14324 }, -- Insightful Hood -> Cho'Rush the Observer
        [18483] = { 14324 }, -- Mana Channeling Wand -> Cho'Rush the Observer
        [18485] = { 14324 }, -- Observer's Shield -> Cho'Rush the Observer
        [18484] = { 14324 }, -- Cho'Rush's Blade -> Cho'Rush the Observer

        [18526] = { 11501 }, -- Crown of the Ogre King -> King Gordok
        [18525] = { 11501 }, -- Bracers of Prosperity -> King Gordok
        [18527] = { 11501 }, -- Harmonious Gauntlets -> King Gordok
        [18524] = { 11501 }, -- Leggings of Destruction -> King Gordok
        [18521] = { 11501 }, -- Grimy Metal Boots -> King Gordok
        [18522] = { 11501 }, -- Band of the Ogre King -> King Gordok
        [18523] = { 11501 }, -- Brightly Glowing Stone -> King Gordok
        [18520] = { 11501 }, -- Barbarous Blade -> King Gordok
        [19258] = { 11501 }, -- Ace of Warlords -> King Gordok
        [18780] = { 11501 }, -- Top Half of Advanced Armorsmithing: Volume III -> King Gordok
    },
}
