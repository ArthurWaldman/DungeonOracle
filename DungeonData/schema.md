# Dungeon Data Schema

Each file in `DungeonData/` defines one dungeon table under `DungeonOracleData.dungeons`.

## Schema

```lua
{
    id = "internal-key",
    name = "Dungeon Name",
    map_id = 1234, -- optional
    aliases = { -- optional
        "Alternate Dungeon Name",
    },
    bosses = {
        {
            id = 123,
            name = "Boss Name",
            recorded_loot = {
                [456] = true,
            },
        },
    },
    loot_to_bosses = {
        [456] = { 123 },
    },
}
```

## Notes

- `id` is the addon's internal dungeon identifier.
- `name` should match the player-facing dungeon name we want in exports.
- `map_id` is used when a dungeon needs an explicit map match.
- `aliases` lists alternate in-game names that should resolve to this same file.
- `bosses` must include every boss we want to track for this dungeon.
- `boss.id` is the NPC ID used for encounter and loot correlation.
- `recorded_loot` is a set of tracked item IDs for that boss.
- `loot_to_bosses` is the reverse lookup from tracked item ID to one or more boss IDs.
