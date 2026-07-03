# DungeonOracle

DungeonOracle is a World of Warcraft Classic Era addon focused on collecting structured dungeon-run data for later analysis.

The long-term goal of the project is to build a broader dungeon analytics dataset that can answer questions about group composition, deaths, run pacing, replacements, Hardcore-specific risk, and other run-level behavior.

This repository is currently in an active rebuild phase. Earlier tracking and persistence logic has been preserved in reference files, while the live tracker and database modules are being rebuilt from a cleaner foundation.

## Project Goal

DungeonOracle is meant to run quietly in the background while a player is inside a dungeon and collect data that can later be exported and analyzed outside the game.

The addon is being designed around a few core principles:

- Dungeon data should be structured enough to support later analytics
- Tracking should be modular so dungeon definitions, runtime tracking, persistence, and UI can evolve independently.
- The in-game addon should stay lightweight and understandable.
- Manual upload is acceptable if it keeps the addon simple and robust.
- The recorded schema should support Hardcore analysis in addition to standard loot analysis.

## Current Status

The project currently contains four major areas of work:

- `Data/`
  Static dungeon metadata files, including tracked bosses and tracked loot.

- `Core/UI.lua`
  The in-game UI, including the minimap button, main window, upload instructions tab, and tracker window.

- `Core/Tracker.lua`
  A fresh tracker skeleton that is intentionally not implemented yet.

- `Core/Database.lua`
  The new database schema definition, without full runtime persistence logic yet.

The project also contains reference files that preserve prior logic:

- `Core/TrackerReference.lua`
- `Core/DatabaseReference.lua`

These reference files are read-only historical context for the rebuild and are not meant to be edited further.

## Rebuild Direction

The current rebuild is centered around making the addon support richer analytics than the original loot-only approach.

The new direction includes tracking data such as:

- unique run identity
- dungeon name
- run start and end times
- party composition
- deaths and killers
- replacements during the run
- Hardcore vs non-Hardcore context
- the first death event
- per-boss timing
- boss loot outcomes

The current live codebase is being rebuilt incrementally. Only the exact requested behavior should be added as the algorithm is specified.

## Repository Layout

```text
DungeonOracle/
+- Core/
�  +- Database.lua
�  +- DatabaseReference.lua
�  +- Tracker.lua
�  +- TrackerReference.lua
�  +- UI.lua
+- Data/
�  +- dungeon definition files
+- DungeonOracle.lua
+- DungeonOracle.toc
+- README.md
+- .gitignore
```

## Bootstrap

`DungeonOracle.lua` is the addon bootstrap.

Its responsibilities are intentionally narrow:

- create the shared addon namespace
- register the slash command
- expose the shared chat-print helper
- initialize the UI and tracker on login
- forward non-login events to the tracker module

The bootstrap should remain thin. Dungeon behavior belongs in the tracker module, and saved-variable shape belongs in the database module.

## UI

The UI module is responsible for presentation only.

Current UI pieces include:

- a minimap launcher button
- a central main window
- a `Settings` tab
- an `Upload Instructions` tab
- a compact in-dungeon tracker window

The UI reads settings through the database module, but it should not own dungeon-tracking logic.

## Database Schema

The current database schema is designed to support analytics-first recording.

Top-level structure:

```lua
DungeonOracleDB = {
    settings = {
        show_minimap_button = true,
        show_tracker_window = true,
    },
    active_run = nil,
    records = {
        {
            run_id = "uuid",
            dungeon_name = "The Deadmines",
            instance_id = 36,
            started_at = 0,
            ended_at = 0,
            party = {
                {
                    class = "WARRIOR",
                    level = 20,
                    role = "TANK",
                },
            },
            deaths = {
                {
                    player_name = "Player-Realm",
                    killer_id = 644,
                },
            },
            replacements = 0,
            hardcore = true,
            first_death = {
                timestamp = 0,
                num_bosses_beaten = 0,
                class = "WARRIOR",
            },
            boss_timer = {
                {
                    boss_id = 644,
                    timestamp = 0,
                },
            },
            boss_loot = {
                [644] = 5191,
            },
        },
    },
}
```

### Schema Notes

- `settings`
  Persistent addon preferences.

- `active_run`
  Temporary in-progress state used to avoid losing a run when the addon should preserve it.

- `records`
  Completed run snapshots intended for later export and offline processing.

- `run_id`
  A unique UUID for the run.

- `dungeon_name`
  The user-facing dungeon identifier.

- `instance_id`
  The game-provided live instance identifier captured for the run.

- `started_at` and `ended_at`
  Timestamps reserved for later time-based analysis.

- `party`
  A structured snapshot of the group composition.

- `deaths`
  A list of player death events and the recorded killer ID.

- `replacements`
  The number of replacement players needed during the run.

- `hardcore`
  Whether the run occurred on a Hardcore realm.

- `first_death`
  The first death event worth highlighting for later analysis.

- `boss_timer`
  A per-boss timing log.

- `boss_loot`
  The boss-to-loot mapping collected during the run.

## Dungeon Data Files

The `Data/` directory contains static dungeon definitions.

These files serve as metadata sources for the tracker and are intended to answer questions such as:

- which dungeon is being tracked
- which bosses are relevant
- which loot items are valid tracked outcomes for each boss

At this stage, the data files are considered complete except for future naming-convention fixes if matching issues are discovered.

## Upload Model

DungeonOracle is built around manual export rather than automated remote submission.

The expected flow is:

1. The addon records data locally in SavedVariables.
2. The player uploads the SavedVariables file manually.
3. The uploaded data is processed outside the game.
4. Analytics and deduplication happen in external systems, not in the addon.

This keeps the in-game addon simpler and avoids trying to force network-like workflows into the WoW addon environment.

## Development Rules For This Repo

A few important repository rules currently define how development should proceed:

- The reference files are read-only and exist only for reference.
- The `Data/` files should not be modified except for naming-convention fixes if matching problems are found later.
- New functionality should only be added when explicitly requested.
- Extra convenience behavior should not be introduced unless requested.
- The tracker and database are in a rebuild phase and should stay simple until the algorithm is fully specified.

## Likely Next Steps

The project is positioned for the next phase of work, which will likely include:

- implementing the new tracker algorithm step by step
- defining how `active_run` should be persisted and restored
- deciding exactly how party composition snapshots are captured
- deciding when death events are recorded and how they are normalized
- implementing run completion rules
- wiring the tracker to the new schema
- surfacing tracked state in the in-dungeon UI

## Local Usage

The addon is intended to be installed as a normal WoW addon inside the Classic Era addon directory.

The exported data file will live under the account SavedVariables folder, for example:

```text
World of Warcraft\_classic_era_\WTF\Account\<YOUR_ACCOUNT>\SavedVariables
```

The relevant file for upload is:

```text
DungeonOracle.lua
```

## Notes

This repository is not trying to be a general-purpose addon framework. It is a focused data-collection tool for dungeon analytics.

That focus matters because it drives the design:

- simple UI
- structured records
- modular runtime pieces
- offline analytics
- explicit tracking logic rather than broad automation
