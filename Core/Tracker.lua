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
    "PLAYER_ALIVE",
    "PLAYER_UNGHOST",
    "PLAYER_REGEN_DISABLED",
    "UNIT_SPELLCAST_START",
    "UNIT_SPELLCAST_SUCCEEDED",
    "COMBAT_LOG_EVENT_UNFILTERED",
    "CHAT_MSG_LOOT",
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
        active_boss_engagements = {},
        pending_boss_loot_queue = {},
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

-- Returns whether the player is currently dead or released as a ghost. We use
-- this to avoid treating a death release as a normal dungeon exit.
local function isPlayerDeadOrGhost()
    return UnitIsDeadOrGhost and UnitIsDeadOrGhost("player") or false
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
    if Tracker.state and Tracker.state.active_run then
        Tracker.state.active_run.pending_boss_loot_queue = Tracker.state.pending_boss_loot_queue or {}
    end

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
local ITEM_LINK_ID_PATTERN = "item:(%d+)"

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

-- Checks whether the current realm is one of the configured Hardcore realms.
local function isCurrentRealmHardcore()
    local realmName = GetRealmName and GetRealmName() or nil
    local normalizedRealmName

    if not realmName or realmName == "" then
        return false
    end

    normalizedRealmName = normalizeDungeonName(realmName)

    return DungeonOracleRealmData
        and DungeonOracleRealmData.hardcore_realms
        and DungeonOracleRealmData.hardcore_realms[normalizedRealmName] == true
        or false
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

-- Returns the currently tracked dungeon definition for the player's active
-- supported dungeon context.
local function getCurrentTrackedDungeonDefinition()
    local currentDungeon = Tracker.state.current_dungeon

    if not currentDungeon or not currentDungeon.id or not DungeonOracleData or not DungeonOracleData.dungeons then
        return nil
    end

    return DungeonOracleData.dungeons[currentDungeon.id]
end

local function getTrackedBossIdsForLoot(itemId)
    local dungeonDefinition = getCurrentTrackedDungeonDefinition()

    if not dungeonDefinition or not dungeonDefinition.loot_to_bosses or not itemId then
        return nil
    end

    return dungeonDefinition.loot_to_bosses[itemId]
end

local function getTrackedBossByNpcId(npcId)
    local dungeonDefinition = getCurrentTrackedDungeonDefinition()
    local boss

    if not dungeonDefinition or not dungeonDefinition.bosses or not npcId then
        return nil
    end

    for _, boss in ipairs(dungeonDefinition.bosses) do
        if boss.id == npcId then
            return boss
        end
    end

    return nil
end

local function isBossPendingLootResolution(bossId)
    local pendingBossId

    for _, pendingBossId in ipairs(Tracker.state.pending_boss_loot_queue) do
        if pendingBossId == bossId then
            return true
        end
    end

    return false
end

local function appendPendingBossLootResolution(bossId)
    local activeRun = Tracker.state.active_run

    if not activeRun or not bossId then
        return false
    end

    activeRun.boss_loot = activeRun.boss_loot or {}

    if activeRun.boss_loot[bossId] or isBossPendingLootResolution(bossId) then
        return false
    end

    table.insert(Tracker.state.pending_boss_loot_queue, bossId)
    persistActiveRun()
    return true
end

local function removePendingBossLootResolution(bossId)
    local index

    for index = #Tracker.state.pending_boss_loot_queue, 1, -1 do
        if Tracker.state.pending_boss_loot_queue[index] == bossId then
            table.remove(Tracker.state.pending_boss_loot_queue, index)
            persistActiveRun()
            return true
        end
    end

    return false
end

local function restorePendingBossLootQueueFromActiveRun()
    if not Tracker.state then
        return
    end

    if Tracker.state.active_run and Tracker.state.active_run.pending_boss_loot_queue then
        Tracker.state.pending_boss_loot_queue = Tracker.state.active_run.pending_boss_loot_queue
    else
        Tracker.state.pending_boss_loot_queue = {}
    end
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

-- Normalizes player names for comparisons between party snapshots and combat
-- log names, which may or may not include realm suffixes depending on source.
local function normalizePlayerName(name)
    if not name or name == "" then
        return nil
    end

    name = string.lower(name)
    name = string.gsub(name, "%-.+$", "")

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

local function refreshActiveRunPartyLevelsFromLiveGroup()
    local activeRun = Tracker.state.active_run
    local currentParty

    if not activeRun then
        return false
    end

    currentParty = buildPartySnapshot()
    if not currentParty or #currentParty == 0 then
        return false
    end

    return updatePartyLevelsForLevelUps(activeRun, currentParty)
end

local function hasBossTimerEntry(activeRun, bossId)
    local timerEntry

    if not activeRun or not activeRun.boss_timer or not bossId then
        return false
    end

    for _, timerEntry in ipairs(activeRun.boss_timer) do
        if timerEntry.boss_id == bossId then
            return true
        end
    end

    return false
end

-- Starts the in-memory timer for a boss the first time we see that boss
-- involved in combat during the current run.
local function recordBossEngagementStart(bossId, bossName)
    local activeRun = Tracker.state.active_run

    if not activeRun or not bossId then
        return false
    end

    if hasBossTimerEntry(activeRun, bossId) or Tracker.state.active_boss_engagements[bossId] then
        return false
    end

    Tracker.state.active_boss_engagements[bossId] = time()
    appendPendingBossLootResolution(bossId)
    printMessage(string.format("boss timer started for %s.", bossName or tostring(bossId)))
    return true
end

-- Completes a started boss timer once that same boss dies.
local function recordBossEngagementEnd(bossId, bossName)
    local activeRun = Tracker.state.active_run
    local startedAt
    local duration

    if not activeRun or not bossId then
        return false
    end

    startedAt = Tracker.state.active_boss_engagements[bossId]
    if not startedAt or hasBossTimerEntry(activeRun, bossId) then
        return false
    end

    duration = math.max(0, time() - startedAt)
    activeRun.boss_timer = activeRun.boss_timer or {}
    table.insert(activeRun.boss_timer, {
        boss_id = bossId,
        duration = duration,
    })

    Tracker.state.active_boss_engagements[bossId] = nil
    appendPendingBossLootResolution(bossId)
    persistActiveRun()
    printMessage(string.format("boss timer recorded for %s: %d seconds.", bossName or tostring(bossId), duration))
    return true
end

-- Marks any in-progress boss timers as failed when the player releases as a
-- ghost before seeing the boss die.
local function recordFailedBossEngagementsOnRelease()
    local activeRun = Tracker.state.active_run
    local hadFailures = false
    local bossId
    local boss

    if not activeRun or not Tracker.state.active_boss_engagements then
        return false
    end

    activeRun.boss_timer = activeRun.boss_timer or {}

    for bossId in pairs(Tracker.state.active_boss_engagements) do
        if not hasBossTimerEntry(activeRun, bossId) then
            boss = getTrackedBossByNpcId(bossId)

            table.insert(activeRun.boss_timer, {
                boss_id = bossId,
                duration = -1,
            })

            printMessage(string.format("boss timer failed for %s after spirit release.", boss and boss.name or tostring(bossId)))
            hadFailures = true
        end

        Tracker.state.active_boss_engagements[bossId] = nil
    end

    if hadFailures then
        persistActiveRun()
    end

    return hadFailures
end

local function findTrackedPartyMemberByName(party, playerName)
    local normalizedPlayerName = normalizePlayerName(playerName)
    local member

    if not party or not normalizedPlayerName then
        return nil
    end

    for _, member in ipairs(party) do
        if normalizePlayerName(member.name) == normalizedPlayerName then
            return member
        end
    end

    return nil
end

local function getBossesBeatenCount(activeRun)
    local count = 0
    local timerEntry

    if not activeRun or not activeRun.boss_timer then
        return 0
    end

    for _, timerEntry in ipairs(activeRun.boss_timer) do
        if timerEntry and timerEntry.boss_id then
            count = count + 1
        end
    end

    return count
end

-- Appends one death record when a tracked party member dies during an active
-- run. The snapshot is intentionally simple: class and level.
local function recordPartyDeath(deadPlayerName)
    local activeRun = Tracker.state.active_run
    local member

    if not activeRun then
        return false
    end

    member = findTrackedPartyMemberByName(activeRun.party, deadPlayerName)
    if not member then
        return false
    end

    activeRun.deaths = activeRun.deaths or {}
    table.insert(activeRun.deaths, {
        class = member.class,
        level = member.level,
    })

    if not activeRun.first_death then
        activeRun.first_death = {
            timestamp = math.max(0, time() - (activeRun.started_at or time())),
            num_bosses_beaten = getBossesBeatenCount(activeRun),
            class = member.class,
        }
    end

    persistActiveRun()
    printMessage(string.format("recorded death for %s.", member.name or deadPlayerName or "party member"))
    return true
end

local function getItemIdFromLootMessage(message)
    local itemId = message and string.match(message, ITEM_LINK_ID_PATTERN) or nil

    return tonumber(itemId)
end

local function recordBossLoot(itemId)
    local activeRun = Tracker.state.active_run
    local bossIds
    local resolvedBossId = nil
    local queuedBossId
    local bossId

    if not activeRun or not itemId then
        return false
    end

    bossIds = getTrackedBossIdsForLoot(itemId)
    if not bossIds or #bossIds == 0 then
        return false
    end

    activeRun.boss_loot = activeRun.boss_loot or {}

    if #bossIds == 1 then
        resolvedBossId = bossIds[1]
    else
        for _, queuedBossId in ipairs(Tracker.state.pending_boss_loot_queue) do
            for _, bossId in ipairs(bossIds) do
                if queuedBossId == bossId and not activeRun.boss_loot[bossId] then
                    resolvedBossId = bossId
                    break
                end
            end

            if resolvedBossId then
                break
            end
        end
    end

    if not resolvedBossId or activeRun.boss_loot[resolvedBossId] then
        return false
    end

    activeRun.boss_loot[resolvedBossId] = itemId
    removePendingBossLootResolution(resolvedBossId)
    persistActiveRun()
    printMessage(string.format("recorded boss loot %d for boss %d.", itemId, resolvedBossId))
    return true
end

-- Before a run is archived, any bosses still waiting for loot resolution are
-- written as -1 so the export clearly shows that no tracked loot was captured
-- for that boss on this client.
local function finalizePendingBossLoot()
    local activeRun = Tracker.state.active_run
    local queuedBossId
    local changed = false

    if not activeRun then
        return false
    end

    activeRun.boss_loot = activeRun.boss_loot or {}

    for _, queuedBossId in ipairs(Tracker.state.pending_boss_loot_queue) do
        if activeRun.boss_loot[queuedBossId] == nil then
            activeRun.boss_loot[queuedBossId] = -1
            changed = true
        end
    end

    if changed then
        persistActiveRun()
    end

    return changed
end

-- Stores the active run in memory and persists the same state into the
-- database layer so later rebuild steps can rely on one shared shape.
local function setActiveRun(runId, dungeonName, startedAt, zoneId, party, hardcore)
    Tracker.state.active_run = {
        run_id = runId,
        dungeon_name = dungeonName,
        started_at = startedAt,
        zone_id = zoneId,
        outside_instance_started_at = nil,
        hardcore = hardcore == true,
        party = party or {},
        replacements = 0,
        deaths = {},
        first_death = nil,
        boss_timer = {},
        boss_loot = {},
        pending_boss_loot_queue = {},
    }

    Tracker.state.last_group_size = #Tracker.state.active_run.party
    Tracker.state.last_replacement_signature = buildPartyNameSignature(Tracker.state.active_run.party)
    Tracker.state.active_boss_engagements = {}
    Tracker.state.pending_boss_loot_queue = {}
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
        hardcore = existingRun.hardcore == true,
        party = existingRun.party or {},
        replacements = existingRun.replacements or 0,
        deaths = existingRun.deaths or {},
        first_death = existingRun.first_death,
        boss_timer = existingRun.boss_timer or {},
        boss_loot = existingRun.boss_loot or {},
        pending_boss_loot_queue = existingRun.pending_boss_loot_queue or {},
    }

    Tracker.state.last_group_size = getTrackedGroupSize()
    Tracker.state.last_replacement_signature = buildPartyNameSignature(Tracker.state.active_run.party)
    Tracker.state.active_boss_engagements = {}
    Tracker.state.pending_boss_loot_queue = existingRun.pending_boss_loot_queue or {}
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

    if refreshActiveRunPartyLevelsFromLiveGroup() then
        persistActiveRun()
    end

    finalizePendingBossLoot()

    if DungeonOracle.Database and DungeonOracle.Database.CompleteActiveRun then
        DungeonOracle.Database.CompleteActiveRun(time())
    elseif DungeonOracle.Database and DungeonOracle.Database.ClearActiveRun then
        DungeonOracle.Database.ClearActiveRun()
    end

    Tracker.state.active_run = nil
    Tracker.state.active_boss_engagements = {}
    Tracker.state.pending_boss_loot_queue = {}
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
    local hardcore

    if not currentDungeon or not currentDungeon.zone_id or Tracker.state.active_run then
        return false
    end

    startedAt = time()
    runId = createRunId()
    party = collectPartySnapshot()
    hardcore = isCurrentRealmHardcore()

    setActiveRun(runId, currentDungeon.name, startedAt, currentDungeon.zone_id, party, hardcore)
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

    if refreshActiveRunPartyLevelsFromLiveGroup() then
        persistActiveRun()
    end

    finalizePendingBossLoot()

    if DungeonOracle.Database and DungeonOracle.Database.CompleteActiveRun then
        DungeonOracle.Database.CompleteActiveRun(time())
    elseif DungeonOracle.Database and DungeonOracle.Database.ClearActiveRun then
        DungeonOracle.Database.ClearActiveRun()
    end

    Tracker.state.active_run = nil
    Tracker.state.active_boss_engagements = {}
    Tracker.state.pending_boss_loot_queue = {}
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

-- Public: returns the currently active boss timer, if one exists, so the
-- tracker window can show it live.
function Tracker.GetCurrentBossTimer()
    local activeBossEngagements = Tracker.state and Tracker.state.active_boss_engagements or nil
    local bossId
    local startedAt
    local boss

    if not activeBossEngagements then
        return nil
    end

    for bossId, startedAt in pairs(activeBossEngagements) do
        boss = getTrackedBossByNpcId(bossId)

        return {
            boss_id = bossId,
            boss_name = boss and boss.name or tostring(bossId),
            duration = math.max(0, time() - startedAt),
        }
    end

    return nil
end

-- Public: returns the currently pending boss loot-resolution queue so the UI
-- can show its live state.
function Tracker.GetPendingBossQueue()
    local queue = {}
    local pendingBossId
    local boss

    if not Tracker.state or not Tracker.state.pending_boss_loot_queue then
        return queue
    end

    for _, pendingBossId in ipairs(Tracker.state.pending_boss_loot_queue) do
        boss = getTrackedBossByNpcId(pendingBossId)
        queue[#queue + 1] = {
            boss_id = pendingBossId,
            boss_name = boss and boss.name or tostring(pendingBossId),
        }
    end

    return queue
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

    if refreshActiveRunPartyLevelsFromLiveGroup() then
        persistActiveRun()
    end

    finalizePendingBossLoot()

    if DungeonOracle.Database and DungeonOracle.Database.CompleteActiveRun then
        DungeonOracle.Database.CompleteActiveRun(time())
    elseif DungeonOracle.Database and DungeonOracle.Database.ClearActiveRun then
        DungeonOracle.Database.ClearActiveRun()
    end

    Tracker.state.active_run = nil
    Tracker.state.active_boss_engagements = {}
    Tracker.state.pending_boss_loot_queue = {}
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
        Tracker.state.active_boss_engagements = {}
        Tracker.state.pending_boss_loot_queue = {}
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

        if Tracker.state.active_run and isPlayerDeadOrGhost() then
            recordFailedBossEngagementsOnRelease()
        end

        if not instanceInfo and Tracker.state.active_run and not isPlayerDeadOrGhost() then
            beginOutsideInstanceTimeout()
        elseif Tracker.state.active_run and DungeonOracle.UI and DungeonOracle.UI.ShowTrackerWindow then
            DungeonOracle.UI.ShowTrackerWindow()
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
            restorePendingBossLootQueueFromActiveRun()
        end
    end

    updateCurrentDungeon()

    if Tracker.state.active_run then
        if Tracker.state.current_dungeon then
            if not Tracker.state.current_dungeon.zone_id and Tracker.state.active_run.zone_id then
                Tracker.state.current_dungeon.zone_id = Tracker.state.active_run.zone_id
            end

            restorePendingBossLootQueueFromActiveRun()

            if DungeonOracle.UI and DungeonOracle.UI.ShowTrackerWindow then
                DungeonOracle.UI.ShowTrackerWindow()
            end
        elseif not isPlayerDeadOrGhost() then
            beginOutsideInstanceTimeout()

            if DungeonOracle.UI and DungeonOracle.UI.ShowTrackerWindow then
                DungeonOracle.UI.ShowTrackerWindow()
            end
        elseif DungeonOracle.UI and DungeonOracle.UI.ShowTrackerWindow then
            DungeonOracle.UI.ShowTrackerWindow()
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
        if Tracker.state.active_run then
            restorePendingBossLootQueueFromActiveRun()
        end
        completeActiveRunForDungeonTransition()
    elseif event == "GROUP_ROSTER_UPDATE" then
        handleGroupRosterUpdate()
    elseif event == "PLAYER_LEVEL_UP" then
        if Tracker.state.active_run and updatePartyLevelsForLevelUps(Tracker.state.active_run, buildPartySnapshot()) then
            persistActiveRun()
            printMessage("party levels updated after a detected level up.")
        end
    elseif event == "PLAYER_ALIVE" or event == "PLAYER_UNGHOST" then
        if Tracker.state.active_run then
            updateCurrentDungeon()
            restorePendingBossLootQueueFromActiveRun()

            if not Tracker.state.current_dungeon and not Tracker.state.outside_instance_token and not isPlayerDeadOrGhost() then
                beginOutsideInstanceTimeout()

                if DungeonOracle.UI and DungeonOracle.UI.ShowTrackerWindow then
                    DungeonOracle.UI.ShowTrackerWindow()
                end
            end
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
    elseif event == "CHAT_MSG_LOOT" then
        local lootMessage = ...
        recordBossLoot(getItemIdFromLootMessage(lootMessage))
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _, subEvent, _, sourceGUID, _, _, _, destGUID, destName = CombatLogGetCurrentEventInfo()
        local zoneId
        local npcId
        local sourceBoss
        local destBoss

        if canObserveCombatLogZone() and isReliableCombatLogSubEvent(subEvent) then
            zoneId, npcId = getZoneInfoFromGuid(sourceGUID)
            if not observeZoneId(zoneId, npcId, "combat log source GUID") then
                zoneId, npcId = getZoneInfoFromGuid(destGUID)
                observeZoneId(zoneId, npcId, "combat log dest GUID")
            end
        end

        resolveRunForCurrentDungeon()

        _, npcId = getZoneInfoFromGuid(sourceGUID)
        sourceBoss = getTrackedBossByNpcId(npcId)
        _, npcId = getZoneInfoFromGuid(destGUID)
        destBoss = getTrackedBossByNpcId(npcId)

        if subEvent ~= "UNIT_DIED" and subEvent ~= "UNIT_DESTROYED" then
            if sourceBoss then
                recordBossEngagementStart(sourceBoss.id, sourceBoss.name)
            end

            if destBoss then
                recordBossEngagementStart(destBoss.id, destBoss.name)
            end
        end

        if subEvent == "UNIT_DIED" then
            recordPartyDeath(destName)

            if destBoss then
                recordBossEngagementEnd(destBoss.id, destBoss.name)
            end
        end
    end
end
