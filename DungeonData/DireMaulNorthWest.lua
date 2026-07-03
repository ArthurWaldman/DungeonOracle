-- DireMaulNorthWest.lua defines the static dungeon metadata used by the addon.

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
}
