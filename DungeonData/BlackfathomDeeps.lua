-- BlackfathomDeeps.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

DungeonOracleData.dungeons.blackfathom_deeps = {
    id = "blackfathom_deeps",
    name = "Blackfathom Deeps",
    bosses = {
        -- Blackfathom Deeps tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 4887,
            name = "Ghamoo-ra",
            recorded_loot = {
                [6907] = true, -- Tortoise Armor
                [6908] = true, -- Ghamoo-ra's Bind
            },
        },
        {
            id = 4831,
            name = "Lady Sarevess",
            recorded_loot = {
                [888] = true, -- Naga Battle Gloves
                [3078] = true, -- Naga Heartpiercer
                [11121] = true, -- Darkwater Talwar
            },
        },
        {
            id = 6243,
            name = "Gelihast",
            recorded_loot = {
                [6906] = true, -- Algae Fists
                [6905] = true, -- Reef Axe
            },
        },
        {
            id = 4832,
            name = "Twilight Lord Kelris",
            recorded_loot = {
                [1155] = true, -- Rod of the Sleepwalker
                [6903] = true, -- Gaze Dreamer Pants
            },
        },
        {
            id = 4830,
            name = "Old Serra'kis",
            recorded_loot = {
                [6901] = true, -- Glowing Thresher Cape
                [6904] = true, -- Bite of Serra'kis
                [6902] = true, -- Bands of Serra'kis
            },
        },
        {
            id = 4829,
            name = "Aku'mai",
            recorded_loot = {
                [6911] = true, -- Moss Cinch
                [6910] = true, -- Leech Pants
                [6909] = true, -- Strike of the Hydra
            },
        },
    },
    loot_to_bosses = {
        [6907] = { 4887 }, -- Tortoise Armor -> Ghamoo-ra
        [6908] = { 4887 }, -- Ghamoo-ra's Bind -> Ghamoo-ra

        [888] = { 4831 }, -- Naga Battle Gloves -> Lady Sarevess
        [3078] = { 4831 }, -- Naga Heartpiercer -> Lady Sarevess
        [11121] = { 4831 }, -- Darkwater Talwar -> Lady Sarevess

        [6906] = { 6243 }, -- Algae Fists -> Gelihast
        [6905] = { 6243 }, -- Reef Axe -> Gelihast

        [1155] = { 4832 }, -- Rod of the Sleepwalker -> Twilight Lord Kelris
        [6903] = { 4832 }, -- Gaze Dreamer Pants -> Twilight Lord Kelris

        [6901] = { 4830 }, -- Glowing Thresher Cape -> Old Serra'kis
        [6904] = { 4830 }, -- Bite of Serra'kis -> Old Serra'kis
        [6902] = { 4830 }, -- Bands of Serra'kis -> Old Serra'kis

        [6911] = { 4829 }, -- Moss Cinch -> Aku'mai
        [6910] = { 4829 }, -- Leech Pants -> Aku'mai
        [6909] = { 4829 }, -- Strike of the Hydra -> Aku'mai
    },
}
