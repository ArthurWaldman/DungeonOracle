-- Stratholme.lua defines the static dungeon metadata used by the addon.

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
DungeonOracleData.dungeons.stratholme = {
    id = "stratholme",
    name = "Stratholme",
    map_id = 2017,
    bosses = {
        -- Stratholme tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 10393,
            name = "Skul",
            recorded_loot = {
                [13395] = true, -- Skullforge Reaver
                [13394] = true, -- Skul's Cold Embrace
                [13396] = true, -- Skul's Ghastly Touch
            },
        },
        {
            id = 10558,
            name = "Hearthsinger Forresten",
            recorded_loot = {
                [16682] = true, -- Magister's Boots
                [13378] = true, -- Songbird Blouse
                [13384] = true, -- Rainbow Girdle
                [13383] = true, -- Woollies of the Prancing Minstrel
                [13379] = true, -- Piccolo of the Flaming Fire
            },
        },
        {
            id = 10516,
            name = "The Unforgiven",
            recorded_loot = {
                [16717] = true, -- Wildheart Gloves
                [13404] = true, -- Mask of the Unforgiven
                [13405] = true, -- Wailing Nightbane Pauldrons
                [13409] = true, -- Tears of the Unforgiven
                [13408] = true, -- Soul Breaker
            },
        },
        {
            id = 10808,
            name = "Timmy the Cruel",
            recorded_loot = {
                [16724] = true, -- Lightforge Gauntlets
                [13400] = true, -- Vambraces of the Sadist
                [13403] = true, -- Grimgore Noose
                [13402] = true, -- Timmy's Galoshes
                [13401] = true, -- The Cruel Hand of Timmy
            },
        },
        {
            id = 11120,
            name = "Crimson Hammersmith",
            recorded_loot = {
                [18781] = true, -- Bottom Half of Advanced Armorsmithing: Volume II
            },
        },
        {
            id = 10997,
            name = "Cannon Master Willey",
            recorded_loot = {
                [16708] = true, -- Shadowcraft Spaulders
                [22407] = true, -- Helm of the New Moon
                [22403] = true, -- Diana's Pearl Necklace
                [22405] = true, -- Mantle of the Scarlet Crusade
                [18721] = true, -- Barrage Girdle
                [13381] = true, -- Master Cannoneer Boots
                [13382] = true, -- Cannonball Runner
                [13380] = true, -- Willey's Portable Howitzer
                [13377] = true, -- Miniature Cannon Balls
                [22404] = true, -- Willey's Back Scratcher
                [22406] = true, -- Redemption
                [12839] = true, -- Plans: Heartseeker
            },
        },
        {
            id = 10811,
            name = "Archivist Galford",
            recorded_loot = {
                [16692] = true, -- Devout Gloves
                [13386] = true, -- Archivist Cape
                [13387] = true, -- Foresight Girdle
                [18716] = true, -- Ash Covered Boots
                [13385] = true, -- Tome of Knowledge
                [12811] = true, -- Righteous Orb
                [22897] = true, -- Tome of Conjure Food VII
            },
        },
        {
            id = 10813,
            name = "Balnazzar",
            recorded_loot = {
                [13353] = true, -- Book of the Dead
                [14512] = true, -- Pattern: Truefaith Vestments
                [16725] = true, -- Lightforge Boots
                [13359] = true, -- Crown of Tyranny
                [18718] = true, -- Grand Crusader's Helm
                [12103] = true, -- Star of Mystaria
                [18720] = true, -- Shroud of the Nathrezim
                [13358] = true, -- Wyrmtongue Shoulders
                [13369] = true, -- Fire Striders
                [13360] = true, -- Gift of the Elven Magi
                [18717] = true, -- Hammer of the Grand Crusader
                [22334] = true, -- Band of Mending
                [13348] = true, -- Demonshear
                [13520] = true, -- Recipe: Flask of Distilled Wisdom
            },
        },
        {
            id = 10435,
            name = "Magistrate Barthilas",
            recorded_loot = {
                [18727] = true, -- Crimson Felt Hat
                [13376] = true, -- Royal Tribunal Cloak
                [18726] = true, -- Magistrate's Cuffs
                [18722] = true, -- Death Grips
                [23198] = true, -- Idol of Brutality
                [18725] = true, -- Peacemaker
            },
        },
        {
            id = 10809,
            name = "Stonespine",
            recorded_loot = {
                [13397] = true, -- Stoneskin Gargoyle Cape
                [13954] = true, -- Verdant Footpads
                [13399] = true, -- Gargoyle Shredder Talons
            },
        },
        {
            id = 10436,
            name = "Baroness Anastari",
            recorded_loot = {
                [16704] = true, -- Dreadmist Sandals
                [18728] = true, -- Anastari Heirloom
                [18730] = true, -- Shadowy Laced Handwraps
                [18729] = true, -- Screeching Bow
                [13534] = true, -- Banshee Finger
                [13538] = true, -- Windshrieker Pauldrons
                [13535] = true, -- Coldtouch Phantom Wraps
                [13537] = true, -- Chillhide Bracers
                [13539] = true, -- Banshee's Touch
                [13514] = true, -- Wail of the Banshee
            },
        },
        {
            id = 11121,
            name = "Black Guard Swordsmith",
            recorded_loot = {
                [18783] = true, -- Bottom Half of Advanced Armorsmithing: Volume III
            },
        },
        {
            id = 10437,
            name = "Nerub'enkan",
            recorded_loot = {
                [16675] = true, -- Beaststalker's Boots
                [18740] = true, -- Thuzadin Sash
                [18739] = true, -- Chitinous Plate Legguards
                [18738] = true, -- Carapace Spine Crossbow
                [13529] = true, -- Husk of Nerub'enkan
                [13533] = true, -- Acid-etched Pauldrons
                [13532] = true, -- Darkspinner Claws
                [13531] = true, -- Crypt Stalker Leggings
                [13530] = true, -- Fangdrip Runners
                [13508] = true, -- Eye of Arachnida
            },
        },
        {
            id = 10438,
            name = "Maleki the Pallid",
            recorded_loot = {
                [16691] = true, -- Devout Sandals
                [18734] = true, -- Pale Moon Cloak
                [18735] = true, -- Maleki's Footwraps
                [13524] = true, -- Skull of Burning Shadows
                [18737] = true, -- Bone Slicing Hatchet
                [13528] = true, -- Twilight Void Bracers
                [13525] = true, -- Darkbind Fingers
                [13526] = true, -- Flamescarred Girdle
                [13527] = true, -- Lavawalker Greaves
                [13509] = true, -- Clutch of Foresight
                [12833] = true, -- Plans: Hammer of the Titans
            },
        },
        {
            id = 10439,
            name = "Ramstein the Gorger",
            recorded_loot = {
                [16737] = true, -- Gauntlets of Valor
                [18723] = true, -- Animated Chain Necklace
                [13374] = true, -- Soulstealer Mantle
                [13373] = true, -- Band of Flesh
                [13515] = true, -- Ramstein's Lightning Bolts
                [13375] = true, -- Crest of Retribution
                [13372] = true, -- Slavedriver's Cane
            },
        },
        {
            id = 10440,
            name = "Baron Rivendare",
            recorded_loot = {
                [13335] = true, -- Deathcharger's Reins
                [13505] = true, -- Runeblade of Baron Rivendare
                [22411] = true, -- Helm of the Executioner
                [22412] = true, -- Thuzadin Mantle
                [13340] = true, -- Cape of the Black Baron
                [13346] = true, -- Robes of the Exalted
                [22409] = true, -- Tunic of the Crescent Moon
                [13344] = true, -- Dracorian Gauntlets
                [22410] = true, -- Gauntlets of Deftness
                [13345] = true, -- Seal of Rivendare
                [22408] = true, -- Ritssyn's Wand of Bad Mojo
                [13349] = true, -- Scepter of the Unholy
                [13368] = true, -- Bonescraper
                [13361] = true, -- Skullforge Reaver
                [16694] = true, -- Devout Skirt
                [16687] = true, -- Magister's Leggings
                [16699] = true, -- Dreadmist Leggings
                [16709] = true, -- Shadowcraft Pants
                [16719] = true, -- Wildheart Kilt
                [16678] = true, -- Beaststalker's Pants
                [16668] = true, -- Kilt of Elements
                [16728] = true, -- Lightforge Legplates
                [16732] = true, -- Legplates of Valor
            },
        },
    },
}
