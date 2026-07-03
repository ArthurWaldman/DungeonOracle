-- RazorfenDowns.lua defines the static dungeon metadata used by the addon.

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
}
