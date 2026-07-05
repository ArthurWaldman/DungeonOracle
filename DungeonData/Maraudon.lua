-- Maraudon.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

DungeonOracleData.dungeons.maraudon = {
    id = "maraudon",
    name = "Maraudon",
    map_id = 2100,
    bosses = {
        {
            id = 13282,
            name = "Noxxion",
            recorded_loot = {
                [17746] = true, -- Noxxion's Shackles
                [17744] = true, -- Heart of Noxxion
                [17745] = true, -- Noxious Shooter
            },
        },
        {
            id = 12258,
            name = "Razorlash",
            recorded_loot = {
                [17749] = true, -- Phytoskin Spaulders
                [17748] = true, -- Vinerot Sandals
                [17750] = true, -- Chloromesh Girdle
                [17751] = true, -- Brusslehide Leggings
            },
        },
        {
            id = 12236,
            name = "Lord Vyletongue",
            recorded_loot = {
                [17755] = true, -- Satyrmane Sash
                [17754] = true, -- Infernal Trickster Leggings
                [17752] = true, -- Satyr's Lash
            },
        },
        {
            id = 12237,
            name = "Meshlok the Harvester",
            recorded_loot = {
                [17767] = true, -- Bloomsprout Headpiece
                [17741] = true, -- Nature's Embrace
                [17742] = true, -- Fungus Shroud Armor
            },
        },
        {
            id = 12225,
            name = "Celebras the Cursed",
            recorded_loot = {
                [17740] = true, -- Soothsayer's Headdress
                [17739] = true, -- Grovekeeper's Drape
                [17738] = true, -- Claw of Celebras
            },
        },
        {
            id = 12203,
            name = "Landslide",
            recorded_loot = {
                [17734] = true, -- Helm of the Mountain
                [17736] = true, -- Rockgrip Gauntlets
                [17737] = true, -- Cloud Stone
                [17943] = true, -- Fist of Stone
            },
        },
        {
            id = 13601,
            name = "Tinkerer Gizlock",
            recorded_loot = {
                [17718] = true, -- Gizlock's Hypertech Buckler
                [17717] = true, -- Megashot Rifle
                [17719] = true, -- Inventor's Focal Sword
            },
        },
        {
            id = 13596,
            name = "Rotgrip",
            recorded_loot = {
                [17732] = true, -- Rotgrip Mantle
                [17728] = true, -- Albino Crocscale Boots
                [17730] = true, -- Gatorbite Axe
            },
        },
        {
            id = 12201,
            name = "Princess Theradras",
            recorded_loot = {
                [17780] = true, -- Blade of Eternal Darkness
                [17715] = true, -- Eye of Theradras
                [17707] = true, -- Gemshard Heart
                [17714] = true, -- Bracers of the Stone Princess
                [17711] = true, -- Elemental Rockridge Leggings
                [17713] = true, -- Blackstone Ring
                [17710] = true, -- Charstone Dirk
                [17766] = true, -- Princess Theradras' Scepter
            },
        },
    },
    loot_to_bosses = {
        [17746] = { 13282 }, -- Noxxion's Shackles -> Noxxion
        [17744] = { 13282 }, -- Heart of Noxxion -> Noxxion
        [17745] = { 13282 }, -- Noxious Shooter -> Noxxion

        [17749] = { 12258 }, -- Phytoskin Spaulders -> Razorlash
        [17748] = { 12258 }, -- Vinerot Sandals -> Razorlash
        [17750] = { 12258 }, -- Chloromesh Girdle -> Razorlash
        [17751] = { 12258 }, -- Brusslehide Leggings -> Razorlash

        [17755] = { 12236 }, -- Satyrmane Sash -> Lord Vyletongue
        [17754] = { 12236 }, -- Infernal Trickster Leggings -> Lord Vyletongue
        [17752] = { 12236 }, -- Satyr's Lash -> Lord Vyletongue

        [17767] = { 12237 }, -- Bloomsprout Headpiece -> Meshlok the Harvester
        [17741] = { 12237 }, -- Nature's Embrace -> Meshlok the Harvester
        [17742] = { 12237 }, -- Fungus Shroud Armor -> Meshlok the Harvester

        [17740] = { 12225 }, -- Soothsayer's Headdress -> Celebras the Cursed
        [17739] = { 12225 }, -- Grovekeeper's Drape -> Celebras the Cursed
        [17738] = { 12225 }, -- Claw of Celebras -> Celebras the Cursed

        [17734] = { 12203 }, -- Helm of the Mountain -> Landslide
        [17736] = { 12203 }, -- Rockgrip Gauntlets -> Landslide
        [17737] = { 12203 }, -- Cloud Stone -> Landslide
        [17943] = { 12203 }, -- Fist of Stone -> Landslide

        [17718] = { 13601 }, -- Gizlock's Hypertech Buckler -> Tinkerer Gizlock
        [17717] = { 13601 }, -- Megashot Rifle -> Tinkerer Gizlock
        [17719] = { 13601 }, -- Inventor's Focal Sword -> Tinkerer Gizlock

        [17732] = { 13596 }, -- Rotgrip Mantle -> Rotgrip
        [17728] = { 13596 }, -- Albino Crocscale Boots -> Rotgrip
        [17730] = { 13596 }, -- Gatorbite Axe -> Rotgrip

        [17780] = { 12201 }, -- Blade of Eternal Darkness -> Princess Theradras
        [17715] = { 12201 }, -- Eye of Theradras -> Princess Theradras
        [17707] = { 12201 }, -- Gemshard Heart -> Princess Theradras
        [17714] = { 12201 }, -- Bracers of the Stone Princess -> Princess Theradras
        [17711] = { 12201 }, -- Elemental Rockridge Leggings -> Princess Theradras
        [17713] = { 12201 }, -- Blackstone Ring -> Princess Theradras
        [17710] = { 12201 }, -- Charstone Dirk -> Princess Theradras
        [17766] = { 12201 }, -- Princess Theradras' Scepter -> Princess Theradras
    },
}
