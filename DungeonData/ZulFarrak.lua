-- ZulFarrak.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

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
    loot_to_bosses = {
        [9640] = { 8127 }, -- Vice Grips -> Antu'sul
        [9641] = { 8127 }, -- Lifeblood Amulet -> Antu'sul
        [9639] = { 8127 }, -- The Hand of Antu'sul -> Antu'sul
        [9379] = { 8127 }, -- Sang'thraze the Deflector -> Antu'sul

        [18083] = { 7271 }, -- Jumanza Grips -> Witch Doctor Zum'rah
        [18082] = { 7271 }, -- Zum'rah's Vexing Cane -> Witch Doctor Zum'rah

        [9470] = { 7275 }, -- Bad Mojo Mask -> Shadowpriest Sezz'ziz
        [9473] = { 7275 }, -- Jinxed Hoodoo Skin -> Shadowpriest Sezz'ziz
        [9474] = { 7275 }, -- Jinxed Hoodoo Kilt -> Shadowpriest Sezz'ziz
        [9475] = { 7275 }, -- Diabolic Skiver -> Shadowpriest Sezz'ziz

        [12471] = { 10081 }, -- Desertwalker Cane -> Dustwraith

        [9469] = { 7273 }, -- Gahz'rilla Scale Armor -> Gahz'rilla
        [9467] = { 7273 }, -- Gahz'rilla Fang -> Gahz'rilla

        [9479] = { 7267 }, -- Embrace of the Lycan -> Chief Ukorz Sandscalp
        [9476] = { 7267 }, -- Big Bad Pauldrons -> Chief Ukorz Sandscalp
        [9478] = { 7267 }, -- Ripsaw -> Chief Ukorz Sandscalp
        [9477] = { 7267 }, -- The Chief's Enforcer -> Chief Ukorz Sandscalp
        [11086] = { 7267 }, -- Jang'thraze the Protector -> Chief Ukorz Sandscalp

        [12470] = { 10082 }, -- Sandstalker Ankleguards -> Zerillis
    },
}
