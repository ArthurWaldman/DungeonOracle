-- Stratholme.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

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
    loot_to_bosses = {
        [13395] = { 10393 }, -- Skullforge Reaver -> Skul
        [13394] = { 10393 }, -- Skul's Cold Embrace -> Skul
        [13396] = { 10393 }, -- Skul's Ghastly Touch -> Skul

        [16682] = { 10558 }, -- Magister's Boots -> Hearthsinger Forresten
        [13378] = { 10558 }, -- Songbird Blouse -> Hearthsinger Forresten
        [13384] = { 10558 }, -- Rainbow Girdle -> Hearthsinger Forresten
        [13383] = { 10558 }, -- Woollies of the Prancing Minstrel -> Hearthsinger Forresten
        [13379] = { 10558 }, -- Piccolo of the Flaming Fire -> Hearthsinger Forresten

        [16717] = { 10516 }, -- Wildheart Gloves -> The Unforgiven
        [13404] = { 10516 }, -- Mask of the Unforgiven -> The Unforgiven
        [13405] = { 10516 }, -- Wailing Nightbane Pauldrons -> The Unforgiven
        [13409] = { 10516 }, -- Tears of the Unforgiven -> The Unforgiven
        [13408] = { 10516 }, -- Soul Breaker -> The Unforgiven

        [16724] = { 10808 }, -- Lightforge Gauntlets -> Timmy the Cruel
        [13400] = { 10808 }, -- Vambraces of the Sadist -> Timmy the Cruel
        [13403] = { 10808 }, -- Grimgore Noose -> Timmy the Cruel
        [13402] = { 10808 }, -- Timmy's Galoshes -> Timmy the Cruel
        [13401] = { 10808 }, -- The Cruel Hand of Timmy -> Timmy the Cruel

        [18781] = { 11120 }, -- Bottom Half of Advanced Armorsmithing: Volume II -> Crimson Hammersmith

        [16708] = { 10997 }, -- Shadowcraft Spaulders -> Cannon Master Willey
        [22407] = { 10997 }, -- Helm of the New Moon -> Cannon Master Willey
        [22403] = { 10997 }, -- Diana's Pearl Necklace -> Cannon Master Willey
        [22405] = { 10997 }, -- Mantle of the Scarlet Crusade -> Cannon Master Willey
        [18721] = { 10997 }, -- Barrage Girdle -> Cannon Master Willey
        [13381] = { 10997 }, -- Master Cannoneer Boots -> Cannon Master Willey
        [13382] = { 10997 }, -- Cannonball Runner -> Cannon Master Willey
        [13380] = { 10997 }, -- Willey's Portable Howitzer -> Cannon Master Willey
        [13377] = { 10997 }, -- Miniature Cannon Balls -> Cannon Master Willey
        [22404] = { 10997 }, -- Willey's Back Scratcher -> Cannon Master Willey
        [22406] = { 10997 }, -- Redemption -> Cannon Master Willey
        [12839] = { 10997 }, -- Plans: Heartseeker -> Cannon Master Willey

        [16692] = { 10811 }, -- Devout Gloves -> Archivist Galford
        [13386] = { 10811 }, -- Archivist Cape -> Archivist Galford
        [13387] = { 10811 }, -- Foresight Girdle -> Archivist Galford
        [18716] = { 10811 }, -- Ash Covered Boots -> Archivist Galford
        [13385] = { 10811 }, -- Tome of Knowledge -> Archivist Galford
        [12811] = { 10811 }, -- Righteous Orb -> Archivist Galford
        [22897] = { 10811 }, -- Tome of Conjure Food VII -> Archivist Galford

        [13353] = { 10813 }, -- Book of the Dead -> Balnazzar
        [14512] = { 10813 }, -- Pattern: Truefaith Vestments -> Balnazzar
        [16725] = { 10813 }, -- Lightforge Boots -> Balnazzar
        [13359] = { 10813 }, -- Crown of Tyranny -> Balnazzar
        [18718] = { 10813 }, -- Grand Crusader's Helm -> Balnazzar
        [12103] = { 10813 }, -- Star of Mystaria -> Balnazzar
        [18720] = { 10813 }, -- Shroud of the Nathrezim -> Balnazzar
        [13358] = { 10813 }, -- Wyrmtongue Shoulders -> Balnazzar
        [13369] = { 10813 }, -- Fire Striders -> Balnazzar
        [13360] = { 10813 }, -- Gift of the Elven Magi -> Balnazzar
        [18717] = { 10813 }, -- Hammer of the Grand Crusader -> Balnazzar
        [22334] = { 10813 }, -- Band of Mending -> Balnazzar
        [13348] = { 10813 }, -- Demonshear -> Balnazzar
        [13520] = { 10813 }, -- Recipe: Flask of Distilled Wisdom -> Balnazzar

        [18727] = { 10435 }, -- Crimson Felt Hat -> Magistrate Barthilas
        [13376] = { 10435 }, -- Royal Tribunal Cloak -> Magistrate Barthilas
        [18726] = { 10435 }, -- Magistrate's Cuffs -> Magistrate Barthilas
        [18722] = { 10435 }, -- Death Grips -> Magistrate Barthilas
        [23198] = { 10435 }, -- Idol of Brutality -> Magistrate Barthilas
        [18725] = { 10435 }, -- Peacemaker -> Magistrate Barthilas

        [13397] = { 10809 }, -- Stoneskin Gargoyle Cape -> Stonespine
        [13954] = { 10809 }, -- Verdant Footpads -> Stonespine
        [13399] = { 10809 }, -- Gargoyle Shredder Talons -> Stonespine

        [16704] = { 10436 }, -- Dreadmist Sandals -> Baroness Anastari
        [18728] = { 10436 }, -- Anastari Heirloom -> Baroness Anastari
        [18730] = { 10436 }, -- Shadowy Laced Handwraps -> Baroness Anastari
        [18729] = { 10436 }, -- Screeching Bow -> Baroness Anastari
        [13534] = { 10436 }, -- Banshee Finger -> Baroness Anastari
        [13538] = { 10436 }, -- Windshrieker Pauldrons -> Baroness Anastari
        [13535] = { 10436 }, -- Coldtouch Phantom Wraps -> Baroness Anastari
        [13537] = { 10436 }, -- Chillhide Bracers -> Baroness Anastari
        [13539] = { 10436 }, -- Banshee's Touch -> Baroness Anastari
        [13514] = { 10436 }, -- Wail of the Banshee -> Baroness Anastari

        [18783] = { 11121 }, -- Bottom Half of Advanced Armorsmithing: Volume III -> Black Guard Swordsmith

        [16675] = { 10437 }, -- Beaststalker's Boots -> Nerub'enkan
        [18740] = { 10437 }, -- Thuzadin Sash -> Nerub'enkan
        [18739] = { 10437 }, -- Chitinous Plate Legguards -> Nerub'enkan
        [18738] = { 10437 }, -- Carapace Spine Crossbow -> Nerub'enkan
        [13529] = { 10437 }, -- Husk of Nerub'enkan -> Nerub'enkan
        [13533] = { 10437 }, -- Acid-etched Pauldrons -> Nerub'enkan
        [13532] = { 10437 }, -- Darkspinner Claws -> Nerub'enkan
        [13531] = { 10437 }, -- Crypt Stalker Leggings -> Nerub'enkan
        [13530] = { 10437 }, -- Fangdrip Runners -> Nerub'enkan
        [13508] = { 10437 }, -- Eye of Arachnida -> Nerub'enkan

        [16691] = { 10438 }, -- Devout Sandals -> Maleki the Pallid
        [18734] = { 10438 }, -- Pale Moon Cloak -> Maleki the Pallid
        [18735] = { 10438 }, -- Maleki's Footwraps -> Maleki the Pallid
        [13524] = { 10438 }, -- Skull of Burning Shadows -> Maleki the Pallid
        [18737] = { 10438 }, -- Bone Slicing Hatchet -> Maleki the Pallid
        [13528] = { 10438 }, -- Twilight Void Bracers -> Maleki the Pallid
        [13525] = { 10438 }, -- Darkbind Fingers -> Maleki the Pallid
        [13526] = { 10438 }, -- Flamescarred Girdle -> Maleki the Pallid
        [13527] = { 10438 }, -- Lavawalker Greaves -> Maleki the Pallid
        [13509] = { 10438 }, -- Clutch of Foresight -> Maleki the Pallid
        [12833] = { 10438 }, -- Plans: Hammer of the Titans -> Maleki the Pallid

        [16737] = { 10439 }, -- Gauntlets of Valor -> Ramstein the Gorger
        [18723] = { 10439 }, -- Animated Chain Necklace -> Ramstein the Gorger
        [13374] = { 10439 }, -- Soulstealer Mantle -> Ramstein the Gorger
        [13373] = { 10439 }, -- Band of Flesh -> Ramstein the Gorger
        [13515] = { 10439 }, -- Ramstein's Lightning Bolts -> Ramstein the Gorger
        [13375] = { 10439 }, -- Crest of Retribution -> Ramstein the Gorger
        [13372] = { 10439 }, -- Slavedriver's Cane -> Ramstein the Gorger

        [13335] = { 10440 }, -- Deathcharger's Reins -> Baron Rivendare
        [13505] = { 10440 }, -- Runeblade of Baron Rivendare -> Baron Rivendare
        [22411] = { 10440 }, -- Helm of the Executioner -> Baron Rivendare
        [22412] = { 10440 }, -- Thuzadin Mantle -> Baron Rivendare
        [13340] = { 10440 }, -- Cape of the Black Baron -> Baron Rivendare
        [13346] = { 10440 }, -- Robes of the Exalted -> Baron Rivendare
        [22409] = { 10440 }, -- Tunic of the Crescent Moon -> Baron Rivendare
        [13344] = { 10440 }, -- Dracorian Gauntlets -> Baron Rivendare
        [22410] = { 10440 }, -- Gauntlets of Deftness -> Baron Rivendare
        [13345] = { 10440 }, -- Seal of Rivendare -> Baron Rivendare
        [22408] = { 10440 }, -- Ritssyn's Wand of Bad Mojo -> Baron Rivendare
        [13349] = { 10440 }, -- Scepter of the Unholy -> Baron Rivendare
        [13368] = { 10440 }, -- Bonescraper -> Baron Rivendare
        [13361] = { 10440 }, -- Skullforge Reaver -> Baron Rivendare
        [16694] = { 10440 }, -- Devout Skirt -> Baron Rivendare
        [16687] = { 10440 }, -- Magister's Leggings -> Baron Rivendare
        [16699] = { 10440 }, -- Dreadmist Leggings -> Baron Rivendare
        [16709] = { 10440 }, -- Shadowcraft Pants -> Baron Rivendare
        [16719] = { 10440 }, -- Wildheart Kilt -> Baron Rivendare
        [16678] = { 10440 }, -- Beaststalker's Pants -> Baron Rivendare
        [16668] = { 10440 }, -- Kilt of Elements -> Baron Rivendare
        [16728] = { 10440 }, -- Lightforge Legplates -> Baron Rivendare
        [16732] = { 10440 }, -- Legplates of Valor -> Baron Rivendare

        [13395] = { 10393 }, -- Skullforge Reaver -> Skul
        [13361] = { 10440 }, -- Skullforge Reaver -> Baron Rivendare
    },
}
