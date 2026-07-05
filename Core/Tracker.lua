-- Tracker.lua handles the current live runtime:
-- detect supported dungeons, resolve zone_id, start or reactivate runs
-- locally, and close runs after dungeon changes or the outside-instance timeout.

DungeonOracle = DungeonOracle or {}
DungeonOracle.Tracker = DungeonOracle.Tracker or {}

local Tracker = DungeonOracle.Tracker

local TRACKER_EVENTS = {
    "PLAYER_ENTERING_WORLD",
    "ZONE_CHANGED_NEW_AREA",
    "GROUP_ROSTER_UPDATE",
    "PLAYER_LEVEL_UP",
    "PLAYER_REGEN_DISABLED",
    "UNIT_SPELLCAST_START",
    "UNIT_SPELLCAST_SUCCEEDED",
    "COMBAT_LOG_EVENT_UNFILTERED",
}

local OUTSIDE_INSTANCE_TIMEOUT_SECONDS = 30

Tracker.state = Tracker.state or nil

-- Returns the initial runtime state for the tracker.
local function createInitialState()
    return {
        current_dungeon = nil,
        active_run = nil,
        outside_instance_token = nil,
        last_zone_npc_id = nil,
        last_group_size = 0,
        last_replacement_signature = nil,
    }
end

-- Returns the remaining outside-instance timeout for the active run, if one is
-- currently ticking.
local function getOutsideTimeoutRemainingSeconds()
    local activeRun = Tracker.state and Tracker.state.active_run or nil

    if not activeRun or not activeRun.outside_instance_started_at then
        return nil
    end

    return math.max(0, OUTSIDE_INSTANCE_TIMEOUT_SECONDS - (time() - activeRun.outside_instance_started_at))
end

-- Routes tracker lifecycle messages into the in-dungeon tracker log.
local function printMessage(message)
    if not message or message == "" then
        return
    end

    if DungeonOracle.UI and DungeonOracle.UI.AppendTrackerLog then
        DungeonOracle.UI.AppendTrackerLog(message)
    end

    if DungeonOracle.UI and DungeonOracle.UI.ShowTrackerWindow then
        DungeonOracle.UI.ShowTrackerWindow()
    end
end

-- Persists the active_run snapshot whenever tracker-owned metadata changes.
local function persistActiveRun()
    if DungeonOracle.Database and DungeonOracle.Database.SetActiveRun then
        DungeonOracle.Database.SetActiveRun(Tracker.state.active_run)
    end
end

local startFreshRun

local ROLE_DAMAGER = "DAMAGER"
local ROLE_HEALER = "HEALER"
local ROLE_TANK = "TANK"
local SHADOWFORM_SPELL_ID = 15473
local RIGHTEOUS_FURY_SPELL_ID = 25780

-- Produces a simple UUID-like identifier that is sufficient for run identity.
local function createRunId()
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    local seed = tostring(time()) .. tostring(math.random(100000, 999999))
    local cursor = 1

    return string.gsub(template, "[xy]", function(token)
        local sourceByte = string.byte(seed, cursor) or math.random(48, 102)
        local nibble = sourceByte % 16

        cursor = cursor + 1

        if token == "x" then
            return string.format("%x", nibble)
        end

        return string.format("%x", (nibble % 4) + 8)
    end)
end

-- Normalizes dungeon names so formatting differences do not break matching.
local function normalizeDungeonName(name)
    if not name then
        return nil
    end

    name = string.lower(name)
    name = string.gsub(name, "^the%s+", "")
    name = string.gsub(name, "[^%w]", "")

    return name
end

-- Returns the current instance identity when the player is inside an instance.
local function getCurrentInstanceInfo()
    local inInstance = IsInInstance()
    local instanceName

    if not inInstance then
        return nil
    end

    instanceName = GetInstanceInfo()

    return {
        name = instanceName,
        mapId = C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player") or nil,
        entered_at = time(),
    }
end

-- Looks up the static dungeon definition for the current instance.
local function getDungeonDefinition(instanceInfo)
    local normalizedInstanceName
    local mapIdMatch = nil

    if not instanceInfo or not DungeonOracleData or not DungeonOracleData.dungeons then
        return nil
    end

    normalizedInstanceName = normalizeDungeonName(instanceInfo.name)

    for _, dungeon in pairs(DungeonOracleData.dungeons) do
        if dungeon.name and normalizeDungeonName(dungeon.name) == normalizedInstanceName then
            return dungeon
        end

        if dungeon.aliases then
            for _, aliasName in ipairs(dungeon.aliases) do
                if normalizeDungeonName(aliasName) == normalizedInstanceName then
                    return dungeon
                end
            end
        end

        if not mapIdMatch and dungeon.map_id and instanceInfo.mapId and dungeon.map_id == instanceInfo.mapId then
            mapIdMatch = dungeon
        end
    end

    return mapIdMatch
end

-- Clears any in-flight outside-instance timeout. A token is used so stale
-- timers cannot complete runs after the player has returned.
local function clearOutsideInstanceTimeout()
    Tracker.state.outside_instance_token = nil

    if Tracker.state.active_run and Tracker.state.active_run.outside_instance_started_at then
        Tracker.state.active_run.outside_instance_started_at = nil
        persistActiveRun()
    end
end

-- Extracts the Nova-style zone_id and npc_id from a GUID when possible.
local function getZoneInfoFromGuid(guid)
    local unitType
    local zoneId
    local npcId

    if not guid then
        return nil, nil
    end

    unitType, _, _, _, zoneId, npcId = strsplit("-", guid)
    zoneId = tonumber(zoneId)
    npcId = tonumber(npcId)

    if (unitType ~= "Creature" and unitType ~= "Cast") or not zoneId or zoneId <= 0 then
        return nil, nil
    end

    return zoneId, npcId
end

-- Nova does not trust the combat log immediately on instance entry. That helps
-- avoid latching onto noisy or transitional GUIDs before the dungeon context
-- stabilizes.
local function canObserveCombatLogZone()
    local currentDungeon = Tracker.state.current_dungeon

    if not currentDungeon or not currentDungeon.entered_at then
        return false
    end

    return (time() - currentDungeon.entered_at) > 2
end

-- Filters out combat log noise that should never be used for zone_id
-- resolution.
local function isReliableCombatLogSubEvent(subEvent)
    return subEvent ~= "SPELL_CAST_FAILED" and subEvent ~= "SPELL_FAILED"
end

-- Applies Nova's basic zone_id heuristic: accept the first valid zone_id we see
-- for the dungeon context, and continue remembering the last npc_id seen.
local function observeZoneId(zoneId, npcId, sourceLabel)
    local currentDungeon = Tracker.state.current_dungeon
    local previousNpcId = Tracker.state.last_zone_npc_id
    local shouldSetZoneId
    local isNewZoneId

    if not currentDungeon or not zoneId then
        return nil
    end

    shouldSetZoneId = (not currentDungeon.zone_id) or (npcId and previousNpcId and npcId == previousNpcId)
    Tracker.state.last_zone_npc_id = npcId or previousNpcId

    if shouldSetZoneId then
        isNewZoneId = currentDungeon.zone_id ~= zoneId
        currentDungeon.zone_id = zoneId

        if Tracker.state.active_run and not Tracker.state.active_run.zone_id then
            Tracker.state.active_run.zone_id = zoneId
            persistActiveRun()
        end

        if isNewZoneId and sourceLabel then
            printMessage(string.format("resolved zone id %d from %s.", zoneId, sourceLabel))
        end
    end

    return currentDungeon.zone_id
end

-- Returns the group units that should be sampled when a run begins.
local function getTrackedPartyUnits()
    local units = { "player" }
    local index

    if IsInRaid and IsInRaid() then
        return units
    end

    for index = 1, 4 do
        if UnitExists("party" .. index) then
            table.insert(units, "party" .. index)
        end
    end

    return units
end

-- Returns a stable player identifier for snapshotting party state. Realm is
-- included when available so later comparison works even if duplicate names
-- ever appear.
local function getUnitFullName(unitToken)
    local name, realmName = UnitName(unitToken)

    if not name or name == "" then
        return nil
    end

    if realmName and realmName ~= "" then
        return string.format("%s-%s", name, realmName)
    end

    return name
end

-- Returns the current tracked group size. Raid-sized groups are allowed to
-- report larger than five so replacement logic can explicitly ignore them.
local function getTrackedGroupSize()
    if IsInRaid and IsInRaid() and GetNumGroupMembers then
        return GetNumGroupMembers() or 0
    end

    if GetNumSubgroupMembers then
        return (GetNumSubgroupMembers() or 0) + 1
    end

    return 1
end

-- Checks whether a unit currently has the requested buff. This lets role
-- inference use a few strong live signals without committing to full combat
-- analytics yet.
local function unitHasBuff(unitToken, spellName)
    local buffIndex = 1
    local buffName

    if not unitToken or not spellName or spellName == "" then
        return false
    end

    while true do
        buffName = UnitBuff(unitToken, buffIndex)
        if not buffName then
            return false
        end

        if buffName == spellName then
            return true
        end

        buffIndex = buffIndex + 1
    end
end

local function canTank(classFilename)
    return classFilename == "WARRIOR" or classFilename == "DRUID" or classFilename == "PALADIN"
end

local function canHeal(classFilename)
    return classFilename == "PRIEST"
        or classFilename == "DRUID"
        or classFilename == "SHAMAN"
        or classFilename == "PALADIN"
end

local function isPureDamageClass(classFilename)
    return classFilename == "MAGE"
        or classFilename == "ROGUE"
        or classFilename == "HUNTER"
        or classFilename == "WARLOCK"
end

local function prefersHealing(member)
    if member.class == "PRIEST" and not member.is_using_shadowform then
        return true
    end

    return member.class == "DRUID" or member.class == "SHAMAN" or member.class == "PALADIN"
end

local function prefersTanking(member)
    if member.class == "PALADIN" and member.has_righteous_fury then
        return true
    end

    return member.class == "WARRIOR" or member.class == "DRUID" or member.class == "PALADIN"
end

local function getSingleRoleCandidateIndex(party, roleName)
    local candidateIndex = nil
    local candidateCount = 0
    local index
    local member

    for index, member in ipairs(party) do
        if (roleName == ROLE_TANK and canTank(member.class))
            or (roleName == ROLE_HEALER and canHeal(member.class)) then
            candidateIndex = index
            candidateCount = candidateCount + 1
        end
    end

    if candidateCount == 1 then
        return candidateIndex
    end

    return nil
end

local function getPreferredRoleCandidateIndex(party, roleName, excludedIndex)
    local index
    local member

    for index, member in ipairs(party) do
        if index ~= excludedIndex then
            if roleName == ROLE_HEALER and member.assigned_role == ROLE_HEALER then
                return index
            end

            if roleName == ROLE_TANK and member.assigned_role == ROLE_TANK then
                return index
            end
        end
    end

    if roleName == ROLE_HEALER then
        for index, member in ipairs(party) do
            if index ~= excludedIndex and member.class == "PRIEST" and not member.is_using_shadowform then
                return index
            end
        end

        for index, member in ipairs(party) do
            if index ~= excludedIndex and prefersHealing(member) then
                return index
            end
        end
    end

    if roleName == ROLE_TANK then
        for index, member in ipairs(party) do
            if index ~= excludedIndex and member.class == "PALADIN" and member.has_righteous_fury then
                return index
            end
        end

        for index, member in ipairs(party) do
            if index ~= excludedIndex and member.class == "WARRIOR" then
                return index
            end
        end

        for index, member in ipairs(party) do
            if index ~= excludedIndex and prefersTanking(member) then
                return index
            end
        end
    end

    return nil
end

-- Builds the raw party snapshot before group-aware role assignment is applied.
local function buildPartySnapshot()
    local units = getTrackedPartyUnits()
    local party = {}
    local unitToken
    local playerName
    local _, classFilename
    local level
    local assignedRole
    local shadowformName = GetSpellInfo and GetSpellInfo(SHADOWFORM_SPELL_ID) or nil
    local righteousFuryName = GetSpellInfo and GetSpellInfo(RIGHTEOUS_FURY_SPELL_ID) or nil

    for _, unitToken in ipairs(units) do
        if UnitExists(unitToken) then
            playerName = getUnitFullName(unitToken)
            _, classFilename = UnitClass(unitToken)
            level = UnitLevel(unitToken)
            assignedRole = UnitGroupRolesAssigned and UnitGroupRolesAssigned(unitToken) or "NONE"

            table.insert(party, {
                name = playerName or "UNKNOWN",
                class = classFilename or "UNKNOWN",
                level = level or 0,
                role = ROLE_DAMAGER,
                assigned_role = assignedRole,
                is_using_shadowform = shadowformName and unitHasBuff(unitToken, shadowformName) or false,
                has_righteous_fury = righteousFuryName and unitHasBuff(unitToken, righteousFuryName) or false,
            })
        end
    end

    return party
end

-- Builds a stable signature from the party names present in a five-player
-- group. Replacement detection now keys off the actual player identities.
local function buildPartyNameSignature(party)
    local entries = {}
    local index
    local member

    if not party then
        return ""
    end

    for index, member in ipairs(party) do
        entries[index] = member.name or "UNKNOWN"
    end

    table.sort(entries)

    return table.concat(entries, "|")
end

-- Reconciles in-dungeon level-ups without changing replacement identity. When
-- a matched player gains a level during the run, we record that as +0.5 for
-- later aggregate analysis.
local function updatePartyLevelsForLevelUps(activeRun, currentParty)
    local currentLevelsByName = {}
    local changed = false
    local member
    local currentLevel
    local storedBaselineLevel
    local gainedLevels

    if not activeRun or not activeRun.party or not currentParty then
        return false
    end

    for _, member in ipairs(currentParty) do
        if member.name and member.name ~= "" then
            currentLevelsByName[member.name] = tonumber(member.level) or 0
        end
    end

    for _, member in ipairs(activeRun.party) do
        if member.name and member.name ~= "" then
            currentLevel = currentLevelsByName[member.name]
            storedBaselineLevel = math.ceil(tonumber(member.level) or 0)

            if currentLevel and currentLevel > storedBaselineLevel then
                gainedLevels = currentLevel - storedBaselineLevel
                member.level = (tonumber(member.level) or 0) + (gainedLevels * 0.5)
                changed = true
            end
        end
    end

    return changed
end

-- Infers one healer and one tank using explicit class rules plus a few strong
-- live buff checks. Everyone else defaults to damage.
local function finalizePartyRoles(party)
    local healerIndex
    local tankIndex
    local index
    local member

    for index, member in ipairs(party) do
        if isPureDamageClass(member.class) then
            member.role = ROLE_DAMAGER
        end
    end

    healerIndex = getSingleRoleCandidateIndex(party, ROLE_HEALER)
    if not healerIndex then
        healerIndex = getPreferredRoleCandidateIndex(party, ROLE_HEALER)
    end

    tankIndex = getSingleRoleCandidateIndex(party, ROLE_TANK)
    if tankIndex == healerIndex then
        tankIndex = nil
    end
    if not tankIndex then
        tankIndex = getPreferredRoleCandidateIndex(party, ROLE_TANK, healerIndex)
    end

    for index, member in ipairs(party) do
        if index == healerIndex then
            member.role = ROLE_HEALER
        elseif index == tankIndex then
            member.role = ROLE_TANK
        else
            member.role = ROLE_DAMAGER
        end

        member.assigned_role = nil
        member.is_using_shadowform = nil
        member.has_righteous_fury = nil
    end

    return party
end

-- Captures the initial per-player snapshot for the run. This is collected
-- once, at run start, and stored with the run record.
local function collectPartySnapshot()
    return finalizePartyRoles(buildPartySnapshot())
end

-- Stores the active run in memory and persists the same state into the
-- database layer so later rebuild steps can rely on one shared shape.
local function setActiveRun(runId, dungeonName, startedAt, zoneId, party)
    Tracker.state.active_run = {
        run_id = runId,
        dungeon_name = dungeonName,
        started_at = startedAt,
        zone_id = zoneId,
        outside_instance_started_at = nil,
        party = party or {},
        replacements = 0,
    }

    Tracker.state.last_group_size = #Tracker.state.active_run.party
    Tracker.state.last_replacement_signature = buildPartyNameSignature(Tracker.state.active_run.party)
    persistActiveRun()
end

-- Restores a locally known run into tracker state when the player enters the
-- same dungeon instance again.
local function reactivateKnownRunByDungeon(dungeonName, zoneId)
    local existingRun

    if not DungeonOracle.Database or not DungeonOracle.Database.ReactivateRunByDungeon then
        return false
    end

    existingRun = DungeonOracle.Database.ReactivateRunByDungeon(dungeonName, zoneId)
    if not existingRun then
        return false
    end

    Tracker.state.active_run = {
        run_id = existingRun.run_id,
        dungeon_name = existingRun.dungeon_name or dungeonName,
        started_at = existingRun.started_at,
        zone_id = existingRun.zone_id or zoneId,
        outside_instance_started_at = nil,
        party = existingRun.party or {},
        replacements = existingRun.replacements or 0,
    }

    Tracker.state.last_group_size = getTrackedGroupSize()
    Tracker.state.last_replacement_signature = buildPartyNameSignature(Tracker.state.active_run.party)
    persistActiveRun()
    return true
end

-- When the player is still in the same dungeon name but the resolved zone_id
-- changes, the old run must be completed and replaced with a fresh run for the
-- new instance.
local function transitionToNewRunForZoneShift()
    local activeRun = Tracker.state.active_run
    local currentDungeon = Tracker.state.current_dungeon
    local previousRunId
    local previousZoneId

    if not activeRun or not currentDungeon or not currentDungeon.zone_id then
        return false
    end

    if normalizeDungeonName(activeRun.dungeon_name) ~= normalizeDungeonName(currentDungeon.name) then
        return false
    end

    if not activeRun.zone_id or activeRun.zone_id == currentDungeon.zone_id then
        return false
    end

    previousRunId = activeRun.run_id
    previousZoneId = activeRun.zone_id

    if DungeonOracle.Database and DungeonOracle.Database.CompleteActiveRun then
        DungeonOracle.Database.CompleteActiveRun(time())
    elseif DungeonOracle.Database and DungeonOracle.Database.ClearActiveRun then
        DungeonOracle.Database.ClearActiveRun()
    end

    Tracker.state.active_run = nil
    printMessage(string.format(
        "completed run %s because %s changed from zone id %d to %d.",
        previousRunId or "-",
        currentDungeon.name,
        previousZoneId,
        currentDungeon.zone_id
    ))

    return startFreshRun()
end

-- Starts a fresh run once zone_id has been resolved and no matching stored run
-- exists for the current dungeon context.
startFreshRun = function()
    local currentDungeon = Tracker.state.current_dungeon
    local startedAt
    local runId
    local party

    if not currentDungeon or not currentDungeon.zone_id or Tracker.state.active_run then
        return false
    end

    startedAt = time()
    runId = createRunId()
    party = collectPartySnapshot()

    setActiveRun(runId, currentDungeon.name, startedAt, currentDungeon.zone_id, party)
    printMessage(string.format("run started for %s with zone id %d.", currentDungeon.name, currentDungeon.zone_id))
    return true
end

-- Once zone_id is known, the tracker first tries to reactivate a matching run.
-- If no match exists, a new run is created locally.
local function resolveRunForCurrentDungeon()
    local currentDungeon = Tracker.state.current_dungeon

    if not currentDungeon or not currentDungeon.zone_id then
        return false
    end

    if Tracker.state.active_run then
        return transitionToNewRunForZoneShift()
    end

    if reactivateKnownRunByDungeon(currentDungeon.name, currentDungeon.zone_id) then
        printMessage(string.format("reactivated run for %s.", currentDungeon.name))
        return true
    end

    return startFreshRun()
end

-- Detects when a full five-player run has one or more genuinely new names in
-- the group compared to the run-start party snapshot.
local function handleGroupRosterUpdate()
    local activeRun = Tracker.state.active_run
    local previousGroupSize = Tracker.state.last_group_size or 0
    local currentGroupSize = getTrackedGroupSize()
    local startGroupSize
    local currentParty
    local currentSignature
    local startSignature
    local startNameSet = {}
    local currentNameSet = {}
    local replacementDelta = 0
    local index
    local member

    Tracker.state.last_group_size = currentGroupSize

    if not activeRun or not activeRun.party then
        return
    end

    startGroupSize = #activeRun.party
    if startGroupSize ~= 5 then
        return
    end

    if currentGroupSize <= previousGroupSize then
        return
    end

    if currentGroupSize > 5 or currentGroupSize ~= 5 then
        return
    end

    currentParty = buildPartySnapshot()
    if updatePartyLevelsForLevelUps(activeRun, currentParty) then
        persistActiveRun()
        printMessage("party levels updated for detected in-dungeon level ups.")
    end

    currentSignature = buildPartyNameSignature(currentParty)
    startSignature = buildPartyNameSignature(activeRun.party)

    if currentSignature == startSignature then
        Tracker.state.last_replacement_signature = currentSignature
        return
    end

    if Tracker.state.last_replacement_signature == currentSignature then
        return
    end

    for _, member in ipairs(activeRun.party) do
        if member.name and member.name ~= "" then
            startNameSet[member.name] = true
        end
    end

    for _, member in ipairs(currentParty) do
        if member.name and member.name ~= "" then
            currentNameSet[member.name] = true
        end
    end

    for index, member in ipairs(currentParty) do
        if member.name and member.name ~= "" and currentNameSet[member.name] and not startNameSet[member.name] then
            replacementDelta = replacementDelta + 1
            currentNameSet[member.name] = nil
        end
    end

    if replacementDelta <= 0 then
        Tracker.state.last_replacement_signature = currentSignature
        return
    end

    activeRun.replacements = (tonumber(activeRun.replacements) or 0) + replacementDelta
    Tracker.state.last_replacement_signature = currentSignature
    persistActiveRun()
    printMessage(string.format("replacement detected. replacement count is now %d.", activeRun.replacements))
end

-- Completes the current active run after the player has remained outside all
-- instances for 30 seconds.
local function finalizeOutsideInstanceTimeout(timeoutToken)
    local activeRun = Tracker.state.active_run

    if not activeRun or Tracker.state.outside_instance_token ~= timeoutToken or Tracker.state.current_dungeon then
        return
    end

    Tracker.state.outside_instance_token = nil

    if DungeonOracle.Database and DungeonOracle.Database.CompleteActiveRun then
        DungeonOracle.Database.CompleteActiveRun(time())
    elseif DungeonOracle.Database and DungeonOracle.Database.ClearActiveRun then
        DungeonOracle.Database.ClearActiveRun()
    end

    Tracker.state.active_run = nil
    printMessage("previous run completed after being outside all instances for 30 seconds.")

    if DungeonOracle.UI and DungeonOracle.UI.HideTrackerWindow then
        DungeonOracle.UI.HideTrackerWindow()
    end
end

-- Starts or resumes the 30-second outside-instance timeout for the current
-- active run. If the timeout already elapsed while the addon was inactive, the
-- run is completed immediately on the next relevant event.
local function beginOutsideInstanceTimeout()
    local activeRun = Tracker.state.active_run
    local outsideStartedAt
    local remainingSeconds
    local timeoutToken

    if not activeRun then
        return
    end

    outsideStartedAt = activeRun.outside_instance_started_at or time()
    activeRun.outside_instance_started_at = outsideStartedAt
    persistActiveRun()

    remainingSeconds = OUTSIDE_INSTANCE_TIMEOUT_SECONDS - (time() - outsideStartedAt)
    if remainingSeconds <= 0 then
        finalizeOutsideInstanceTimeout(Tracker.state.outside_instance_token)
        return
    end

    timeoutToken = string.format("outside-%d-%d", time(), math.random(100000, 999999))
    Tracker.state.outside_instance_token = timeoutToken

    if C_Timer and C_Timer.After then
        C_Timer.After(remainingSeconds, function()
            finalizeOutsideInstanceTimeout(timeoutToken)
        end)
    else
        finalizeOutsideInstanceTimeout(timeoutToken)
    end
end

-- Public: returns the current outside-instance timeout remaining in seconds so
-- the dungeon tracker UI can show it live.
function Tracker.GetOutsideTimeoutRemainingSeconds()
    return getOutsideTimeoutRemainingSeconds()
end

-- Completes the current active run when the player enters a different
-- supported dungeon context. That includes either a different instance of the
-- same dungeon or a completely different dungeon.
local function completeActiveRunForDungeonTransition()
    local activeRun = Tracker.state.active_run
    local currentDungeon = Tracker.state.current_dungeon

    if not activeRun or not currentDungeon then
        return false
    end

    if normalizeDungeonName(activeRun.dungeon_name) == normalizeDungeonName(currentDungeon.name) then
        return false
    end

    Tracker.state.outside_instance_token = nil

    if DungeonOracle.Database and DungeonOracle.Database.CompleteActiveRun then
        DungeonOracle.Database.CompleteActiveRun(time())
    elseif DungeonOracle.Database and DungeonOracle.Database.ClearActiveRun then
        DungeonOracle.Database.ClearActiveRun()
    end

    Tracker.state.active_run = nil
    printMessage(string.format("previous run completed because %s was entered.", currentDungeon.name))

    return true
end

-- Refreshes the current dungeon context from the player's location.
local function updateCurrentDungeon()
    local instanceInfo = getCurrentInstanceInfo()
    local dungeonDefinition = getDungeonDefinition(instanceInfo)

    if dungeonDefinition then
        Tracker.state.current_dungeon = {
            id = dungeonDefinition.id,
            name = dungeonDefinition.name,
            zone_id = nil,
            entered_at = instanceInfo.entered_at,
        }
        Tracker.state.last_zone_npc_id = nil
        clearOutsideInstanceTimeout()

        if DungeonOracle.UI and DungeonOracle.UI.ResetTrackerLogs then
            DungeonOracle.UI.ResetTrackerLogs()
        end

        if DungeonOracle.UI and DungeonOracle.UI.ShowTrackerWindow then
            DungeonOracle.UI.ShowTrackerWindow()
        end

        printMessage(string.format("detected supported dungeon: %s.", dungeonDefinition.name))
    else
        Tracker.state.current_dungeon = nil

        if not instanceInfo and Tracker.state.active_run then
            beginOutsideInstanceTimeout()
        elseif DungeonOracle.UI and DungeonOracle.UI.HideTrackerWindow then
            DungeonOracle.UI.HideTrackerWindow()
        end
    end
end

function Tracker.Initialize(eventFrame)
    local persistedActiveRun

    if Tracker.is_initialized then
        return
    end

    if DungeonOracle.Database and DungeonOracle.Database.Initialize then
        DungeonOracle.Database.Initialize()
    end

    Tracker.state = createInitialState()

    if DungeonOracle.Database and DungeonOracle.Database.GetActiveRun then
        persistedActiveRun = DungeonOracle.Database.GetActiveRun()
        if persistedActiveRun then
            Tracker.state.active_run = persistedActiveRun
        end
    end

    updateCurrentDungeon()

    if Tracker.state.active_run then
        if Tracker.state.current_dungeon then
            if not Tracker.state.current_dungeon.zone_id and Tracker.state.active_run.zone_id then
                Tracker.state.current_dungeon.zone_id = Tracker.state.active_run.zone_id
            end

            if DungeonOracle.UI and DungeonOracle.UI.ShowTrackerWindow then
                DungeonOracle.UI.ShowTrackerWindow()
            end
        else
            beginOutsideInstanceTimeout()

            if DungeonOracle.UI and DungeonOracle.UI.ShowTrackerWindow then
                DungeonOracle.UI.ShowTrackerWindow()
            end
        end

        Tracker.state.last_group_size = getTrackedGroupSize()
        Tracker.state.last_replacement_signature = buildPartyNameSignature(Tracker.state.active_run.party)
    end

    for _, eventName in ipairs(TRACKER_EVENTS) do
        eventFrame:RegisterEvent(eventName)
    end

    Tracker.is_initialized = true
end

-- Public: central event entry point for the current first-combat start logic.
function Tracker.HandleEvent(event, ...)
    if event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
        updateCurrentDungeon()
        completeActiveRunForDungeonTransition()
    elseif event == "GROUP_ROSTER_UPDATE" then
        handleGroupRosterUpdate()
    elseif event == "PLAYER_LEVEL_UP" then
        if Tracker.state.active_run and updatePartyLevelsForLevelUps(Tracker.state.active_run, buildPartySnapshot()) then
            persistActiveRun()
            printMessage("party levels updated after a detected level up.")
        end
    elseif event == "PLAYER_REGEN_DISABLED" then
        printMessage("combat detected; waiting for zone id from a reliable creature GUID.")
    elseif event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_SUCCEEDED" then
        local unitToken, castGUID = ...
        local zoneId
        local npcId

        if unitToken == "player" then
            zoneId, npcId = getZoneInfoFromGuid(castGUID)
            if observeZoneId(zoneId, npcId, string.lower(event)) then
                resolveRunForCurrentDungeon()
            end
        end
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _, subEvent, _, sourceGUID, _, _, _, destGUID = CombatLogGetCurrentEventInfo()
        local zoneId
        local npcId

        if canObserveCombatLogZone() and isReliableCombatLogSubEvent(subEvent) then
            zoneId, npcId = getZoneInfoFromGuid(sourceGUID)
            if not observeZoneId(zoneId, npcId, "combat log source GUID") then
                zoneId, npcId = getZoneInfoFromGuid(destGUID)
                observeZoneId(zoneId, npcId, "combat log dest GUID")
            end
        end

        resolveRunForCurrentDungeon()
    end
end
