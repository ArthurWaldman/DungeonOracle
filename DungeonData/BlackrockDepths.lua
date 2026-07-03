-- BlackrockDepths.lua defines the static dungeon metadata used by the addon.

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
}
