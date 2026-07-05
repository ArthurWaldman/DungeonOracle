-- RazorfenDowns.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

DungeonOracleData.dungeons.razorfen_downs = {
    id = "razorfen_downs",
    name = "Razorfen Downs",
    map_id = 722,
    bosses = {
        -- Razorfen Downs tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 7355,
            name = "Tuten'kash",
            recorded_loot = {
                [10776] = true, -- Silky Spider Cape
                [10775] = true, -- Carapace of Tuten'kash
                [10777] = true, -- Arachnid Gloves
            },
        },
        {
            id = 7357,
            name = "Mordresh Fire Eye",
            recorded_loot = {
                [10769] = true, -- Glowing Eye of Mordresh
                [10771] = true, -- Deathmage Sash
                [10770] = true, -- Mordresh's Lifeless Skull
            },
        },
        {
            id = 8567,
            name = "Glutton",
            recorded_loot = {
                [10774] = true, -- Fleshhide Shoulders
                [10772] = true, -- Glutton's Cleaver
            },
        },
        {
            id = 7354,
            name = "Ragglesnout",
            recorded_loot = {
                [10768] = true, -- Boar Champion's Belt
                [10767] = true, -- Savage Boar's Guard
                [10758] = true, -- X'caliboar
            },
        },
        {
            id = 7358,
            name = "Amnennar the Coldbringer",
            recorded_loot = {
                [10763] = true, -- Icemetal Barbute
                [10762] = true, -- Robes of the Lich
                [10764] = true, -- Deathchill Armor
                [10761] = true, -- Coldrage Dagger
                [10765] = true, -- Bonefingers
            },
        },
        {
            id = 7356,
            name = "Plaguemaw the Rotting",
            recorded_loot = {
                [10766] = true, -- Plaguerot Sprig
                [10760] = true, -- Swine Fists
            },
        },
    },
    loot_to_bosses = {
        [10776] = { 7355 }, -- Silky Spider Cape -> Tuten'kash
        [10775] = { 7355 }, -- Carapace of Tuten'kash -> Tuten'kash
        [10777] = { 7355 }, -- Arachnid Gloves -> Tuten'kash

        [10769] = { 7357 }, -- Glowing Eye of Mordresh -> Mordresh Fire Eye
        [10771] = { 7357 }, -- Deathmage Sash -> Mordresh Fire Eye
        [10770] = { 7357 }, -- Mordresh's Lifeless Skull -> Mordresh Fire Eye

        [10774] = { 8567 }, -- Fleshhide Shoulders -> Glutton
        [10772] = { 8567 }, -- Glutton's Cleaver -> Glutton

        [10768] = { 7354 }, -- Boar Champion's Belt -> Ragglesnout
        [10767] = { 7354 }, -- Savage Boar's Guard -> Ragglesnout
        [10758] = { 7354 }, -- X'caliboar -> Ragglesnout

        [10763] = { 7358 }, -- Icemetal Barbute -> Amnennar the Coldbringer
        [10762] = { 7358 }, -- Robes of the Lich -> Amnennar the Coldbringer
        [10764] = { 7358 }, -- Deathchill Armor -> Amnennar the Coldbringer
        [10761] = { 7358 }, -- Coldrage Dagger -> Amnennar the Coldbringer
        [10765] = { 7358 }, -- Bonefingers -> Amnennar the Coldbringer

        [10766] = { 7356 }, -- Plaguerot Sprig -> Plaguemaw the Rotting
        [10760] = { 7356 }, -- Swine Fists -> Plaguemaw the Rotting
    },
}
