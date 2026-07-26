# DungeonOracle

DungeonOracle is a World of Warcraft Classic Era addon for recording structured dungeon run data for later offline analysis.

It tracks runs locally in SavedVariables, shows live state in-game, and coordinates a shared `run_id` across addon users in the same party so separately collected logs can be merged later.

## Feature Overview

DungeonOracle currently supports:
- supported-dungeon detection
- Nova-style `zone_id` resolution from in-instance GUIDs
- run continuation, reactivation, and same-dungeon new-instance detection using `dungeon_name` + `zone_id`
- 30-second outside-instance completion
- shared `run_id` generation and distribution through a recorder-election pattern
- party snapshot capture at run start
- replacement detection for full five-player runs
- Hardcore realm tagging
- party death tracking
- first-death tracking
- boss kill timers
- boss loot mapping
- non-boss loot rarity counters
- live money tracking
- live XP gain tracking
- minimap launcher button with drag support
- compact in-dungeon tracker window
- main addon window with `My Data`, `Upload Instructions`, and `Settings` tabs
- hover tooltips for active and completed runs
- manual SavedVariables upload flow

## Current Run Lifecycle

DungeonOracle follows this runtime flow:

1. The player enters a supported dungeon.
2. The tracker waits until it resolves a valid `zone_id` from a dungeon NPC GUID.
3. Once `zone_id` is known, the tracker decides whether to:
   - continue the current active run
   - reactivate a stored run whose `dungeon_name` and `zone_id` match
   - complete the old run and start a new one if the same dungeon now has a different `zone_id`
   - start a fresh run if no matching run exists
4. If multiple party members have the addon, they briefly elect a recorder.
5. The recorder generates a shared `run_id` from:
   - normalized dungeon name
   - `zone_id`
   - recorder date in `yyyy/mm/dd`
6. The recorder broadcasts that `run_id` so other addon users in the party can adopt it.
7. If the player leaves the dungeon alive, a 30-second outside-instance timer begins.
8. If the player returns before the timer expires, the run continues.
9. If the timer expires, the run is archived into `records`.

## Tracked Run Data

Each run can record:
- `dungeon_name`
- `run_id`
- `zone_id`
- `started_at`
- `outside_instance_started_at`
- `ended_at`
- `hardcore`
- `party`
- `replacements`
- `deaths`
- `first_death`
- `boss_timer`
- `boss_loot`
- `starting_money`
- `gold_earned`
- `starting_xp`
- `xp_gained`
- `green_drops`
- `blue_drops`
- `purple_drops`
- `pending_boss_loot_queue` on the active run only

### Field Notes

- `run_id`
  A shared hash-based identifier used to align runs collected by multiple addon users.

- `zone_id`
  A Nova-style in-instance identifier derived from valid dungeon GUIDs. This is the primary same-dungeon continuity signal.

- `party`
  A snapshot of party members at run start. Each member stores `name`, `class`, `level`, and inferred `role`.

- `role`
  Inferred from class constraints plus a few special signals. For example, priests in Shadowform are treated as damage dealers, and paladins using Righteous Fury are treated as likely tanks.

- `replacements`
  Counts valid replacements after a run that began with a full five-player party. The tracker compares current names against the original five-player snapshot.

- `deaths`
  Stores party death snapshots with `class` and `level`.

- `first_death`
  Stores only the first tracked party death and includes:
  - `timestamp`: seconds since run start
  - `num_bosses_beaten`: size of `boss_timer` at the moment of death
  - `class`: class of the dead player

- `boss_timer`
  Stores boss kill durations as `{ boss_id, duration }`. If a player releases spirit during an active boss timer before seeing the boss die, that timer is stored as `-1`.

- `boss_loot`
  Maps `boss_id -> loot_id`. If a boss remains unresolved when the run ends, its value becomes `-1`.

- `pending_boss_loot_queue`
  Active-run-only queue of bosses still waiting for tracked loot resolution.

- `starting_money` and `gold_earned`
  Track money in copper. `gold_earned` is net change and can be negative.

- `starting_xp` and `xp_gained`
  Track player XP progress during the run. `starting_xp` is only stored on the active run.

- `green_drops`, `blue_drops`, `purple_drops`
  Count non-boss loot drops by rarity. These should reflect loot that is rolled off, not boss loot resolution.

## UI

### Minimap Button

The addon provides a minimap launcher button that:
- opens and closes the main addon window
- can be dragged around the minimap
- remembers its angle between sessions

### Slash Commands

The following slash commands open the main window:
- `/dungeonoracle`
- `/do`

### Main Window

The main window contains three tabs:

- `My Data`
  Shows the active run, then completed runs from newest to oldest. Rows display:
  - `Run ID`
  - `Zone ID`
  - `Dungeon Name`

- `Upload Instructions`
  Explains the manual export flow and provides the upload URL plus the SavedVariables path.

- `Settings`
  Lets the player toggle:
  - minimap button visibility
  - tracker window visibility

### My Data Hover Tooltip

Hovering an active or completed run row shows a details tooltip with:
- dungeon name
- run ID
- zone ID
- started time
- ended time or active state
- runtime
- party composition
- number of deaths
- first death class
- bosses beaten
- money earned
- XP gained
- boss loot lines in `boss name - loot name` form
- other loot counts by rarity

### In-Dungeon Tracker Window

The tracker window is draggable and currently shows:
- runtime
- outside-instance reset timer
- recorder name
- run ID
- zone ID
- boss timer
- most recent boss result
- loot rarity counters
- money earned
- XP gained

The lifecycle log system still exists internally for testing, but the visible tracker window is currently kept compact rather than log-heavy.

## Sharing Model

DungeonOracle does not yet attempt full run-data synchronization across players. Its current multiplayer coordination is intentionally narrow:

- addon users announce themselves to the party
- addon users elect a recorder alphabetically by full player name
- the recorder generates and broadcasts the shared `run_id`
- other addon users adopt that `run_id`

This means:
- `run_id` can match across multiple players for later offline merging
- most analytics are still tracked locally by each client

## Boss and Loot Tracking

Boss tracking works like this:
- bosses are detected by NPC ID against the active dungeon definition
- boss engage time is recorded when a tracked boss enters combat
- boss kill time is recorded when that same boss dies
- resolved duration is written to `boss_timer`

Boss loot tracking works like this:
- tracked loot items are identified from loot events
- when a tracked item belongs to exactly one boss, it maps directly
- when multiple bosses can drop the same item, the tracker uses the pending boss queue to resolve the most likely source boss
- once a boss gets resolved loot, it is removed from the queue
- unresolved queued bosses are written as `-1` when the run ends

## Dungeon Data

The `DungeonData/` directory contains the static metadata for supported dungeons.

Each dungeon file defines:
- the internal dungeon key
- the display name
- optional map matching data
- aliases when needed
- tracked bosses
- tracked loot per boss
- reverse loot lookup via `loot_to_bosses`

The shared schema for dungeon definition files lives in:

- [DungeonData/schema.md](C:/Users/Arthur/Software%20Dev/Personal%20Projects/DungeonOracle/DungeonData/schema.md)

## Realm Data

The `RealmData/` directory contains small static realm metadata used by the tracker.

Current usage:
- `HardcoreRealms.lua`
  A set of normalized realm names used to determine whether a run should be tagged with `hardcore = true`.

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
+- RealmData/
|  +- HardcoreRealms.lua
+- DungeonOracle.lua
+- DungeonOracle.toc
+- README.md
+- .gitignore
```

## Core Modules

### `DungeonOracle.lua`

Bootstrap responsibilities:
- create the shared addon namespace
- register slash commands
- initialize UI and tracker on login
- forward runtime events to the tracker

### `Core/Tracker.lua`

Runtime responsibilities:
- identify supported dungeon contexts
- resolve `zone_id`
- manage run creation, continuation, reactivation, and completion
- elect and track the recorder
- broadcast and adopt shared `run_id` values
- collect party, death, boss, loot, money, and XP analytics
- send live state to the tracker UI

### `Core/Database.lua`

Persistence responsibilities:
- initialize SavedVariables
- store settings
- persist one `active_run`
- archive completed runs into `records`
- copy nested run structures safely between active and archived states

### `Core/UI.lua`

Presentation responsibilities:
- minimap launcher button
- main addon window and tabs
- `My Data` table rendering
- hover tooltips for run details
- upload instructions pane
- settings pane
- compact in-dungeon tracker window

## Current SavedVariables Shape

```lua
DungeonOracleDB = {
    settings = {
        show_minimap_button = true,
        show_tracker_window = true,
        minimap_button_angle = 45,
        tracker_window_position = {
            left = 32,
            bottom = 220,
        },
    },
    active_run = {
        dungeon_name = "The Stockade",
        run_id = "888d1a7e3a9148b0",
        zone_id = 24252,
        started_at = 1783264816,
        outside_instance_started_at = 1783266076,
        hardcore = true,
        party = {
            {
                name = "Nossron",
                class = "WARRIOR",
                level = 60,
                role = "TANK",
            },
        },
        replacements = 0,
        deaths = {},
        first_death = nil,
        boss_timer = {
            {
                boss_id = 1666,
                duration = 17,
            },
        },
        boss_loot = {
            [1666] = -1,
        },
        starting_money = 245512,
        gold_earned = 1324,
        starting_xp = 12450,
        xp_gained = 820,
        green_drops = 3,
        blue_drops = 1,
        purple_drops = 0,
        pending_boss_loot_queue = {},
    },
    records = {
        {
            dungeon_name = "The Stockade",
            run_id = "888d1a7e3a9148b0",
            zone_id = 24252,
            started_at = 1783264816,
            outside_instance_started_at = 1783266076,
            ended_at = 1783266106,
            hardcore = true,
            party = {
                {
                    name = "Nossron",
                    class = "WARRIOR",
                    level = 60,
                    role = "TANK",
                },
            },
            replacements = 0,
            deaths = {},
            first_death = nil,
            boss_timer = {
                {
                    boss_id = 1666,
                    duration = 17,
                },
            },
            boss_loot = {
                [1666] = -1,
            },
            starting_money = 245512,
            gold_earned = 1324,
            xp_gained = 820,
            green_drops = 3,
            blue_drops = 1,
            purple_drops = 0,
        },
    },
}
```

## Upload Model

DungeonOracle uses manual export.

Expected flow:
1. The addon records data locally in SavedVariables.
2. The player opens the `Upload Instructions` tab.
3. The player uploads the SavedVariables file manually.
4. Data processing and eventual merging happen outside the game.

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

They are not part of the live runtime flow.

## Installation

Install the addon like a normal WoW Classic Era addon inside:

```text
World of Warcraft\_classic_era_\Interface\AddOns\DungeonOracle
```

## Status

The current branch is stable around:
- `zone_id`-based run tracking
- recorder-based shared `run_id`
- local analytics capture
- compact live UI
- manual data export

Full cross-player data sharing and authoritative multiplayer reconciliation have not been implemented yet.
