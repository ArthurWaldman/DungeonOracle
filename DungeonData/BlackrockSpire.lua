-- BlackrockSpire.lua defines the shared Blackrock Spire instance.

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
DungeonOracleData.dungeons.blackrock_spire = {
    id = "blackrock_spire",
    name = "Blackrock Spire",
    map_id = 1583,
    aliases = {
        "Lower Blackrock Spire",
        "Upper Blackrock Spire",
    },
    -- Blackrock Spire tracked boss list for WoW Classic Era / Hardcore.
    bosses = {
        {
            id = 10263,
            name = "Burning Felguard",
            recorded_loot = {
                [13181] = true, -- Demonskin Gloves
                [13182] = true, -- Phase Blade
            },
        },
        {
            id = 9219,
            name = "Spirestone Butcher",
            recorded_loot = {
                [12608] = true, -- Butcher's Apron
                [13286] = true, -- Rivenspike
            },
        },
        {
            id = 9196,
            name = "Highlord Omokk",
            recorded_loot = {
                [16670] = true, -- Boots of Elements
                [13166] = true, -- Slamshot Shoulders
                [13168] = true, -- Plate of the Shaman King
                [13170] = true, -- Skyshroud Leggings
                [13169] = true, -- Tressermane Leggings
                [13167] = true, -- Fist of Omokk
                [12336] = true, -- Gemstone of Spirestone
            },
        },
        {
            id = 9218,
            name = "Spirestone Battle Lord",
            recorded_loot = {
                [13284] = true, -- Swiftdart Battleboots
                [13285] = true, -- The Nicker
            },
        },
        {
            id = 9217,
            name = "Spirestone Lord Magus",
            recorded_loot = {
                [13282] = true, -- Ogreseer Tower Boots
                [13283] = true, -- Magus Ring
                [13261] = true, -- Globe of D'sak
            },
        },
        {
            id = 9236,
            name = "Shadow Hunter Vosh'gajin",
            recorded_loot = {
                [16712] = true, -- Shadowcraft Gloves
                [13257] = true, -- Demonic Runed Spaulders
                [12626] = true, -- Funeral Cuffs
                [13255] = true, -- Trueaim Gauntlets
                [12653] = true, -- Riphook
                [12651] = true, -- Blackcrow
                [12654] = true, -- Doomshot
            },
        },
        {
            id = 9237,
            name = "War Master Voone",
            recorded_loot = {
                [16676] = true, -- Beaststalker's Gloves
                [13177] = true, -- Talisman of Evasion
                [13179] = true, -- Brazecore Armguards
                [22231] = true, -- Kayser's Boots of Precision
                [13173] = true, -- Flightblade Throwing Axe
                [12582] = true, -- Keris of Zul'Serak
                [12335] = true, -- Gemstone of Smolderthorn
            },
        },
        {
            id = 9596,
            name = "Bannok Grimaxe",
            recorded_loot = {
                [12637] = true, -- Backusarian Gauntlets
                [12634] = true, -- Chiselbrand Girdle
                [12621] = true, -- Demonfork
                [12838] = true, -- Plans: Arcanite Reaper
            },
        },
        {
            id = 10596,
            name = "Mother Smolderweb",
            recorded_loot = {
                [16715] = true, -- Wildheart Boots
                [13244] = true, -- Gilded Gauntlets
                [13213] = true, -- Smolderweb's Eye
                [13183] = true, -- Venomspitter
            },
        },
        {
            id = 10376,
            name = "Crystal Fang",
            recorded_loot = {
                [13185] = true, -- Sunderseer Mantle
                [13184] = true, -- Fallbrush Handgrips
                [13218] = true, -- Fang of the Crystal Spider
            },
        },
        {
            id = 10584,
            name = "Urok Doomhowl",
            recorded_loot = {
                [13258] = true, -- Slaghide Gauntlets
                [22232] = true, -- Marksman's Girdle
                [13259] = true, -- Ribsteel Footguards
                [13178] = true, -- Rosewine Circle
                [18784] = true, -- Top Half of Advanced Armorsmithing: Volume III
            },
        },
        {
            id = 9736,
            name = "Quartermaster Zigris",
            recorded_loot = {
                [13247] = true, -- Quartermaster Zigris' Footlocker
                [13253] = true, -- Hands of Power
                [13252] = true, -- Cloudrunner Girdle
                [12835] = true, -- Plans: Annihilator
            },
        },
        {
            id = 10220,
            name = "Halycon",
            recorded_loot = {
                [13212] = true, -- Halycon's Spiked Collar
                [22313] = true, -- Ironweave Bracers
                [13211] = true, -- Slashclaw Bracers
                [13210] = true, -- Pads of the Dread Wolf
            },
        },
        {
            id = 10268,
            name = "Gizrul the Slavener",
            recorded_loot = {
                [16718] = true, -- Wildheart Spaulders
                [13208] = true, -- Bleak Howler Armguards
                [13206] = true, -- Wolfshear Leggings
                [13205] = true, -- Rhombeard Protector
            },
        },
        {
            id = 9718,
            name = "Ghok Bashguud",
            recorded_loot = {
                [13203] = true, -- Armswake Cloak
                [13198] = true, -- Hurd Smasher
                [13204] = true, -- Bashguuder
            },
        },
        {
            id = 9568,
            name = "Overlord Wyrmthalak",
            recorded_loot = {
                [13143] = true, -- Mark of the Dragon Lord
                [16679] = true, -- Beaststalker's Mantle
                [13162] = true, -- Reiver Claws
                [13164] = true, -- Heart of the Scale
                [22321] = true, -- Heart of Wyrmthalak
                [13163] = true, -- Relentless Scythe
                [13148] = true, -- Chillpike
                [13161] = true, -- Trindlehaven Staff
                [12337] = true, -- Gemstone of Bloodaxe
            },
        },
        {
            id = 9816,
            name = "Pyroguard Emberseer",
            recorded_loot = {
                [16672] = true, -- Gauntlets of Elements
                [12929] = true, -- Emberfury Talisman
                [12927] = true, -- Truestrike Shoulders
                [12905] = true, -- Wildfire Cape
                [12926] = true, -- Flaming Band
                [23320] = true, -- Tablet of Flame Shock VI
            },
        },
        {
            id = 10264,
            name = "Solakar Flamewreath",
            recorded_loot = {
                [16695] = true, -- Devout Mantle
                [12609] = true, -- Polychromatic Visionwrap
                [12603] = true, -- Nightbrace Tunic
                [12589] = true, -- Dustfeather Sash
                [12606] = true, -- Crystallized Girdle
                [18657] = true, -- Schematic: Hyper-Radiant Flame Reflector
            },
        },
        {
            id = 10509,
            name = "Jed Runewatcher",
            recorded_loot = {
                [12604] = true, -- Starfire Tiara
                [12930] = true, -- Briarwood Reed
                [12605] = true, -- Serpentine Skuller
            },
        },
        {
            id = 10899,
            name = "Goraluk Anvilcrack",
            recorded_loot = {
                [13502] = true, -- Handcrafted Mastersmith Girdle
                [13498] = true, -- Handcrafted Mastersmith Leggings
                [18047] = true, -- Flame Walkers
                [18048] = true, -- Mastersmith's Hammer
                [12834] = true, -- Plans: Arcanite Champion
                [12837] = true, -- Plans: Masterwork Stormhammer
                [18779] = true, -- Bottom Half of Advanced Armorsmithing: Volume I
                [12696] = true, -- Plans: Demon Forged Breastplate
            },
        },
        {
            id = 10339,
            name = "Gyth",
            recorded_loot = {
                [12871] = true, -- Chromatic Carapace
                [16669] = true, -- Pauldrons of Elements
                [22225] = true, -- Dragonskin Cowl
                [12960] = true, -- Tribal War Feathers
                [12953] = true, -- Dragoneye Coif
                [12952] = true, -- Gyth's Skull
                [13522] = true, -- Recipe: Flask of Chromatic Resistance
            },
        },
        {
            id = 10429,
            name = "Warchief Rend Blackhand",
            recorded_loot = {
                [12590] = true, -- Felstriker
                [16733] = true, -- Spaulders of Valor
                [12587] = true, -- Eye of Rend
                [12588] = true, -- Bonespike Shoulder
                [12936] = true, -- Battleborn Armbraces
                [18104] = true, -- Feralsurge Girdle
                [12935] = true, -- Warmaster Legguards
                [18102] = true, -- Dragonrider Boots
                [22247] = true, -- Faith Healer's Boots
                [18103] = true, -- Band of Rumination
                [12940] = true, -- Dal'Rend's Sacred Charge
                [12939] = true, -- Dal'Rend's Tribal Guardian
                [12583] = true, -- Blackhand Doomsaw
            },
        },
        {
            id = 10430,
            name = "The Beast",
            recorded_loot = {
                [12731] = true, -- Pristine Hide of the Beast
                [16729] = true, -- Lightforge Spaulders
                [12967] = true, -- Bloodmoon Cloak
                [12968] = true, -- Frostweaver Cape
                [12966] = true, -- Blackmist Armguards
                [12965] = true, -- Spiritshroud Leggings
                [12963] = true, -- Blademaster Leggings
                [12964] = true, -- Tristam Legguards
                [22311] = true, -- Ironweave Boots
                [12709] = true, -- Finkle's Skinner
                [12969] = true, -- Seeping Willow
                [24101] = true, -- Book of Ferocious Bite V
                [19227] = true, -- Ace of Beasts
            },
        },
        {
            id = 10363,
            name = "General Drakkisath",
            recorded_loot = {
                [12592] = true, -- Blackblade of Shahram
                [22267] = true, -- Spellweaver's Turban
                [13141] = true, -- Tooth of Gnarr
                [22269] = true, -- Shadow Prowler's Cloak
                [13142] = true, -- Brigam Girdle
                [13098] = true, -- Painweaver Band
                [22268] = true, -- Draconic Infused Emblem
                [22253] = true, -- Tome of the Lost
                [12602] = true, -- Draconian Deflector
                [15730] = true, -- Pattern: Red Dragonscale Breastplate
                [13519] = true, -- Recipe: Flask of the Titans
                [16690] = true, -- Devout Robe
                [16688] = true, -- Magister's Robes
                [16700] = true, -- Dreadmist Robe
                [16721] = true, -- Shadowcraft Tunic
                [16706] = true, -- Wildheart Vest
                [16674] = true, -- Beaststalker's Tunic
                [16666] = true, -- Vest of Elements
                [16726] = true, -- Lightforge Breastplate
                [16730] = true, -- Breastplate of Valor
            },
        },
    },
}
