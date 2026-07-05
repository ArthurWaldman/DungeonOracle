-- BlackrockDepths.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

DungeonOracleData.dungeons.blackrock_depths = {
    id = "blackrock_depths",
    name = "Blackrock Depths",
    map_id = 1584,
    bosses = {
        -- Blackrock Depths tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 9025,
            name = "Lord Roccor",
            recorded_loot = {
                [22234] = true, -- Mantle of Lost Hope
                [11632] = true, -- Earthslag Shoulders
                [11631] = true, -- Stoneshell Guard
                [22397] = true, -- Idol of Ferocity
                [11630] = true, -- Rockshard Pellets
                [11813] = true, -- Formula: Smoking Heart of the Mountain
            },
        },
        {
            id = 9018,
            name = "High Interrogator Gerstahn",
            recorded_loot = {
                [11626] = true, -- Blackveil Cape
                [11624] = true, -- Kentic Amice
                [22240] = true, -- Greaves of Withering Despair
                [11625] = true, -- Enthralled Sphere
            },
        },
        {
            id = 9319,
            name = "Houndmaster Grebmar",
            recorded_loot = {
                [11623] = true, -- Spritecaster Cape
                [11627] = true, -- Fleetfoot Greaves
                [11628] = true, -- Houndmaster's Bow
                [11629] = true, -- Houndmaster's Rifle
            },
        },
        {
            id = 9027,
            name = "Gorosh the Dervish",
            recorded_loot = {
                [11726] = true, -- Savage Gladiator Chain
                [22271] = true, -- Leggings of Frenzied Magic
                [22257] = true, -- Bloodclot Band
                [22266] = true, -- Flarethorn
            },
        },
        {
            id = 9028,
            name = "Grizzle",
            recorded_loot = {
                [11722] = true, -- Dregmetal Spaulders
                [11703] = true, -- Stonewall Girdle
                [22270] = true, -- Entrenching Boots
                [11702] = true, -- Grizzle's Skinner
                [11610] = true, -- Plans: Dark Iron Pulverizer
            },
        },
        {
            id = 9029,
            name = "Eviscerator",
            recorded_loot = {
                [11685] = true, -- Splinthide Shoulders
                [11679] = true, -- Rubicund Armguards
                [11686] = true, -- Girdle of Beastial Fury
                [11730] = true, -- Savage Gladiator Grips
            },
        },
        {
            id = 9030,
            name = "Ok'thor the Breaker",
            recorded_loot = {
                [11665] = true, -- Ogreseer Fists
                [11662] = true, -- Ban'thok Sash
                [11728] = true, -- Savage Gladiator Leggings
                [11824] = true, -- Cyclopean Band
            },
        },
        {
            id = 9031,
            name = "Anub'shiah",
            recorded_loot = {
                [11678] = true, -- Carapace of Anub'shiah
                [11677] = true, -- Graverot Cape
                [11675] = true, -- Shadefiend Boots
                [11731] = true, -- Savage Gladiator Greaves
            },
        },
        {
            id = 9032,
            name = "Hedrum the Creeper",
            recorded_loot = {
                [11633] = true, -- Spiderfang Carapace
                [11634] = true, -- Silkweb Gloves
                [11635] = true, -- Hookfang Shanker
                [11729] = true, -- Savage Gladiator Helm
            },
        },
        {
            id = 9024,
            name = "Pyromancer Loregrain",
            recorded_loot = {
                [11747] = true, -- Flamestrider Robes
                [11749] = true, -- Searingscale Leggings
                [11748] = true, -- Pyric Caduceus
                [11750] = true, -- Kindling Stave
                [11207] = true, -- Formula: Enchant Weapon - Fiery Weapon
            },
        },
        {
            id = 9041,
            name = "Warder Stilgiss",
            recorded_loot = {
                [11782] = true, -- Boreal Mantle
                [22241] = true, -- Dark Warder's Pauldrons
                [11783] = true, -- Chillsteel Girdle
                [11784] = true, -- Arbiter's Blade
            },
        },
        {
            id = 9042,
            name = "Verek",
            recorded_loot = {
                [11755] = true, -- Verek's Collar
                [22242] = true, -- Verek's Leash
            },
        },
        {
            id = 9476,
            name = "Watchman Doomgrip",
            recorded_loot = {
                [22205] = true, -- Black Steel Bindings
                [22255] = true, -- Magma Forged Band
                [22256] = true, -- Mana Shaping Handwraps
                [22254] = true, -- Wand of Eternal Light
            },
        },
        {
            id = 9056,
            name = "Fineous Darkvire",
            recorded_loot = {
                [11839] = true, -- Chief Architect's Monocle
                [22223] = true, -- Foreman's Head Protector
                [11842] = true, -- Lead Surveyor's Mantle
                [11841] = true, -- Senior Designer's Pantaloons
            },
        },
        {
            id = 9017,
            name = "Lord Incendius",
            recorded_loot = {
                [11766] = true, -- Flameweave Cuffs
                [11764] = true, -- Cinderhide Armsplints
                [11765] = true, -- Pyremail Wristguards
                [11767] = true, -- Emberplate Armguards
                [19268] = true, -- Ace of Elementals
                [11768] = true, -- Incendic Bracers
            },
        },
        {
            id = 9016,
            name = "Bael'Gar",
            recorded_loot = {
                [11807] = true, -- Sash of the Burning Heart
                [11802] = true, -- Lavacrest Leggings
                [11805] = true, -- Rubidium Hammer
                [11803] = true, -- Force of Magma
            },
        },
        {
            id = 9033,
            name = "General Angerforge",
            recorded_loot = {
                [11820] = true, -- Royal Decorated Armor
                [11821] = true, -- Warstrife Leggings
                [11810] = true, -- Force of Will
                [11817] = true, -- Lord General's Sword
                [11816] = true, -- Angerforge's Battle Axe
                [11841] = true, -- Senior Designer's Pantaloons
            },
        },
        {
            id = 8983,
            name = "Golem Lord Argelmach",
            recorded_loot = {
                [11823] = true, -- Luminary Kilt
                [11822] = true, -- Omnicast Boots
                [11669] = true, -- Naglering
                [11819] = true, -- Second Wind
            },
        },
        {
            id = 9502,
            name = "Phalanx",
            recorded_loot = {
                [22212] = true, -- Golem Fitted Pauldrons
                [11745] = true, -- Fists of Phalanx
                [11744] = true, -- Bloodfist
                [11743] = true, -- Rockfist
            },
        },
        {
            id = 9156,
            name = "Ambassador Flamelash",
            recorded_loot = {
                [11808] = true, -- Circle of Flame
                [11812] = true, -- Cape of the Fire Salamander
                [11814] = true, -- Molten Fists
                [11832] = true, -- Burst of Knowledge
                [11809] = true, -- Flame Wrath
                [23320] = true, -- Tablet of Flame Shock VI
            },
        },
        {
            id = 8923,
            name = "Panzor the Invincible",
            recorded_loot = {
                [22245] = true, -- Soot Encrusted Footwear
                [11787] = true, -- Shalehusk Boots
                [11785] = true, -- Rock Golem Bulwark
                [11786] = true, -- Stone of the Earth
            },
        },
        {
            id = 9938,
            name = "Magmus",
            recorded_loot = {
                [11746] = true, -- Golem Skull Helm
                [11935] = true, -- Magmus Stone
                [22395] = true, -- Totem of Rage
                [22400] = true, -- Libram of Truth
                [22208] = true, -- Lavastone Hammer
            },
        },
        {
            id = 8929,
            name = "Princess Moira Bronzebeard",
            recorded_loot = {
                [12557] = true, -- Ebonsteel Spaulders
                [12554] = true, -- Hands of the Exalted Herald
                [12556] = true, -- High Priestess Boots
                [12553] = true, -- Swiftwalker Boots
            },
        },
        {
            id = 9019,
            name = "Emperor Dagran Thaurissan",
            recorded_loot = {
                [11684] = true, -- Ironfoe
                [11933] = true, -- Imperial Jewel
                [11930] = true, -- The Emperor's New Cape
                [11924] = true, -- Robes of the Royal Crown
                [22204] = true, -- Wristguards of Renown
                [22207] = true, -- Sash of the Grand Hunt
                [11934] = true, -- Emperor's Seal
                [11815] = true, -- Hand of Justice
                [11928] = true, -- Thaurissan's Royal Scepter
                [11931] = true, -- Dreadforge Retaliator
                [11932] = true, -- Guiding Stave of Wisdom
            },
        },
    },
    loot_to_bosses = {
        [22234] = { 9025 }, -- Mantle of Lost Hope -> Lord Roccor
        [11632] = { 9025 }, -- Earthslag Shoulders -> Lord Roccor
        [11631] = { 9025 }, -- Stoneshell Guard -> Lord Roccor
        [22397] = { 9025 }, -- Idol of Ferocity -> Lord Roccor
        [11630] = { 9025 }, -- Rockshard Pellets -> Lord Roccor
        [11813] = { 9025 }, -- Formula: Smoking Heart of the Mountain -> Lord Roccor

        [11626] = { 9018 }, -- Blackveil Cape -> High Interrogator Gerstahn
        [11624] = { 9018 }, -- Kentic Amice -> High Interrogator Gerstahn
        [22240] = { 9018 }, -- Greaves of Withering Despair -> High Interrogator Gerstahn
        [11625] = { 9018 }, -- Enthralled Sphere -> High Interrogator Gerstahn

        [11623] = { 9319 }, -- Spritecaster Cape -> Houndmaster Grebmar
        [11627] = { 9319 }, -- Fleetfoot Greaves -> Houndmaster Grebmar
        [11628] = { 9319 }, -- Houndmaster's Bow -> Houndmaster Grebmar
        [11629] = { 9319 }, -- Houndmaster's Rifle -> Houndmaster Grebmar

        [11726] = { 9027 }, -- Savage Gladiator Chain -> Gorosh the Dervish
        [22271] = { 9027 }, -- Leggings of Frenzied Magic -> Gorosh the Dervish
        [22257] = { 9027 }, -- Bloodclot Band -> Gorosh the Dervish
        [22266] = { 9027 }, -- Flarethorn -> Gorosh the Dervish

        [11722] = { 9028 }, -- Dregmetal Spaulders -> Grizzle
        [11703] = { 9028 }, -- Stonewall Girdle -> Grizzle
        [22270] = { 9028 }, -- Entrenching Boots -> Grizzle
        [11702] = { 9028 }, -- Grizzle's Skinner -> Grizzle
        [11610] = { 9028 }, -- Plans: Dark Iron Pulverizer -> Grizzle

        [11685] = { 9029 }, -- Splinthide Shoulders -> Eviscerator
        [11679] = { 9029 }, -- Rubicund Armguards -> Eviscerator
        [11686] = { 9029 }, -- Girdle of Beastial Fury -> Eviscerator
        [11730] = { 9029 }, -- Savage Gladiator Grips -> Eviscerator

        [11665] = { 9030 }, -- Ogreseer Fists -> Ok'thor the Breaker
        [11662] = { 9030 }, -- Ban'thok Sash -> Ok'thor the Breaker
        [11728] = { 9030 }, -- Savage Gladiator Leggings -> Ok'thor the Breaker
        [11824] = { 9030 }, -- Cyclopean Band -> Ok'thor the Breaker

        [11678] = { 9031 }, -- Carapace of Anub'shiah -> Anub'shiah
        [11677] = { 9031 }, -- Graverot Cape -> Anub'shiah
        [11675] = { 9031 }, -- Shadefiend Boots -> Anub'shiah
        [11731] = { 9031 }, -- Savage Gladiator Greaves -> Anub'shiah

        [11633] = { 9032 }, -- Spiderfang Carapace -> Hedrum the Creeper
        [11634] = { 9032 }, -- Silkweb Gloves -> Hedrum the Creeper
        [11635] = { 9032 }, -- Hookfang Shanker -> Hedrum the Creeper
        [11729] = { 9032 }, -- Savage Gladiator Helm -> Hedrum the Creeper

        [11747] = { 9024 }, -- Flamestrider Robes -> Pyromancer Loregrain
        [11749] = { 9024 }, -- Searingscale Leggings -> Pyromancer Loregrain
        [11748] = { 9024 }, -- Pyric Caduceus -> Pyromancer Loregrain
        [11750] = { 9024 }, -- Kindling Stave -> Pyromancer Loregrain
        [11207] = { 9024 }, -- Formula: Enchant Weapon - Fiery Weapon -> Pyromancer Loregrain

        [11782] = { 9041 }, -- Boreal Mantle -> Warder Stilgiss
        [22241] = { 9041 }, -- Dark Warder's Pauldrons -> Warder Stilgiss
        [11783] = { 9041 }, -- Chillsteel Girdle -> Warder Stilgiss
        [11784] = { 9041 }, -- Arbiter's Blade -> Warder Stilgiss

        [11755] = { 9042 }, -- Verek's Collar -> Verek
        [22242] = { 9042 }, -- Verek's Leash -> Verek

        [22205] = { 9476 }, -- Black Steel Bindings -> Watchman Doomgrip
        [22255] = { 9476 }, -- Magma Forged Band -> Watchman Doomgrip
        [22256] = { 9476 }, -- Mana Shaping Handwraps -> Watchman Doomgrip
        [22254] = { 9476 }, -- Wand of Eternal Light -> Watchman Doomgrip

        [11839] = { 9056 }, -- Chief Architect's Monocle -> Fineous Darkvire
        [22223] = { 9056 }, -- Foreman's Head Protector -> Fineous Darkvire
        [11842] = { 9056 }, -- Lead Surveyor's Mantle -> Fineous Darkvire
        [11841] = { 9056, 9033 }, -- Senior Designer's Pantaloons -> Fineous Darkvire, General Angerforge

        [11766] = { 9017 }, -- Flameweave Cuffs -> Lord Incendius
        [11764] = { 9017 }, -- Cinderhide Armsplints -> Lord Incendius
        [11765] = { 9017 }, -- Pyremail Wristguards -> Lord Incendius
        [11767] = { 9017 }, -- Emberplate Armguards -> Lord Incendius
        [19268] = { 9017 }, -- Ace of Elementals -> Lord Incendius
        [11768] = { 9017 }, -- Incendic Bracers -> Lord Incendius

        [11807] = { 9016 }, -- Sash of the Burning Heart -> Bael'Gar
        [11802] = { 9016 }, -- Lavacrest Leggings -> Bael'Gar
        [11805] = { 9016 }, -- Rubidium Hammer -> Bael'Gar
        [11803] = { 9016 }, -- Force of Magma -> Bael'Gar

        [11820] = { 9033 }, -- Royal Decorated Armor -> General Angerforge
        [11821] = { 9033 }, -- Warstrife Leggings -> General Angerforge
        [11810] = { 9033 }, -- Force of Will -> General Angerforge
        [11817] = { 9033 }, -- Lord General's Sword -> General Angerforge
        [11816] = { 9033 }, -- Angerforge's Battle Axe -> General Angerforge

        [11823] = { 8983 }, -- Luminary Kilt -> Golem Lord Argelmach
        [11822] = { 8983 }, -- Omnicast Boots -> Golem Lord Argelmach
        [11669] = { 8983 }, -- Naglering -> Golem Lord Argelmach
        [11819] = { 8983 }, -- Second Wind -> Golem Lord Argelmach

        [22212] = { 9502 }, -- Golem Fitted Pauldrons -> Phalanx
        [11745] = { 9502 }, -- Fists of Phalanx -> Phalanx
        [11744] = { 9502 }, -- Bloodfist -> Phalanx
        [11743] = { 9502 }, -- Rockfist -> Phalanx

        [11808] = { 9156 }, -- Circle of Flame -> Ambassador Flamelash
        [11812] = { 9156 }, -- Cape of the Fire Salamander -> Ambassador Flamelash
        [11814] = { 9156 }, -- Molten Fists -> Ambassador Flamelash
        [11832] = { 9156 }, -- Burst of Knowledge -> Ambassador Flamelash
        [11809] = { 9156 }, -- Flame Wrath -> Ambassador Flamelash
        [23320] = { 9156 }, -- Tablet of Flame Shock VI -> Ambassador Flamelash

        [22245] = { 8923 }, -- Soot Encrusted Footwear -> Panzor the Invincible
        [11787] = { 8923 }, -- Shalehusk Boots -> Panzor the Invincible
        [11785] = { 8923 }, -- Rock Golem Bulwark -> Panzor the Invincible
        [11786] = { 8923 }, -- Stone of the Earth -> Panzor the Invincible

        [11746] = { 9938 }, -- Golem Skull Helm -> Magmus
        [11935] = { 9938 }, -- Magmus Stone -> Magmus
        [22395] = { 9938 }, -- Totem of Rage -> Magmus
        [22400] = { 9938 }, -- Libram of Truth -> Magmus
        [22208] = { 9938 }, -- Lavastone Hammer -> Magmus

        [12557] = { 8929 }, -- Ebonsteel Spaulders -> Princess Moira Bronzebeard
        [12554] = { 8929 }, -- Hands of the Exalted Herald -> Princess Moira Bronzebeard
        [12556] = { 8929 }, -- High Priestess Boots -> Princess Moira Bronzebeard
        [12553] = { 8929 }, -- Swiftwalker Boots -> Princess Moira Bronzebeard

        [11684] = { 9019 }, -- Ironfoe -> Emperor Dagran Thaurissan
        [11933] = { 9019 }, -- Imperial Jewel -> Emperor Dagran Thaurissan
        [11930] = { 9019 }, -- The Emperor's New Cape -> Emperor Dagran Thaurissan
        [11924] = { 9019 }, -- Robes of the Royal Crown -> Emperor Dagran Thaurissan
        [22204] = { 9019 }, -- Wristguards of Renown -> Emperor Dagran Thaurissan
        [22207] = { 9019 }, -- Sash of the Grand Hunt -> Emperor Dagran Thaurissan
        [11934] = { 9019 }, -- Emperor's Seal -> Emperor Dagran Thaurissan
        [11815] = { 9019 }, -- Hand of Justice -> Emperor Dagran Thaurissan
        [11928] = { 9019 }, -- Thaurissan's Royal Scepter -> Emperor Dagran Thaurissan
        [11931] = { 9019 }, -- Dreadforge Retaliator -> Emperor Dagran Thaurissan
        [11932] = { 9019 }, -- Guiding Stave of Wisdom -> Emperor Dagran Thaurissan
    },
}
