-- TheStockade.lua defines the static dungeon metadata used by the addon.

DungeonOracleData = DungeonOracleData or {}
DungeonOracleData.dungeons = DungeonOracleData.dungeons or {}

DungeonOracleData.dungeons.the_stockade = {
    id = "the_stockade",
    name = "The Stockade",
    aliases = {
        "Stormwind Stockade",
        "The Stockades",
    },
    bosses = {
        -- The Stockade tracked boss list for WoW Classic Era / Hardcore.
        {
            id = 1666,
            name = "Kam Deepfury",
            recorded_loot = {
                [2280] = true, -- Kam's Walking Stick
            },
        },
        {
            id = 1720,
            name = "Bruegal Ironknuckle",
            recorded_loot = {
                [3228] = true, -- Jimmied Handcuffs
                [2941] = true, -- Prison Shank
                [2942] = true, -- Iron Knuckles
            },
        },
    },
    loot_to_bosses = {
        [2280] = { 1666 }, -- Kam's Walking Stick -> Kam Deepfury

        [3228] = { 1720 }, -- Jimmied Handcuffs -> Bruegal Ironknuckle
        [2941] = { 1720 }, -- Prison Shank -> Bruegal Ironknuckle
        [2942] = { 1720 }, -- Iron Knuckles -> Bruegal Ironknuckle
    },
}
