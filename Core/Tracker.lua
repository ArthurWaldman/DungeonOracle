-- Tracker.lua is the setup-only workspace for the new dungeon tracking flow.
--
-- For now this file only establishes structure:
-- 1. tracker namespace
-- 2. future event list
-- 3. initial runtime state shape
-- 4. public entry points used by the bootstrap
--
-- No dungeon algorithm has been implemented yet.

DungeonOracle = DungeonOracle or {}
DungeonOracle.Tracker = DungeonOracle.Tracker or {}

local Tracker = DungeonOracle.Tracker

-- These are the first candidate events for dungeon tracking. They are being
-- registered now so future logic can plug into them without changing the
-- bootstrap file.
local TRACKER_EVENTS = {
    "PLAYER_ENTERING_WORLD",
    "ZONE_CHANGED_NEW_AREA",
    "COMBAT_LOG_EVENT_UNFILTERED",
    "CHAT_MSG_LOOT",
}

-- Runtime state will eventually hold the current dungeon session. Keeping the
-- shape explicit up front makes the later algorithm easier to reason about.
Tracker.state = Tracker.state or nil

-- Returns the initial in-memory tracker state.
-- This defines structure only and does not start or resume a run.
local function createInitialState()
    return {
        is_tracking = false,
        current_dungeon = nil,
        active_run = nil,
    }
end

-- Public: initializes the tracker once and registers the event list that the
-- future algorithm will consume.
function Tracker.Initialize(eventFrame)
    if Tracker.is_initialized then
        return
    end

    Tracker.event_frame = eventFrame
    Tracker.state = createInitialState()

    for _, eventName in ipairs(TRACKER_EVENTS) do
        eventFrame:RegisterEvent(eventName)
    end

    Tracker.is_initialized = true
end

-- Public: central event entry point.
-- Intentionally empty until the dungeon-tracking algorithm is specified.
function Tracker.HandleEvent(event, ...)
end