-- WailingCaverns.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

DungeonOracleData.dungeons.wailing_caverns = {
    id = "wailing_caverns",
    name = "Wailing Caverns",
    bosses = {
        -- Wailing Caverns tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 3669,
            name = "Lord Cobrahn",
            recorded_loot = {
                [6460] = true, -- Cobrahn's Grasp
                [10410] = true, -- Leggings of the Fang
                [6465] = true, -- Robe of the Moccasin
            },
        },
        {
            id = 3671,
            name = "Lady Anacondra",
            recorded_loot = {
                [10412] = true, -- Belt of the Fang
            },
        },
        {
            id = 3653,
            name = "Kresh",
            recorded_loot = {
                [13245] = true, -- Kresh's Back
            },
        },
        {
            id = 3670,
            name = "Lord Pythas",
            recorded_loot = {
                [6472] = true, -- Stinging Viper
                [6473] = true, -- Armor of the Fang
            },
        },
        {
            id = 3674,
            name = "Skum",
            recorded_loot = {
                [6449] = true, -- Glowing Lizardscale Cloak
                [6448] = true, -- Tail Spike
            },
        },
        {
            id = 3673,
            name = "Lord Serpentis",
            recorded_loot = {
                [6469] = true, -- Venomstrike
                [5970] = true, -- Serpent Gloves
                [10411] = true, -- Footpads of the Fang
                [6459] = true, -- Savage Trodders
            },
        },
        {
            id = 5775,
            name = "Verdan the Everliving",
            recorded_loot = {
                [6630] = true, -- Seedcloud Buckler
                [6631] = true, -- Living Root
                [6629] = true, -- Sporid Cape
            },
        },
        {
            id = 3654,
            name = "Mutanus the Devourer",
            recorded_loot = {
                [6461] = true, -- Slime-encrusted Pads
                [6627] = true, -- Mutant Scale Breastplate
                [6463] = true, -- Deep Fathom Ring
            },
        },
        {
            id = 5912,
            name = "Deviate Faerie Dragon",
            recorded_loot = {
                [5243] = true, -- Firebelcher
                [6632] = true, -- Feyscale Cloak
            },
        },
    },
    loot_to_bosses = {
        [6460] = { 3669 }, -- Cobrahn's Grasp -> Lord Cobrahn
        [10410] = { 3669 }, -- Leggings of the Fang -> Lord Cobrahn
        [6465] = { 3669 }, -- Robe of the Moccasin -> Lord Cobrahn

        [10412] = { 3671 }, -- Belt of the Fang -> Lady Anacondra

        [13245] = { 3653 }, -- Kresh's Back -> Kresh

        [6472] = { 3670 }, -- Stinging Viper -> Lord Pythas
        [6473] = { 3670 }, -- Armor of the Fang -> Lord Pythas

        [6449] = { 3674 }, -- Glowing Lizardscale Cloak -> Skum
        [6448] = { 3674 }, -- Tail Spike -> Skum

        [6469] = { 3673 }, -- Venomstrike -> Lord Serpentis
        [5970] = { 3673 }, -- Serpent Gloves -> Lord Serpentis
        [10411] = { 3673 }, -- Footpads of the Fang -> Lord Serpentis
        [6459] = { 3673 }, -- Savage Trodders -> Lord Serpentis

        [6630] = { 5775 }, -- Seedcloud Buckler -> Verdan the Everliving
        [6631] = { 5775 }, -- Living Root -> Verdan the Everliving
        [6629] = { 5775 }, -- Sporid Cape -> Verdan the Everliving

        [6461] = { 3654 }, -- Slime-encrusted Pads -> Mutanus the Devourer
        [6627] = { 3654 }, -- Mutant Scale Breastplate -> Mutanus the Devourer
        [6463] = { 3654 }, -- Deep Fathom Ring -> Mutanus the Devourer

        [5243] = { 5912 }, -- Firebelcher -> Deviate Faerie Dragon
        [6632] = { 5912 }, -- Feyscale Cloak -> Deviate Faerie Dragon
    },
}
