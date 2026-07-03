-- TheStockade.lua defines the static dungeon metadata used by the addon.

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
DungeonOracleData.dungeons.the_stockade = {
    id = "the_stockade",
    name = "The Stockade",
    aliases = {
        "Stormwind Stockade",
        "The Stockades",
    },
    bosses = {
        -- The Stockade tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 1666,
            name = "Kam Deepfury",
            recorded_loot = {
                [2280] = true, -- Kam's Walking Stick
            },
        },
        {
            id = 1720,
            name = "Bruegal Ironknuckle",
            recorded_loot = {
                [3228] = true, -- Jimmied Handcuffs
                [2941] = true, -- Prison Shank
                [2942] = true, -- Iron Knuckles
            },
        },
    },
}
