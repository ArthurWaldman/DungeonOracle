-- DireMaulEast.lua defines the static dungeon metadata used by the addon.

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
DungeonOracleData.dungeons.dire_maul_east = {
    id = "dire_maul_east",
    name = "Dire Maul - East",
    aliases = {
        "Dire Maul East",
    },
    bosses = {
        -- Dire Maul East tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 14354,
            name = "Pusillin",
            recorded_loot = {
                [18267] = true, -- Recipe: Runn Tum Tuber Surprise
            },
        },
        {
            id = 11490,
            name = "Zevrim Thornhoof",
            recorded_loot = {
                [18319] = true, -- Fervent Helm
                [18313] = true, -- Helm of Awareness
                [18323] = true, -- Satyr's Bow
                [18308] = true, -- Clever Hat
                [18306] = true, -- Gloves of Shadowy Mist
            },
        },
        {
            id = 13280,
            name = "Hydrospawn",
            recorded_loot = {
                [18317] = true, -- Tempest Talisman
                [18322] = true, -- Waterspout Boots
                [18324] = true, -- Waveslicer
                [19268] = true, -- Ace of Warlords
                [18305] = true, -- Breakwater Legguards
                [18307] = true, -- Riptide Shoes
            },
        },
        {
            id = 14327,
            name = "Lethtendris",
            recorded_loot = {
                [18325] = true, -- Felhide Cap
                [18311] = true, -- Quel'dorai Channeling Rod
                [18301] = true, -- Lethtendris's Wand
                [18302] = true, -- Band of Vigor
            },
        },
        {
            id = 11492,
            name = "Alzzin the Wildshaper",
            recorded_loot = {
                [18328] = true, -- Shadewood Cloak
                [18312] = true, -- Energized Chestplate
                [18309] = true, -- Gloves of Restoration
                [18326] = true, -- Razor Gauntlets
                [18327] = true, -- Whipvine Cord
                [18318] = true, -- Merciful Greaves
                [18321] = true, -- Energetic Rod
                [18310] = true, -- Fiendish Machete
                [18314] = true, -- Ring of Demonic Guile
                [18315] = true, -- Ring of Demonic Potency
            },
        },
    },
}
