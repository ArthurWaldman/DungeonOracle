-- Gnomeregan.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

DungeonOracleData.dungeons.gnomeregan = {
    id = "gnomeregan",
    name = "Gnomeregan",
    map_id = 721,
    bosses = {
        -- Gnomeregan tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 6231,
            name = "Techbot",
            recorded_loot = {
                -- no loot to be rolled
            },
        },
        {
            id = 7361,
            name = "Grubbis",
            recorded_loot = {
                [9445] = true, -- Grubbis Paws
            },
        },
        {
            id = 7079,
            name = "Viscous Fallout",
            recorded_loot = {
                [9454] = true, -- Acidic Walkers
                [9453] = true, -- Toxic Revenger
                [9452] = true, -- Hydrocane
            },
        },
        {
            id = 6235,
            name = "Electrocutioner 6000",
            recorded_loot = {
                [9447] = true, -- Electrocutioner Lagnut
                [9446] = true, -- Electrocutioner Leg
                [9448] = true, -- Spidertank Oilrag
            },
        },
        {
            id = 6229,
            name = "Crowd Pummeler 9-60",
            recorded_loot = {
                [9449] = true, -- Manual Crowd Pummeler
                [9450] = true, -- Gnomebot Operating Boots
            },
        },
        {
            id = 6228,
            name = "Dark Iron Ambassador",
            recorded_loot = {
                [9455] = true, -- Emissary Cuffs
                [9456] = true, -- Glass Shooter
                [9457] = true, -- Royal Diplomatic Scepter
            },
        },
        {
            id = 7800,
            name = "Mekgineer Thermaplugg",
            recorded_loot = {
                [9492] = true, -- Electromagnetic Gigaflux Reactivator
                [9461] = true, -- Charged Gear
                [9458] = true, -- Thermaplugg's Central Core
                [9459] = true, -- Thermaplugg's Left Arm
                [4415] = true, -- Schematic: Craftsman's Monocle
                [4413] = true, -- Schematic: Discombobulator Ray
                [4411] = true, -- Schematic: Flame Deflector
                [7742] = true, -- Schematic: Gnomish Cloaking Device
                [11828] = true, -- Schematic: Pet Bombling
            },
        },
    },
    loot_to_bosses = {
        [9445] = { 7361 }, -- Grubbis Paws -> Grubbis

        [9454] = { 7079 }, -- Acidic Walkers -> Viscous Fallout
        [9453] = { 7079 }, -- Toxic Revenger -> Viscous Fallout
        [9452] = { 7079 }, -- Hydrocane -> Viscous Fallout

        [9447] = { 6235 }, -- Electrocutioner Lagnut -> Electrocutioner 6000
        [9446] = { 6235 }, -- Electrocutioner Leg -> Electrocutioner 6000
        [9448] = { 6235 }, -- Spidertank Oilrag -> Electrocutioner 6000

        [9449] = { 6229 }, -- Manual Crowd Pummeler -> Crowd Pummeler 9-60
        [9450] = { 6229 }, -- Gnomebot Operating Boots -> Crowd Pummeler 9-60

        [9455] = { 6228 }, -- Emissary Cuffs -> Dark Iron Ambassador
        [9456] = { 6228 }, -- Glass Shooter -> Dark Iron Ambassador
        [9457] = { 6228 }, -- Royal Diplomatic Scepter -> Dark Iron Ambassador

        [9492] = { 7800 }, -- Electromagnetic Gigaflux Reactivator -> Mekgineer Thermaplugg
        [9461] = { 7800 }, -- Charged Gear -> Mekgineer Thermaplugg
        [9458] = { 7800 }, -- Thermaplugg's Central Core -> Mekgineer Thermaplugg
        [9459] = { 7800 }, -- Thermaplugg's Left Arm -> Mekgineer Thermaplugg
        [4415] = { 7800 }, -- Schematic: Craftsman's Monocle -> Mekgineer Thermaplugg
        [4413] = { 7800 }, -- Schematic: Discombobulator Ray -> Mekgineer Thermaplugg
        [4411] = { 7800 }, -- Schematic: Flame Deflector -> Mekgineer Thermaplugg
        [7742] = { 7800 }, -- Schematic: Gnomish Cloaking Device -> Mekgineer Thermaplugg
        [11828] = { 7800 }, -- Schematic: Pet Bombling -> Mekgineer Thermaplugg
    },
}
