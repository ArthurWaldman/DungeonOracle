-- RazorfenKraul.lua defines the static dungeon metadata used by the addon.

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
}
