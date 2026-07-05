-- RazorfenKraul.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

DungeonOracleData.dungeons.razorfen_kraul = {
    id = "razorfen_kraul",
    name = "Razorfen Kraul",
    map_id = 491,
    bosses = {
        -- Razorfen Kraul tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 4424,
            name = "Aggem Thorncurse",
            recorded_loot = {
                -- no loot to be rolled
            },
        },
        {
            id = 4428,
            name = "Death Speaker Jargba",
            recorded_loot = {
                [2816] = true, -- Death Speaker Scepter
                [6685] = true, -- Death Speaker Mantle
                [6682] = true, -- Death Speaker Robes
            },
        },
        {
            id = 4420,
            name = "Overlord Ramtusk",
            recorded_loot = {
                [6687] = true, -- Corpsemaker
                [6686] = true, -- Tusken Helm
            },
        },
        {
            id = 4438,
            name = "Razorfen Spearhide",
            recorded_loot = {
                [6679] = true, -- Armor Piercer
            },
        },
        {
            id = 4422,
            name = "Agathelos the Raging",
            recorded_loot = {
                [6691] = true, -- Swinetusk Shank
                [6690] = true, -- Ferine Leggings
            },
        },
        {
            id = 4425,
            name = "Blind Hunter",
            recorded_loot = {
                [6695] = true, -- Stygian Bone Amulet
                [6697] = true, -- Batwing Mantle
                [6696] = true, -- Nightstalker Bow
            },
        },
        {
            id = 4421,
            name = "Charlga Razorflank",
            recorded_loot = {
                [6693] = true, -- Agamaggan's Clutch
                [6694] = true, -- Heart of Agamaggan
                [6692] = true, -- Pronged Reaver
            },
        },
        {
            id = 4842,
            name = "Earthcaller Halmgar",
            recorded_loot = {
                [6689] = true, -- Wind Spirit Staff
                [6688] = true, -- Whisperwind Headdress
            },
        },
    },
    loot_to_bosses = {
        [2816] = { 4428 }, -- Death Speaker Scepter -> Death Speaker Jargba
        [6685] = { 4428 }, -- Death Speaker Mantle -> Death Speaker Jargba
        [6682] = { 4428 }, -- Death Speaker Robes -> Death Speaker Jargba

        [6687] = { 4420 }, -- Corpsemaker -> Overlord Ramtusk
        [6686] = { 4420 }, -- Tusken Helm -> Overlord Ramtusk

        [6679] = { 4438 }, -- Armor Piercer -> Razorfen Spearhide

        [6691] = { 4422 }, -- Swinetusk Shank -> Agathelos the Raging
        [6690] = { 4422 }, -- Ferine Leggings -> Agathelos the Raging

        [6695] = { 4425 }, -- Stygian Bone Amulet -> Blind Hunter
        [6697] = { 4425 }, -- Batwing Mantle -> Blind Hunter
        [6696] = { 4425 }, -- Nightstalker Bow -> Blind Hunter

        [6693] = { 4421 }, -- Agamaggan's Clutch -> Charlga Razorflank
        [6694] = { 4421 }, -- Heart of Agamaggan -> Charlga Razorflank
        [6692] = { 4421 }, -- Pronged Reaver -> Charlga Razorflank

        [6689] = { 4842 }, -- Wind Spirit Staff -> Earthcaller Halmgar
        [6688] = { 4842 }, -- Whisperwind Headdress -> Earthcaller Halmgar
    },
}
