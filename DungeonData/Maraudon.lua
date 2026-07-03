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
}
