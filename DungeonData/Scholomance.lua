-- Scholomance.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

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
    loot_to_bosses = {
        [16734] = { 10506 }, -- Boots of Valor -> Kirtonos the Herald
        [13960] = { 10506 }, -- Heart of the Fiend -> Kirtonos the Herald
        [13955] = { 10506 }, -- Stoneform Shoulders -> Kirtonos the Herald
        [13969] = { 10506 }, -- Loomguard Armbraces -> Kirtonos the Herald
        [13957] = { 10506 }, -- Gargoyle Slashers -> Kirtonos the Herald
        [13956] = { 10506 }, -- Clutch of Andros -> Kirtonos the Herald
        [13967] = { 10506 }, -- Windreaver Greaves -> Kirtonos the Herald
        [14024] = { 10506 }, -- Frightalon -> Kirtonos the Herald
        [13983] = { 10506 }, -- Gravestone War Axe -> Kirtonos the Herald

        [16701] = { 10503 }, -- Dreadmist Mantle -> Jandice Barov
        [14548] = { 10503 }, -- Royal Cap Spaulders -> Jandice Barov
        [18689] = { 10503 }, -- Phantasmal Cloak -> Jandice Barov
        [14543] = { 10503 }, -- Darkshade Gloves -> Jandice Barov
        [14545] = { 10503 }, -- Ghostloom Leggings -> Jandice Barov
        [18690] = { 10503 }, -- Wraithplate Leggings -> Jandice Barov
        [14541] = { 10503 }, -- Barovian Family Sword -> Jandice Barov
        [22394] = { 10503 }, -- Staff of Metanoia -> Jandice Barov

        [16711] = { 11622 }, -- Shadowcraft Boots -> Rattlegore
        [14539] = { 11622 }, -- Bone Ring Helm -> Rattlegore
        [14538] = { 11622 }, -- Deadwalker Mantle -> Rattlegore
        [18686] = { 11622 }, -- Bone Golem Shoulders -> Rattlegore
        [14537] = { 11622 }, -- Corpselight Greaves -> Rattlegore
        [14528] = { 11622 }, -- Rattlecage Buckler -> Rattlegore
        [14531] = { 11622 }, -- Frightskull Shaft -> Rattlegore
        [18782] = { 11622 }, -- Top Half of Advanced Armorsmithing: Volume II -> Rattlegore

        [18760] = { 14516 }, -- Necromantic Band -> Death Knight Darkreaver
        [18761] = { 14516 }, -- Oblivion's Touch -> Death Knight Darkreaver
        [18758] = { 14516 }, -- Specter's Blade -> Death Knight Darkreaver
        [18759] = { 14516 }, -- Malicious Axe -> Death Knight Darkreaver

        [18692] = { 10433 }, -- Death Knight Sabatons -> Marduk Blackpool
        [14576] = { 10433 }, -- Ebon Hilt of Marduk -> Marduk Blackpool

        [18691] = { 10432 }, -- Dark Advisor's Pendant -> Vectus
        [14577] = { 10432 }, -- Skullsmoke Pants -> Vectus

        [13314] = { 10508 }, -- Alanna's Embrace -> Ras Frostwhisper
        [16689] = { 10508 }, -- Magister's Mantle -> Ras Frostwhisper
        [14503] = { 10508 }, -- Death's Clutch -> Ras Frostwhisper
        [14340] = { 10508 }, -- Freezing Lich Robes -> Ras Frostwhisper
        [18693] = { 10508 }, -- Shivery Handwraps -> Ras Frostwhisper
        [14525] = { 10508 }, -- Boneclenched Gauntlets -> Ras Frostwhisper
        [14502] = { 10508 }, -- Frostbite Girdle -> Ras Frostwhisper
        [14522] = { 10508 }, -- Maelstrom Leggings -> Ras Frostwhisper
        [18694] = { 10508 }, -- Shadowy Mail Greaves -> Ras Frostwhisper
        [18695] = { 10508 }, -- Spellbound Tome -> Ras Frostwhisper
        [18696] = { 10508 }, -- Intricately Runed Shield -> Ras Frostwhisper
        [13952] = { 10508 }, -- Iceblade Hacker -> Ras Frostwhisper
        [14487] = { 10508 }, -- Bonechill Hammer -> Ras Frostwhisper
        [13521] = { 10508 }, -- Recipe: Flask of Supreme Power -> Ras Frostwhisper

        [16710] = { 10505 }, -- Shadowcraft Bracers -> Instructor Malicia
        [16684] = { 11261 }, -- Magister's Gloves -> Doctor Theolen Krastinov
        [16705] = { 10901 }, -- Dreadmist Wraps -> Lorekeeper Polkelt
        [16716] = { 10507 }, -- Wildheart Belt -> The Ravenian
        [16722] = { 10504 }, -- Lightforge Bracers -> Lord Alexei Barov

        [18681] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Burial Shawl -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14633] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Necropile Mantle -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14626] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Necropile Robe -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14637] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Cadaverous Armor -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14611] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Bloodmail Hauberk -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14624] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Deathbone Chestplate -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14629] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Necropile Cuffs -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14640] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Cadaverous Gloves -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14615] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Bloodmail Gauntlets -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14622] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Deathbone Gauntlets -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14636] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Cadaverous Belt -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14614] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Bloodmail Belt -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14620] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Deathbone Girdle -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14632] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Necropile Leggings -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14638] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Cadaverous Leggings -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [18682] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Ghoul Skin Leggings -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14612] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Bloodmail Legguards -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14623] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Deathbone Legguards -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14631] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Necropile Boots -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14641] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Cadaverous Walkers -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14616] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Bloodmail Boots -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [14621] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Deathbone Sabatons -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [18684] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Dimly Opalescent Ring -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [23201] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Libram of Divinity -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [23200] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Totem of Sustaining -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [18680] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Ancient Bone Bow -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov
        [18683] = { 10505, 11261, 10901, 10507, 10504, 10502 }, -- Hammer of the Vesper -> Instructor Malicia, Doctor Theolen Krastinov, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov, Lady Illucia Barov

        [13937] = { 1853 }, -- Headmaster's Charge -> Darkmaster Gandling
        [14514] = { 1853 }, -- Pattern: Robe of the Void -> Darkmaster Gandling
        [16693] = { 1853 }, -- Devout Crown -> Darkmaster Gandling
        [16686] = { 1853 }, -- Magister's Crown -> Darkmaster Gandling
        [16698] = { 1853 }, -- Dreadmist Mask -> Darkmaster Gandling
        [16707] = { 1853 }, -- Shadowcraft Cap -> Darkmaster Gandling
        [16720] = { 1853 }, -- Wildheart Cowl -> Darkmaster Gandling
        [16677] = { 1853 }, -- Beaststalker's Cap -> Darkmaster Gandling
        [16667] = { 1853 }, -- Coif of Elements -> Darkmaster Gandling
        [16727] = { 1853 }, -- Lightforge Helm -> Darkmaster Gandling
        [16731] = { 1853 }, -- Helm of Valor -> Darkmaster Gandling
        [13944] = { 1853 }, -- Tombstone Breastplate -> Darkmaster Gandling
        [13951] = { 1853 }, -- Vigorsteel Vambraces -> Darkmaster Gandling
        [13950] = { 1853 }, -- Detention Strap -> Darkmaster Gandling
        [13398] = { 1853 }, -- Boots of the Shrieker -> Darkmaster Gandling
        [22433] = { 1853 }, -- Don Mauricio's Band of Domination -> Darkmaster Gandling
        [13938] = { 1853 }, -- Bonecreeper Stylus -> Darkmaster Gandling
        [13953] = { 1853 }, -- Silent Fang -> Darkmaster Gandling
        [13964] = { 1853 }, -- Witchblade -> Darkmaster Gandling
        [19276] = { 1853 }, -- Ace of Portals -> Darkmaster Gandling
        [13501] = { 1853 }, -- Recipe: Major Mana Potion -> Darkmaster Gandling
    },
}
