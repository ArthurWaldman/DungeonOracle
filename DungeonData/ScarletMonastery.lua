-- ScarletMonastery.lua defines the shared Scarlet Monastery instance.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

DungeonOracleData.dungeons.scarlet_monastery = {
    id = "scarlet_monastery",
    name = "Scarlet Monastery",
    map_id = 796,
    aliases = {
        "Scarlet Monastery - Graveyard",
        "Scarlet Monastery - Library",
        "Scarlet Monastery - Armory",
        "Scarlet Monastery - Cathedral",
    },
    bosses = {
        -- Scarlet Monastery tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 3983,
            name = "Interrogator Vishas",
            recorded_loot = {
                [7682] = true, -- Torturing Poker
            },
        },
        {
            id = 6490,
            name = "Azshir the Sleepless",
            recorded_loot = {
                [7709] = true, -- Blighted Leggings
                [7708] = true, -- Necrotic Wand
                [7731] = true, -- Ghostshard Talisman
            },
        },
        {
            id = 6488,
            name = "Fallen Champion",
            recorded_loot = {
                [7691] = true, -- Embalmed Shroud
                [7690] = true, -- Ebon Vise
                [7689] = true, -- Morbid Dawn
            },
        },
        {
            id = 6489,
            name = "Ironspine",
            recorded_loot = {
                [7688] = true, -- Ironspine's Ribcage
                [7687] = true, -- Ironspine's Fist
                [7686] = true, -- Ironspine's Eye
            },
        },
        {
            id = 4543,
            name = "Bloodmage Thalnos",
            recorded_loot = {
                [7685] = true, -- Orb of the Forgotten Seer
                [7684] = true, -- Bloodmage Mantle
            },
        },
        {
            id = 3974,
            name = "Houndmaster Loksey",
            recorded_loot = {
                [7710] = true, -- Loksey's Training Stick
                [7756] = true, -- Dog Training Gloves
                [3456] = true, -- Dog Whistle
            },
        },
        {
            id = 6487,
            name = "Arcanist Doan",
            recorded_loot = {
                [7714] = true, -- Hypnotic Blade
                [7713] = true, -- Illusionary Rod
                [7712] = true, -- Mantle of Doan
                [7711] = true, -- Robe of Doan
            },
        },
        {
            id = 3975,
            name = "Herod",
            recorded_loot = {
                [7719] = true, -- Raging Berserker's Helm
                [7718] = true, -- Herod's Shoulder
                [10330] = true, -- Scarlet Leggings
                [7717] = true, -- Ravager
            },
        },
        {
            id = 4542,
            name = "High Inquisitor Fairbanks",
            recorded_loot = {
                [19507] = true, -- Inquisitor's Shawl
                [19508] = true, -- Branded Leather Bracers
                [19509] = true, -- Dusty Mail Boots
            },
        },
        {
            id = 3976,
            name = "Scarlet Commander Mograine",
            recorded_loot = {
                [7724] = true, -- Gauntlets of Divinity
                [10330] = true, -- Scarlet Leggings
                [7726] = true, -- Aegis of the Scarlet Commander
                [7723] = true, -- Mograine's Might
            },
        },
        {
            id = 3977,
            name = "High Inquisitor Whitemane",
            recorded_loot = {
                [7720] = true, -- Whitemane's Chapeau
                [7722] = true, -- Triune Amulet
                [7721] = true, -- Hand of Righteousness
            },
        },
    },
    loot_to_bosses = {
        [7682] = { 3983 }, -- Torturing Poker -> Interrogator Vishas

        [7709] = { 6490 }, -- Blighted Leggings -> Azshir the Sleepless
        [7708] = { 6490 }, -- Necrotic Wand -> Azshir the Sleepless
        [7731] = { 6490 }, -- Ghostshard Talisman -> Azshir the Sleepless

        [7691] = { 6488 }, -- Embalmed Shroud -> Fallen Champion
        [7690] = { 6488 }, -- Ebon Vise -> Fallen Champion
        [7689] = { 6488 }, -- Morbid Dawn -> Fallen Champion

        [7688] = { 6489 }, -- Ironspine's Ribcage -> Ironspine
        [7687] = { 6489 }, -- Ironspine's Fist -> Ironspine
        [7686] = { 6489 }, -- Ironspine's Eye -> Ironspine

        [7685] = { 4543 }, -- Orb of the Forgotten Seer -> Bloodmage Thalnos
        [7684] = { 4543 }, -- Bloodmage Mantle -> Bloodmage Thalnos

        [7710] = { 3974 }, -- Loksey's Training Stick -> Houndmaster Loksey
        [7756] = { 3974 }, -- Dog Training Gloves -> Houndmaster Loksey
        [3456] = { 3974 }, -- Dog Whistle -> Houndmaster Loksey

        [7714] = { 6487 }, -- Hypnotic Blade -> Arcanist Doan
        [7713] = { 6487 }, -- Illusionary Rod -> Arcanist Doan
        [7712] = { 6487 }, -- Mantle of Doan -> Arcanist Doan
        [7711] = { 6487 }, -- Robe of Doan -> Arcanist Doan

        [7719] = { 3975 }, -- Raging Berserker's Helm -> Herod
        [7718] = { 3975 }, -- Herod's Shoulder -> Herod
        [10330] = { 3975, 3976 }, -- Scarlet Leggings -> Herod, Scarlet Commander Mograine
        [7717] = { 3975 }, -- Ravager -> Herod

        [19507] = { 4542 }, -- Inquisitor's Shawl -> High Inquisitor Fairbanks
        [19508] = { 4542 }, -- Branded Leather Bracers -> High Inquisitor Fairbanks
        [19509] = { 4542 }, -- Dusty Mail Boots -> High Inquisitor Fairbanks

        [7724] = { 3976 }, -- Gauntlets of Divinity -> Scarlet Commander Mograine
        [7726] = { 3976 }, -- Aegis of the Scarlet Commander -> Scarlet Commander Mograine
        [7723] = { 3976 }, -- Mograine's Might -> Scarlet Commander Mograine

        [7720] = { 3977 }, -- Whitemane's Chapeau -> High Inquisitor Whitemane
        [7722] = { 3977 }, -- Triune Amulet -> High Inquisitor Whitemane
        [7721] = { 3977 }, -- Hand of Righteousness -> High Inquisitor Whitemane
    },
}
