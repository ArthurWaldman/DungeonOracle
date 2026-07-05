# DungeonOracle

DungeonOracle is a World of Warcraft Classic Era addon for collecting structured dungeon run data for later offline analysis.

The addon currently focuses on a tight local-only flow:
- detect when the player enters a supported dungeon
- resolve a Nova-style `zone_id` from in-instance GUIDs
- start or reactivate a run only after that `zone_id` is known
- persist one active run and archive completed runs
- show live run state in a compact in-dungeon tracker window

## Current Scope

This branch is intentionally narrow.

What it does now:
- tracks supported dungeon entry
- resolves `zone_id`
- starts a new run when a valid dungeon + `zone_id` context is established
- reactivates a stored run when `dungeon_name` and `zone_id` match
- ends a run when the player remains outside the dungeon for 30 seconds
- ends the current run and starts a new one when the player enters the same dungeon with a different `zone_id`
- stores completed runs in SavedVariables

What it does not do now:
- addon-to-addon sharing
- party analytics
- death analytics
- loot analytics
- boss timing
- upload automation

## Repository Layout

```text
DungeonOracle/
+- Core/
|  +- Database.lua
|  +- DatabaseReference.lua
|  +- Tracker.lua
|  +- TrackerReference.lua
|  +- UI.lua
+- DungeonData/
|  +- schema.md
|  +- dungeon definition files
+- DungeonOracle.lua
+- DungeonOracle.toc
+- README.md
+- .gitignore
```

## Core Modules

### `DungeonOracle.lua`

Addon bootstrap.

Responsibilities:
- create the shared addon namespace
- register the slash command
- initialize UI and tracker on login
- forward runtime events to the tracker

### `Core/Tracker.lua`

Runtime dungeon tracking.

Current responsibilities:
- identify supported dungeon contexts
- resolve `zone_id` from valid GUID sources
- create new runs
- reactivate matching stored runs
- detect same-dungeon new-instance transitions
- manage the outside-instance timeout
- send lifecycle updates to the dungeon UI log

### `Core/Database.lua`

SavedVariables storage for the live branch.

Current responsibilities:
- initialize the database
- store settings
- persist one `active_run`
- archive completed runs into `records`
- reactivate a stored run by `dungeon_name` and `zone_id`

### `Core/UI.lua`

Presentation layer only.

Current UI pieces:
- minimap launcher button
- main addon window
- settings tab
- upload instructions tab
- in-dungeon tracker window

## Current SavedVariables Shape

```lua
DungeonOracleDB = {
    settings = {
        show_minimap_button = true,
        show_tracker_window = true,
    },
    active_run = {
        dungeon_name = "The Stockade",
        run_id = "17832434-8261-4444-9894-c5a70c25cc54",
        zone_id = 13936,
        started_at = 1783243482,
        outside_instance_started_at = 1783243487,
        hardcore = false,
        party = {
            {
                name = "Player-Realm",
                class = "WARRIOR",
                level = 60.5,
                role = "TANK",
            },
            {
                name = "Mage-Realm",
                class = "MAGE",
                level = 60,
                role = "DAMAGER",
            },
        },
        replacements = 0,
        deaths = {
            {
                class = "WARRIOR",
                level = 28,
            },
        },
    },
    records = {
        {
            dungeon_name = "The Stockade",
            run_id = "17832434-6632-4837-82c5-5da85f75b6a6",
            zone_id = 13912,
            started_at = 1783243466,
            outside_instance_started_at = 1783243471,
            ended_at = 1783243482,
            hardcore = false,
            party = {
                {
                    name = "Player-Realm",
                    class = "WARRIOR",
                    level = 60.5,
                    role = "TANK",
                },
                {
                    name = "Mage-Realm",
                    class = "MAGE",
                    level = 60,
                    role = "DAMAGER",
                },
            },
            replacements = 0,
            deaths = {
                {
                    class = "WARRIOR",
                    level = 28,
                },
            },
        },
    },
}
```

### Field Notes

- `settings`
  Persistent addon preferences.

- `active_run`
  The currently live dungeon run, if one exists.

- `records`
  Archived completed runs.

- `dungeon_name`
  The player-facing dungeon name.

- `run_id`
  A UUID-like identifier used to distinguish runs in local storage.

- `zone_id`
  A Nova-style in-instance identifier derived from valid dungeon GUIDs. This is the key signal used to distinguish one run from another within the same dungeon.

- `started_at`
  The Unix timestamp when the run began.

- `outside_instance_started_at`
  The Unix timestamp when the player left the dungeon while the run was still active.

- `ended_at`
  The Unix timestamp when the run was archived as complete.

- `hardcore`
  `true` when the run occurred on a realm listed in `RealmData/HardcoreRealms.lua`, otherwise `false`.

- `party`
  A run snapshot of each player’s name, class, level, and inferred role. When a tracked player levels during the run, the stored `level` is increased by `0.5`.

- `replacements`
  The number of valid replacement players detected after a run that started as a full five-player group. Replacement checks now compare player names against the original five-player snapshot.

- `deaths`
  A list of tracked party death snapshots. Each entry stores the dead player’s class and stored level value.

## Dungeon Data

The `DungeonData/` directory contains static metadata for supported dungeons.

Each dungeon file defines:
- the internal dungeon key
- the display name
- optional map matching data
- aliases when needed
- tracked bosses
- tracked loot per boss
- reverse loot lookup via `loot_to_bosses`

## Realm Data

The `RealmData/` directory contains small static realm metadata used by the
tracker.

Current usage:
- `HardcoreRealms.lua`
  A set of normalized realm names used to determine whether a run should be
  tagged with `hardcore = true`.

The shared schema for all dungeon definition files now lives in:

- [DungeonData/schema.md](C:/Users/Arthur/Software%20Dev/Personal%20Projects/DungeonOracle/DungeonData/schema.md)

That file is the single source of truth for dungeon file structure.

## Current Run Flow

The live branch currently follows this simplified local flow:

1. The player enters a supported dungeon.
2. The tracker waits until it can resolve a valid `zone_id`.
3. Once `zone_id` is known, the tracker decides whether to:
   - continue the current active run
   - reactivate a stored run whose `dungeon_name` and `zone_id` match
   - start a fresh run
4. If the player leaves the dungeon, a 30-second outside timer begins.
5. If the player returns before that timer expires, the run continues.
6. If the timer expires, the run is archived into `records`.
7. If the player enters the same dungeon with a different `zone_id`, the old run is completed and a new run begins.

## Tracker Window

The in-dungeon tracker window currently shows:
- reset timer
- run ID
- zone ID
- lifecycle log messages

This window is meant to support testing and make run-state transitions visible without printing to chat.

## Upload Model

DungeonOracle uses manual export.

Expected flow:
1. The addon records data locally in SavedVariables.
2. The player uploads the SavedVariables file manually.
3. Data processing happens outside the game.

SavedVariables path:

```text
World of Warcraft\_classic_era_\WTF\Account\<YOUR_ACCOUNT>\SavedVariables
```

Relevant file:

```text
DungeonOracle.lua
```

## Reference Files

The reference files are preserved for historical context only:
- `Core/TrackerReference.lua`
- `Core/DatabaseReference.lua`

They are not part of the live tracking flow and should be treated as read-only reference material.

## Development Notes

Important current repo rules:
- keep the live tracker logic simple and explicit
- do not add unrequested functionality
- treat the reference files as read-only
- use `DungeonData/schema.md` as the shared schema reference for dungeon files

## Installation

Install the addon like a normal WoW Classic Era addon inside:

```text
World of Warcraft\_classic_era_\Interface\AddOns\DungeonOracle
```

## Status

The current branch is stable around:
- local run tracking
- `zone_id`-based continuation and reactivation
- 30-second outside-instance completion
- compact dungeon UI visibility

Future analytics fields can be layered back in from here once they are reintroduced deliberately.
