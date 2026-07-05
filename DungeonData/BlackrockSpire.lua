-- BlackrockSpire.lua defines the shared Blackrock Spire instance.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

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
    loot_to_bosses = {
        [13181] = { 10263 }, -- Demonskin Gloves -> Burning Felguard
        [13182] = { 10263 }, -- Phase Blade -> Burning Felguard

        [12608] = { 9219 }, -- Butcher's Apron -> Spirestone Butcher
        [13286] = { 9219 }, -- Rivenspike -> Spirestone Butcher

        [16670] = { 9196 }, -- Boots of Elements -> Highlord Omokk
        [13166] = { 9196 }, -- Slamshot Shoulders -> Highlord Omokk
        [13168] = { 9196 }, -- Plate of the Shaman King -> Highlord Omokk
        [13170] = { 9196 }, -- Skyshroud Leggings -> Highlord Omokk
        [13169] = { 9196 }, -- Tressermane Leggings -> Highlord Omokk
        [13167] = { 9196 }, -- Fist of Omokk -> Highlord Omokk
        [12336] = { 9196 }, -- Gemstone of Spirestone -> Highlord Omokk

        [13284] = { 9218 }, -- Swiftdart Battleboots -> Spirestone Battle Lord
        [13285] = { 9218 }, -- The Nicker -> Spirestone Battle Lord

        [13282] = { 9217 }, -- Ogreseer Tower Boots -> Spirestone Lord Magus
        [13283] = { 9217 }, -- Magus Ring -> Spirestone Lord Magus
        [13261] = { 9217 }, -- Globe of D'sak -> Spirestone Lord Magus

        [16712] = { 9236 }, -- Shadowcraft Gloves -> Shadow Hunter Vosh'gajin
        [13257] = { 9236 }, -- Demonic Runed Spaulders -> Shadow Hunter Vosh'gajin
        [12626] = { 9236 }, -- Funeral Cuffs -> Shadow Hunter Vosh'gajin
        [13255] = { 9236 }, -- Trueaim Gauntlets -> Shadow Hunter Vosh'gajin
        [12653] = { 9236 }, -- Riphook -> Shadow Hunter Vosh'gajin
        [12651] = { 9236 }, -- Blackcrow -> Shadow Hunter Vosh'gajin
        [12654] = { 9236 }, -- Doomshot -> Shadow Hunter Vosh'gajin

        [16676] = { 9237 }, -- Beaststalker's Gloves -> War Master Voone
        [13177] = { 9237 }, -- Talisman of Evasion -> War Master Voone
        [13179] = { 9237 }, -- Brazecore Armguards -> War Master Voone
        [22231] = { 9237 }, -- Kayser's Boots of Precision -> War Master Voone
        [13173] = { 9237 }, -- Flightblade Throwing Axe -> War Master Voone
        [12582] = { 9237 }, -- Keris of Zul'Serak -> War Master Voone
        [12335] = { 9237 }, -- Gemstone of Smolderthorn -> War Master Voone

        [12637] = { 9596 }, -- Backusarian Gauntlets -> Bannok Grimaxe
        [12634] = { 9596 }, -- Chiselbrand Girdle -> Bannok Grimaxe
        [12621] = { 9596 }, -- Demonfork -> Bannok Grimaxe
        [12838] = { 9596 }, -- Plans: Arcanite Reaper -> Bannok Grimaxe

        [16715] = { 10596 }, -- Wildheart Boots -> Mother Smolderweb
        [13244] = { 10596 }, -- Gilded Gauntlets -> Mother Smolderweb
        [13213] = { 10596 }, -- Smolderweb's Eye -> Mother Smolderweb
        [13183] = { 10596 }, -- Venomspitter -> Mother Smolderweb

        [13185] = { 10376 }, -- Sunderseer Mantle -> Crystal Fang
        [13184] = { 10376 }, -- Fallbrush Handgrips -> Crystal Fang
        [13218] = { 10376 }, -- Fang of the Crystal Spider -> Crystal Fang

        [13258] = { 10584 }, -- Slaghide Gauntlets -> Urok Doomhowl
        [22232] = { 10584 }, -- Marksman's Girdle -> Urok Doomhowl
        [13259] = { 10584 }, -- Ribsteel Footguards -> Urok Doomhowl
        [13178] = { 10584 }, -- Rosewine Circle -> Urok Doomhowl
        [18784] = { 10584 }, -- Top Half of Advanced Armorsmithing: Volume III -> Urok Doomhowl

        [13247] = { 9736 }, -- Quartermaster Zigris' Footlocker -> Quartermaster Zigris
        [13253] = { 9736 }, -- Hands of Power -> Quartermaster Zigris
        [13252] = { 9736 }, -- Cloudrunner Girdle -> Quartermaster Zigris
        [12835] = { 9736 }, -- Plans: Annihilator -> Quartermaster Zigris

        [13212] = { 10220 }, -- Halycon's Spiked Collar -> Halycon
        [22313] = { 10220 }, -- Ironweave Bracers -> Halycon
        [13211] = { 10220 }, -- Slashclaw Bracers -> Halycon
        [13210] = { 10220 }, -- Pads of the Dread Wolf -> Halycon

        [16718] = { 10268 }, -- Wildheart Spaulders -> Gizrul the Slavener
        [13208] = { 10268 }, -- Bleak Howler Armguards -> Gizrul the Slavener
        [13206] = { 10268 }, -- Wolfshear Leggings -> Gizrul the Slavener
        [13205] = { 10268 }, -- Rhombeard Protector -> Gizrul the Slavener

        [13203] = { 9718 }, -- Armswake Cloak -> Ghok Bashguud
        [13198] = { 9718 }, -- Hurd Smasher -> Ghok Bashguud
        [13204] = { 9718 }, -- Bashguuder -> Ghok Bashguud

        [13143] = { 9568 }, -- Mark of the Dragon Lord -> Overlord Wyrmthalak
        [16679] = { 9568 }, -- Beaststalker's Mantle -> Overlord Wyrmthalak
        [13162] = { 9568 }, -- Reiver Claws -> Overlord Wyrmthalak
        [13164] = { 9568 }, -- Heart of the Scale -> Overlord Wyrmthalak
        [22321] = { 9568 }, -- Heart of Wyrmthalak -> Overlord Wyrmthalak
        [13163] = { 9568 }, -- Relentless Scythe -> Overlord Wyrmthalak
        [13148] = { 9568 }, -- Chillpike -> Overlord Wyrmthalak
        [13161] = { 9568 }, -- Trindlehaven Staff -> Overlord Wyrmthalak
        [12337] = { 9568 }, -- Gemstone of Bloodaxe -> Overlord Wyrmthalak

        [16672] = { 9816 }, -- Gauntlets of Elements -> Pyroguard Emberseer
        [12929] = { 9816 }, -- Emberfury Talisman -> Pyroguard Emberseer
        [12927] = { 9816 }, -- Truestrike Shoulders -> Pyroguard Emberseer
        [12905] = { 9816 }, -- Wildfire Cape -> Pyroguard Emberseer
        [12926] = { 9816 }, -- Flaming Band -> Pyroguard Emberseer
        [23320] = { 9816 }, -- Tablet of Flame Shock VI -> Pyroguard Emberseer

        [16695] = { 10264 }, -- Devout Mantle -> Solakar Flamewreath
        [12609] = { 10264 }, -- Polychromatic Visionwrap -> Solakar Flamewreath
        [12603] = { 10264 }, -- Nightbrace Tunic -> Solakar Flamewreath
        [12589] = { 10264 }, -- Dustfeather Sash -> Solakar Flamewreath
        [12606] = { 10264 }, -- Crystallized Girdle -> Solakar Flamewreath
        [18657] = { 10264 }, -- Schematic: Hyper-Radiant Flame Reflector -> Solakar Flamewreath

        [12604] = { 10509 }, -- Starfire Tiara -> Jed Runewatcher
        [12930] = { 10509 }, -- Briarwood Reed -> Jed Runewatcher
        [12605] = { 10509 }, -- Serpentine Skuller -> Jed Runewatcher

        [13502] = { 10899 }, -- Handcrafted Mastersmith Girdle -> Goraluk Anvilcrack
        [13498] = { 10899 }, -- Handcrafted Mastersmith Leggings -> Goraluk Anvilcrack
        [18047] = { 10899 }, -- Flame Walkers -> Goraluk Anvilcrack
        [18048] = { 10899 }, -- Mastersmith's Hammer -> Goraluk Anvilcrack
        [12834] = { 10899 }, -- Plans: Arcanite Champion -> Goraluk Anvilcrack
        [12837] = { 10899 }, -- Plans: Masterwork Stormhammer -> Goraluk Anvilcrack
        [18779] = { 10899 }, -- Bottom Half of Advanced Armorsmithing: Volume I -> Goraluk Anvilcrack
        [12696] = { 10899 }, -- Plans: Demon Forged Breastplate -> Goraluk Anvilcrack

        [12871] = { 10339 }, -- Chromatic Carapace -> Gyth
        [16669] = { 10339 }, -- Pauldrons of Elements -> Gyth
        [22225] = { 10339 }, -- Dragonskin Cowl -> Gyth
        [12960] = { 10339 }, -- Tribal War Feathers -> Gyth
        [12953] = { 10339 }, -- Dragoneye Coif -> Gyth
        [12952] = { 10339 }, -- Gyth's Skull -> Gyth
        [13522] = { 10339 }, -- Recipe: Flask of Chromatic Resistance -> Gyth

        [12590] = { 10429 }, -- Felstriker -> Warchief Rend Blackhand
        [16733] = { 10429 }, -- Spaulders of Valor -> Warchief Rend Blackhand
        [12587] = { 10429 }, -- Eye of Rend -> Warchief Rend Blackhand
        [12588] = { 10429 }, -- Bonespike Shoulder -> Warchief Rend Blackhand
        [12936] = { 10429 }, -- Battleborn Armbraces -> Warchief Rend Blackhand
        [18104] = { 10429 }, -- Feralsurge Girdle -> Warchief Rend Blackhand
        [12935] = { 10429 }, -- Warmaster Legguards -> Warchief Rend Blackhand
        [18102] = { 10429 }, -- Dragonrider Boots -> Warchief Rend Blackhand
        [22247] = { 10429 }, -- Faith Healer's Boots -> Warchief Rend Blackhand
        [18103] = { 10429 }, -- Band of Rumination -> Warchief Rend Blackhand
        [12940] = { 10429 }, -- Dal'Rend's Sacred Charge -> Warchief Rend Blackhand
        [12939] = { 10429 }, -- Dal'Rend's Tribal Guardian -> Warchief Rend Blackhand
        [12583] = { 10429 }, -- Blackhand Doomsaw -> Warchief Rend Blackhand

        [12731] = { 10430 }, -- Pristine Hide of the Beast -> The Beast
        [16729] = { 10430 }, -- Lightforge Spaulders -> The Beast
        [12967] = { 10430 }, -- Bloodmoon Cloak -> The Beast
        [12968] = { 10430 }, -- Frostweaver Cape -> The Beast
        [12966] = { 10430 }, -- Blackmist Armguards -> The Beast
        [12965] = { 10430 }, -- Spiritshroud Leggings -> The Beast
        [12963] = { 10430 }, -- Blademaster Leggings -> The Beast
        [12964] = { 10430 }, -- Tristam Legguards -> The Beast
        [22311] = { 10430 }, -- Ironweave Boots -> The Beast
        [12709] = { 10430 }, -- Finkle's Skinner -> The Beast
        [12969] = { 10430 }, -- Seeping Willow -> The Beast
        [24101] = { 10430 }, -- Book of Ferocious Bite V -> The Beast
        [19227] = { 10430 }, -- Ace of Beasts -> The Beast

        [12592] = { 10363 }, -- Blackblade of Shahram -> General Drakkisath
        [22267] = { 10363 }, -- Spellweaver's Turban -> General Drakkisath
        [13141] = { 10363 }, -- Tooth of Gnarr -> General Drakkisath
        [22269] = { 10363 }, -- Shadow Prowler's Cloak -> General Drakkisath
        [13142] = { 10363 }, -- Brigam Girdle -> General Drakkisath
        [13098] = { 10363 }, -- Painweaver Band -> General Drakkisath
        [22268] = { 10363 }, -- Draconic Infused Emblem -> General Drakkisath
        [22253] = { 10363 }, -- Tome of the Lost -> General Drakkisath
        [12602] = { 10363 }, -- Draconian Deflector -> General Drakkisath
        [15730] = { 10363 }, -- Pattern: Red Dragonscale Breastplate -> General Drakkisath
        [13519] = { 10363 }, -- Recipe: Flask of the Titans -> General Drakkisath
        [16690] = { 10363 }, -- Devout Robe -> General Drakkisath
        [16688] = { 10363 }, -- Magister's Robes -> General Drakkisath
        [16700] = { 10363 }, -- Dreadmist Robe -> General Drakkisath
        [16721] = { 10363 }, -- Shadowcraft Tunic -> General Drakkisath
        [16706] = { 10363 }, -- Wildheart Vest -> General Drakkisath
        [16674] = { 10363 }, -- Beaststalker's Tunic -> General Drakkisath
        [16666] = { 10363 }, -- Vest of Elements -> General Drakkisath
        [16726] = { 10363 }, -- Lightforge Breastplate -> General Drakkisath
        [16730] = { 10363 }, -- Breastplate of Valor -> General Drakkisath
    },
}
