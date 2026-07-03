-- Deadmines.lua defines the static dungeon metadata used by the addon.

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
-- - bosses must include every boss required for a run to be considered valid.
-- - boss.id is the NPC ID used for encounter matching.
-- - recorded_loot is a set of item IDs we explicitly care about for this boss.
-- - using a set keeps loot validation fast and makes it obvious that we do not
--   intend to track every possible drop from every encounter.
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
}
