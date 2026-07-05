-- DireMaulEast.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

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
    loot_to_bosses = {
        [18267] = { 14354 }, -- Recipe: Runn Tum Tuber Surprise -> Pusillin

        [18319] = { 11490 }, -- Fervent Helm -> Zevrim Thornhoof
        [18313] = { 11490 }, -- Helm of Awareness -> Zevrim Thornhoof
        [18323] = { 11490 }, -- Satyr's Bow -> Zevrim Thornhoof
        [18308] = { 11490 }, -- Clever Hat -> Zevrim Thornhoof
        [18306] = { 11490 }, -- Gloves of Shadowy Mist -> Zevrim Thornhoof

        [18317] = { 13280 }, -- Tempest Talisman -> Hydrospawn
        [18322] = { 13280 }, -- Waterspout Boots -> Hydrospawn
        [18324] = { 13280 }, -- Waveslicer -> Hydrospawn
        [19268] = { 13280 }, -- Ace of Warlords -> Hydrospawn
        [18305] = { 13280 }, -- Breakwater Legguards -> Hydrospawn
        [18307] = { 13280 }, -- Riptide Shoes -> Hydrospawn

        [18325] = { 14327 }, -- Felhide Cap -> Lethtendris
        [18311] = { 14327 }, -- Quel'dorai Channeling Rod -> Lethtendris
        [18301] = { 14327 }, -- Lethtendris's Wand -> Lethtendris
        [18302] = { 14327 }, -- Band of Vigor -> Lethtendris

        [18328] = { 11492 }, -- Shadewood Cloak -> Alzzin the Wildshaper
        [18312] = { 11492 }, -- Energized Chestplate -> Alzzin the Wildshaper
        [18309] = { 11492 }, -- Gloves of Restoration -> Alzzin the Wildshaper
        [18326] = { 11492 }, -- Razor Gauntlets -> Alzzin the Wildshaper
        [18327] = { 11492 }, -- Whipvine Cord -> Alzzin the Wildshaper
        [18318] = { 11492 }, -- Merciful Greaves -> Alzzin the Wildshaper
        [18321] = { 11492 }, -- Energetic Rod -> Alzzin the Wildshaper
        [18310] = { 11492 }, -- Fiendish Machete -> Alzzin the Wildshaper
        [18314] = { 11492 }, -- Ring of Demonic Guile -> Alzzin the Wildshaper
        [18315] = { 11492 }, -- Ring of Demonic Potency -> Alzzin the Wildshaper
    },
}
