-- Deadmines.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

DungeonOracleData.dungeons.deadmines = {
    id = "deadmines",
    name = "The Deadmines",
    map_id = 36,
    bosses = {
        -- The Deadmines boss list for WoW Classic Era / Hardcore.
        {
            id = 644,
            name = "Rhahk'Zor",
            recorded_loot = {
                [872] = true, -- Rockslicer
            },
        },
        {
            id = 3586,
            name = "Miner Johnson",
            recorded_loot = {
                [5443] = true, -- Gold-plated Buckler
                [5444] = true, -- Miner's Cape
            },
        },
        {
            id = 643,
            name = "Sneed",
            recorded_loot = {
                [5194] = true, -- Taskmaster Axe
                [5195] = true, -- Gold-flecked Gloves
            },
        },
        {
            id = 642,
            name = "Sneed's Shredder",
            recorded_loot = {
                [1937] = true, -- Buzz Saw
            },
        },
        {
            id = 1763,
            name = "Gilnid",
            recorded_loot = {
                [1156] = true, -- Lavishly Jeweled Ring
                [5199] = true, -- Smelting Pants
            },
        },
        {
            id = 646,
            name = "Mr. Smite",
            recorded_loot = {
                [7230] = true, -- Smite's Mighty Hammer
                [5192] = true, -- Thief's Blade
                [5196] = true, -- Smite's Reaver
            },
        },
        {
            id = 647,
            name = "Captain Greenskin",
            recorded_loot = {
                [5201] = true, -- Emberstone Staff
                [10403] = true, -- Blackened Defias Belt
                [5200] = true, -- Impaling Harpoon
            },
        },
        {
            id = 639,
            name = "Edwin VanCleef",
            recorded_loot = {
                [5193] = true, -- Cape of the Brotherhood
                [5202] = true, -- Corsair's Overshirt
                [10399] = true, -- Blackened Defias Armor
                [5191] = true, -- Cruel Barb
            },
        },
        {
            id = 645,
            name = "Cookie",
            recorded_loot = {
                [5198] = true, -- Cookie's Stirring Rod
                [5197] = true, -- Cookie's Tenderizer
            },
        },
    },
    loot_to_bosses = {
        [872] = { 644 }, -- Rockslicer -> Rhahk'Zor

        [5443] = { 3586 }, -- Gold-plated Buckler -> Miner Johnson
        [5444] = { 3586 }, -- Miner's Cape -> Miner Johnson

        [5194] = { 643 }, -- Taskmaster Axe -> Sneed
        [5195] = { 643 }, -- Gold-flecked Gloves -> Sneed

        [1937] = { 642 }, -- Buzz Saw -> Sneed's Shredder

        [1156] = { 1763 }, -- Lavishly Jeweled Ring -> Gilnid
        [5199] = { 1763 }, -- Smelting Pants -> Gilnid

        [7230] = { 646 }, -- Smite's Mighty Hammer -> Mr. Smite
        [5192] = { 646 }, -- Thief's Blade -> Mr. Smite
        [5196] = { 646 }, -- Smite's Reaver -> Mr. Smite

        [5201] = { 647 }, -- Emberstone Staff -> Captain Greenskin
        [10403] = { 647 }, -- Blackened Defias Belt -> Captain Greenskin
        [5200] = { 647 }, -- Impaling Harpoon -> Captain Greenskin

        [5193] = { 639 }, -- Cape of the Brotherhood -> Edwin VanCleef
        [5202] = { 639 }, -- Corsair's Overshirt -> Edwin VanCleef
        [10399] = { 639 }, -- Blackened Defias Armor -> Edwin VanCleef
        [5191] = { 639 }, -- Cruel Barb -> Edwin VanCleef

        [5198] = { 645 }, -- Cookie's Stirring Rod -> Cookie
        [5197] = { 645 }, -- Cookie's Tenderizer -> Cookie
    },
}
