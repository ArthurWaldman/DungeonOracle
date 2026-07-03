-- ZulFarrak.lua defines the static dungeon metadata used by the addon.

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
DungeonOracleData.dungeons.zul_farrak = {
    id = "zul_farrak",
    name = "Zul'Farrak",
    map_id = 1176,
    bosses = {
        -- Zul'Farrak tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 8127,
            name = "Antu'sul",
            recorded_loot = {
                [9640] = true, -- Vice Grips
                [9641] = true, -- Lifeblood Amulet
                [9639] = true, -- The Hand of Antu'sul
                [9379] = true, -- Sang'thraze the Deflector
            },
        },
        {
            id = 10080,
            name = "Sandarr Dunereaver",
            recorded_loot = {
                -- no loot to be rolled
            },
        },
        {
            id = 7271,
            name = "Witch Doctor Zum'rah",
            recorded_loot = {
                [18083] = true, -- Jumanza Grips
                [18082] = true, -- Zum'rah's Vexing Cane
            },
        },
        {
            id = 7275,
            name = "Shadowpriest Sezz'ziz",
            recorded_loot = {
                [9470] = true, -- Bad Mojo Mask
                [9473] = true, -- Jinxed Hoodoo Skin
                [9474] = true, -- Jinxed Hoodoo Kilt
                [9475] = true, -- Diabolic Skiver
            },
        },
        {
            id = 10081,
            name = "Dustwraith",
            recorded_loot = {
                [12471] = true, -- Desertwalker Cane
            },
        },
        {
            id = 7274,
            name = "Sandfury Executioner",
            recorded_loot = {
                -- no loot to be rolled
            },
        },
        {
            id = 7273,
            name = "Gahz'rilla",
            recorded_loot = {
                [9469] = true, -- Gahz'rilla Scale Armor
                [9467] = true, -- Gahz'rilla Fang
            },
        },
        {
            id = 7267,
            name = "Chief Ukorz Sandscalp",
            recorded_loot = {
                [9479] = true, -- Embrace of the Lycan
                [9476] = true, -- Big Bad Pauldrons
                [9478] = true, -- Ripsaw
                [9477] = true, -- The Chief's Enforcer
                [11086] = true, -- Jang'thraze the Protector
            },
        },
        {
            id = 10082,
            name = "Zerillis",
            recorded_loot = {
                [12470] = true, -- Sandstalker Ankleguards
            },
        },
    },
}
