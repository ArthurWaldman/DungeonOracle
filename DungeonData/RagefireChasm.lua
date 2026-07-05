-- RagefireChasm.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

DungeonOracleData.dungeons.ragefire_chasm = {
    id = "ragefire_chasm",
    name = "Ragefire Chasm",
    bosses = {
        -- Ragefire Chasm tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 11520,
            name = "Taragaman the Hungerer",
            recorded_loot = {
                [14149] = true, -- Subterranean Cape
                [14148] = true, -- Crystalline Cuffs
                [14145] = true, -- Cursed Felblade
            },
        },
        {
            id = 11518,
            name = "Jergosh the Invoker",
            recorded_loot = {
                [14150] = true, -- Robe of Evocation
                [14147] = true, -- Cavedweller Bracers
                [14151] = true, -- Chanting Blade
            },
        },
    },
    loot_to_bosses = {
        [14149] = { 11520 }, -- Subterranean Cape -> Taragaman the Hungerer
        [14148] = { 11520 }, -- Crystalline Cuffs -> Taragaman the Hungerer
        [14145] = { 11520 }, -- Cursed Felblade -> Taragaman the Hungerer

        [14150] = { 11518 }, -- Robe of Evocation -> Jergosh the Invoker
        [14147] = { 11518 }, -- Cavedweller Bracers -> Jergosh the Invoker
        [14151] = { 11518 }, -- Chanting Blade -> Jergosh the Invoker
    },
}
