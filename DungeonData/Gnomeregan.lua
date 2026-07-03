-- Gnomeregan.lua defines the static dungeon metadata used by the addon.

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
}
