-- Uldaman.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

DungeonOracleData.dungeons.uldaman = {
    id = "uldaman",
    name = "Uldaman",
    map_id = 1337,
    bosses = {
        -- Uldaman tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 6907,
            name = "Eric \"The Swift\"",
            recorded_loot = {
                [9394] = true, -- Horned Viking Helmet
                [9398] = true, -- Worn Running Boots
            },
        },
        {
            id = 6906,
            name = "Baelog",
            recorded_loot = {
                [9401] = true, -- Nordic Longshank
                [9399] = true, -- Precision Arrow
            },
        },
        {
            id = 6908,
            name = "Olaf",
            recorded_loot = {
                [9404] = true, -- Olaf's All Purpose Shield
            },
        },
        {
            id = 6910,
            name = "Revelosh",
            recorded_loot = {
                [9389] = true, -- Revelosh's Spaulders
                [9388] = true, -- Revelosh's Armguards
                [9390] = true, -- Revelosh's Gloves
                [9387] = true, -- Revelosh's Boots
            },
        },
        {
            id = 7228,
            name = "Ironaya",
            recorded_loot = {
                [9409] = true, -- Ironaya's Bracers
                [9407] = true, -- Stoneweaver Leggings
                [9408] = true, -- Ironshod Bludgeon
            },
        },
        {
            id = 7023,
            name = "Obsidian Sentinel",
            recorded_loot = {
                -- no loot to be rolled
            },
        },
        {
            id = 7206,
            name = "Ancient Stone Keeper",
            recorded_loot = {
                [9410] = true, -- Cragfists
                [9411] = true, -- Rockshard Pauldrons
            },
        },
        {
            id = 7291,
            name = "Galgann Firehammer",
            recorded_loot = {
                [11310] = true, -- Flameseer Mantle
                [9412] = true, -- Galgann's Fireblaster
                [11311] = true, -- Emberscale Cape
                [9419] = true, -- Galgann's Firehammer
            },
        },
        {
            id = 4854,
            name = "Grimlok",
            recorded_loot = {
                [9415] = true, -- Grimlok's Tribal Vestments
                [9416] = true, -- Grimlok's Charge
                [9414] = true, -- Oilskin Leggings
            },
        },
        {
            id = 2748,
            name = "Archaedas",
            recorded_loot = {
                [11118] = true, -- Archaedic Stone
                [9413] = true, -- The Rockpounder
                [9418] = true, -- Stoneslayer
            },
        },
    },
    loot_to_bosses = {
        [9394] = { 6907 }, -- Horned Viking Helmet -> Eric "The Swift"
        [9398] = { 6907 }, -- Worn Running Boots -> Eric "The Swift"

        [9401] = { 6906 }, -- Nordic Longshank -> Baelog
        [9399] = { 6906 }, -- Precision Arrow -> Baelog

        [9404] = { 6908 }, -- Olaf's All Purpose Shield -> Olaf

        [9389] = { 6910 }, -- Revelosh's Spaulders -> Revelosh
        [9388] = { 6910 }, -- Revelosh's Armguards -> Revelosh
        [9390] = { 6910 }, -- Revelosh's Gloves -> Revelosh
        [9387] = { 6910 }, -- Revelosh's Boots -> Revelosh

        [9409] = { 7228 }, -- Ironaya's Bracers -> Ironaya
        [9407] = { 7228 }, -- Stoneweaver Leggings -> Ironaya
        [9408] = { 7228 }, -- Ironshod Bludgeon -> Ironaya

        [9410] = { 7206 }, -- Cragfists -> Ancient Stone Keeper
        [9411] = { 7206 }, -- Rockshard Pauldrons -> Ancient Stone Keeper

        [11310] = { 7291 }, -- Flameseer Mantle -> Galgann Firehammer
        [9412] = { 7291 }, -- Galgann's Fireblaster -> Galgann Firehammer
        [11311] = { 7291 }, -- Emberscale Cape -> Galgann Firehammer
        [9419] = { 7291 }, -- Galgann's Firehammer -> Galgann Firehammer

        [9415] = { 4854 }, -- Grimlok's Tribal Vestments -> Grimlok
        [9416] = { 4854 }, -- Grimlok's Charge -> Grimlok
        [9414] = { 4854 }, -- Oilskin Leggings -> Grimlok

        [11118] = { 2748 }, -- Archaedic Stone -> Archaedas
        [9413] = { 2748 }, -- The Rockpounder -> Archaedas
        [9418] = { 2748 }, -- Stoneslayer -> Archaedas
    },
}
