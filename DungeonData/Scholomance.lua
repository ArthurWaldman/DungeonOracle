-- Scholomance.lua defines the static dungeon metadata used by the addon.

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
DungeonOracleData.dungeons.scholomance = {
    id = "scholomance",
    name = "Scholomance",
    map_id = 2057,
    bosses = {
        -- Scholomance tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 10506,
            name = "Kirtonos the Herald",
            recorded_loot = {
                [16734] = true, -- Boots of Valor
                [13960] = true, -- Heart of the Fiend
                [13955] = true, -- Stoneform Shoulders
                [13969] = true, -- Loomguard Armbraces
                [13957] = true, -- Gargoyle Slashers
                [13956] = true, -- Clutch of Andros
                [13967] = true, -- Windreaver Greaves
                [14024] = true, -- Frightalon
                [13983] = true, -- Gravestone War Axe
            },
        },
        {
            id = 10503,
            name = "Jandice Barov",
            recorded_loot = {
                [16701] = true, -- Dreadmist Mantle
                [14548] = true, -- Royal Cap Spaulders
                [18689] = true, -- Phantasmal Cloak
                [14543] = true, -- Darkshade Gloves
                [14545] = true, -- Ghostloom Leggings
                [18690] = true, -- Wraithplate Leggings
                [14541] = true, -- Barovian Family Sword
                [22394] = true, -- Staff of Metanoia
            },
        },
        {
            id = 11622,
            name = "Rattlegore",
            recorded_loot = {
                [16711] = true, -- Shadowcraft Boots
                [14539] = true, -- Bone Ring Helm
                [14538] = true, -- Deadwalker Mantle
                [18686] = true, -- Bone Golem Shoulders
                [14537] = true, -- Corpselight Greaves
                [14528] = true, -- Rattlecage Buckler
                [14531] = true, -- Frightskull Shaft
                [18782] = true, -- Top Half of Advanced Armorsmithing: Volume II
            },
        },
        {
            id = 14516,
            name = "Death Knight Darkreaver",
            recorded_loot = {
                [18760] = true, -- Necromantic Band
                [18761] = true, -- Oblivion's Touch
                [18758] = true, -- Specter's Blade
                [18759] = true, -- Malicious Axe
            },
        },
        {
            id = 10433,
            name = "Marduk Blackpool",
            recorded_loot = {
                [18692] = true, -- Death Knight Sabatons
                [14576] = true, -- Ebon Hilt of Marduk
            },
        },
        {
            id = 10432,
            name = "Vectus",
            recorded_loot = {
                [18691] = true, -- Dark Advisor's Pendant
                [14577] = true, -- Skullsmoke Pants
            },
        },
        {
            id = 10508,
            name = "Ras Frostwhisper",
            recorded_loot = {
                [13314] = true, -- Alanna's Embrace
                [16689] = true, -- Magister's Mantle
                [14503] = true, -- Death's Clutch
                [14340] = true, -- Freezing Lich Robes
                [18693] = true, -- Shivery Handwraps
                [14525] = true, -- Boneclenched Gauntlets
                [14502] = true, -- Frostbite Girdle
                [14522] = true, -- Maelstrom Leggings
                [18694] = true, -- Shadowy Mail Greaves
                [18695] = true, -- Spellbound Tome
                [18696] = true, -- Intricately Runed Shield
                [13952] = true, -- Iceblade Hacker
                [14487] = true, -- Bonechill Hammer
                [13521] = true, -- Recipe: Flask of Supreme Power
            },
        },
        {
            id = 10505,
            name = "Instructor Malicia",
            recorded_loot = {
                [16710] = true, -- Shadowcraft Bracers
                [18681] = true, -- Burial Shawl
                [14633] = true, -- Necropile Mantle
                [14626] = true, -- Necropile Robe
                [14637] = true, -- Cadaverous Armor
                [14611] = true, -- Bloodmail Hauberk
                [14624] = true, -- Deathbone Chestplate
                [14629] = true, -- Necropile Cuffs
                [14640] = true, -- Cadaverous Gloves
                [14615] = true, -- Bloodmail Gauntlets
                [14622] = true, -- Deathbone Gauntlets
                [14636] = true, -- Cadaverous Belt
                [14614] = true, -- Bloodmail Belt
                [14620] = true, -- Deathbone Girdle
                [14632] = true, -- Necropile Leggings
                [14638] = true, -- Cadaverous Leggings
                [18682] = true, -- Ghoul Skin Leggings
                [14612] = true, -- Bloodmail Legguards
                [14623] = true, -- Deathbone Legguards
                [14631] = true, -- Necropile Boots
                [14641] = true, -- Cadaverous Walkers
                [14616] = true, -- Bloodmail Boots
                [14621] = true, -- Deathbone Sabatons
                [18684] = true, -- Dimly Opalescent Ring
                [23201] = true, -- Libram of Divinity
                [23200] = true, -- Totem of Sustaining
                [18680] = true, -- Ancient Bone Bow
                [18683] = true, -- Hammer of the Vesper
            },
        },
        {
            id = 11261,
            name = "Doctor Theolen Krastinov",
            recorded_loot = {
                [16684] = true, -- Magister's Gloves
                [18681] = true, -- Burial Shawl
                [14633] = true, -- Necropile Mantle
                [14626] = true, -- Necropile Robe
                [14637] = true, -- Cadaverous Armor
                [14611] = true, -- Bloodmail Hauberk
                [14624] = true, -- Deathbone Chestplate
                [14629] = true, -- Necropile Cuffs
                [14640] = true, -- Cadaverous Gloves
                [14615] = true, -- Bloodmail Gauntlets
                [14622] = true, -- Deathbone Gauntlets
                [14636] = true, -- Cadaverous Belt
                [14614] = true, -- Bloodmail Belt
                [14620] = true, -- Deathbone Girdle
                [14632] = true, -- Necropile Leggings
                [14638] = true, -- Cadaverous Leggings
                [18682] = true, -- Ghoul Skin Leggings
                [14612] = true, -- Bloodmail Legguards
                [14623] = true, -- Deathbone Legguards
                [14631] = true, -- Necropile Boots
                [14641] = true, -- Cadaverous Walkers
                [14616] = true, -- Bloodmail Boots
                [14621] = true, -- Deathbone Sabatons
                [18684] = true, -- Dimly Opalescent Ring
                [23201] = true, -- Libram of Divinity
                [23200] = true, -- Totem of Sustaining
                [18680] = true, -- Ancient Bone Bow
                [18683] = true, -- Hammer of the Vesper
            },
        },
        {
            id = 10901,
            name = "Lorekeeper Polkelt",
            recorded_loot = {
                [16705] = true, -- Dreadmist Wraps
                [18681] = true, -- Burial Shawl
                [14633] = true, -- Necropile Mantle
                [14626] = true, -- Necropile Robe
                [14637] = true, -- Cadaverous Armor
                [14611] = true, -- Bloodmail Hauberk
                [14624] = true, -- Deathbone Chestplate
                [14629] = true, -- Necropile Cuffs
                [14640] = true, -- Cadaverous Gloves
                [14615] = true, -- Bloodmail Gauntlets
                [14622] = true, -- Deathbone Gauntlets
                [14636] = true, -- Cadaverous Belt
                [14614] = true, -- Bloodmail Belt
                [14620] = true, -- Deathbone Girdle
                [14632] = true, -- Necropile Leggings
                [14638] = true, -- Cadaverous Leggings
                [18682] = true, -- Ghoul Skin Leggings
                [14612] = true, -- Bloodmail Legguards
                [14623] = true, -- Deathbone Legguards
                [14631] = true, -- Necropile Boots
                [14641] = true, -- Cadaverous Walkers
                [14616] = true, -- Bloodmail Boots
                [14621] = true, -- Deathbone Sabatons
                [18684] = true, -- Dimly Opalescent Ring
                [23201] = true, -- Libram of Divinity
                [23200] = true, -- Totem of Sustaining
                [18680] = true, -- Ancient Bone Bow
                [18683] = true, -- Hammer of the Vesper
            },
        },
        {
            id = 10507,
            name = "The Ravenian",
            recorded_loot = {
                [16716] = true, -- Wildheart Belt
                [18681] = true, -- Burial Shawl
                [14633] = true, -- Necropile Mantle
                [14626] = true, -- Necropile Robe
                [14637] = true, -- Cadaverous Armor
                [14611] = true, -- Bloodmail Hauberk
                [14624] = true, -- Deathbone Chestplate
                [14629] = true, -- Necropile Cuffs
                [14640] = true, -- Cadaverous Gloves
                [14615] = true, -- Bloodmail Gauntlets
                [14622] = true, -- Deathbone Gauntlets
                [14636] = true, -- Cadaverous Belt
                [14614] = true, -- Bloodmail Belt
                [14620] = true, -- Deathbone Girdle
                [14632] = true, -- Necropile Leggings
                [14638] = true, -- Cadaverous Leggings
                [18682] = true, -- Ghoul Skin Leggings
                [14612] = true, -- Bloodmail Legguards
                [14623] = true, -- Deathbone Legguards
                [14631] = true, -- Necropile Boots
                [14641] = true, -- Cadaverous Walkers
                [14616] = true, -- Bloodmail Boots
                [14621] = true, -- Deathbone Sabatons
                [18684] = true, -- Dimly Opalescent Ring
                [23201] = true, -- Libram of Divinity
                [23200] = true, -- Totem of Sustaining
                [18680] = true, -- Ancient Bone Bow
                [18683] = true, -- Hammer of the Vesper
            },
        },
        {
            id = 10504,
            name = "Lord Alexei Barov",
            recorded_loot = {
                [16722] = true, -- Lightforge Bracers
                [18681] = true, -- Burial Shawl
                [14633] = true, -- Necropile Mantle
                [14626] = true, -- Necropile Robe
                [14637] = true, -- Cadaverous Armor
                [14611] = true, -- Bloodmail Hauberk
                [14624] = true, -- Deathbone Chestplate
                [14629] = true, -- Necropile Cuffs
                [14640] = true, -- Cadaverous Gloves
                [14615] = true, -- Bloodmail Gauntlets
                [14622] = true, -- Deathbone Gauntlets
                [14636] = true, -- Cadaverous Belt
                [14614] = true, -- Bloodmail Belt
                [14620] = true, -- Deathbone Girdle
                [14632] = true, -- Necropile Leggings
                [14638] = true, -- Cadaverous Leggings
                [18682] = true, -- Ghoul Skin Leggings
                [14612] = true, -- Bloodmail Legguards
                [14623] = true, -- Deathbone Legguards
                [14631] = true, -- Necropile Boots
                [14641] = true, -- Cadaverous Walkers
                [14616] = true, -- Bloodmail Boots
                [14621] = true, -- Deathbone Sabatons
                [18684] = true, -- Dimly Opalescent Ring
                [23201] = true, -- Libram of Divinity
                [23200] = true, -- Totem of Sustaining
                [18680] = true, -- Ancient Bone Bow
                [18683] = true, -- Hammer of the Vesper
            },
        },
        {
            id = 10502,
            name = "Lady Illucia Barov",
            recorded_loot = {
                [18681] = true, -- Burial Shawl
                [14633] = true, -- Necropile Mantle
                [14626] = true, -- Necropile Robe
                [14637] = true, -- Cadaverous Armor
                [14611] = true, -- Bloodmail Hauberk
                [14624] = true, -- Deathbone Chestplate
                [14629] = true, -- Necropile Cuffs
                [14640] = true, -- Cadaverous Gloves
                [14615] = true, -- Bloodmail Gauntlets
                [14622] = true, -- Deathbone Gauntlets
                [14636] = true, -- Cadaverous Belt
                [14614] = true, -- Bloodmail Belt
                [14620] = true, -- Deathbone Girdle
                [14632] = true, -- Necropile Leggings
                [14638] = true, -- Cadaverous Leggings
                [18682] = true, -- Ghoul Skin Leggings
                [14612] = true, -- Bloodmail Legguards
                [14623] = true, -- Deathbone Legguards
                [14631] = true, -- Necropile Boots
                [14641] = true, -- Cadaverous Walkers
                [14616] = true, -- Bloodmail Boots
                [14621] = true, -- Deathbone Sabatons
                [18684] = true, -- Dimly Opalescent Ring
                [23201] = true, -- Libram of Divinity
                [23200] = true, -- Totem of Sustaining
                [18680] = true, -- Ancient Bone Bow
                [18683] = true, -- Hammer of the Vesper
            },
        },
        {
            id = 1853,
            name = "Darkmaster Gandling",
            recorded_loot = {
                [13937] = true, -- Headmaster's Charge
                [14514] = true, -- Pattern: Robe of the Void
                [16693] = true, -- Devout Crown
                [16686] = true, -- Magister's Crown
                [16698] = true, -- Dreadmist Mask
                [16707] = true, -- Shadowcraft Cap
                [16720] = true, -- Wildheart Cowl
                [16677] = true, -- Beaststalker's Cap
                [16667] = true, -- Coif of Elements
                [16727] = true, -- Lightforge Helm
                [16731] = true, -- Helm of Valor
                [13944] = true, -- Tombstone Breastplate
                [13951] = true, -- Vigorsteel Vambraces
                [13950] = true, -- Detention Strap
                [13398] = true, -- Boots of the Shrieker
                [22433] = true, -- Don Mauricio's Band of Domination
                [13938] = true, -- Bonecreeper Stylus
                [13953] = true, -- Silent Fang
                [13964] = true, -- Witchblade
                [19276] = true, -- Ace of Portals
                [13501] = true, -- Recipe: Major Mana Potion
            },
        },
    },
}
