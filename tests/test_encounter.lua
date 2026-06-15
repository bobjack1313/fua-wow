-----------------------------------------------------------------------
-- FUA Tests
-- File: test_encounter.lua
--
-- Tests:
--   * Difficulty detection
--   * Symbol count selection
--   * Encounter active state
--   * Import priority reset
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Setup
-----------------------------------------------------------------------

dofile("tests/test_runner.lua")
dofile("tests/wow_stubs.lua")

_G.FUA = {}

local addonName = "FUA"
local FUA = _G.FUA

local currentDifficultyID = 0
local registeredEvents = {}
local eventHandler = nil

function GetInstanceInfo()
    return nil, "raid", currentDifficultyID, nil, nil, nil, nil, 2913
end

function CreateFrame()
    return {
        RegisterEvent = function(_, event)
            registeredEvents[event] = true
        end,
        SetScript = function(_, scriptName, handler)
            if scriptName == "OnEvent" then
                eventHandler = handler
            end
        end,
    }
end

loadAddonFile("FUA/Core/Colors.lua", addonName, FUA)
loadAddonFile("FUA/Core/Locales/enUS.lua", addonName, FUA)
loadAddonFile("FUA/Core/Locale.lua", addonName, FUA)
loadAddonFile("FUA/Modules/Encounters/MFQ/MF/Data.lua", addonName, FUA)
loadAddonFile("FUA/Modules/Encounters/MFQ/MF/Encounter.lua", addonName, FUA)

FUA.UpdateChatButtonText = function() end
FUA.UpdateDisplay = function() end
FUA.ClearOrder = function() end
FUA.ShowInstanceReminder = function() end
FUA.frame = {
    IsShown = function() return false end,
    Show = function() end,
}

local function resetState()
    currentDifficultyID = 0
    registeredEvents = {}
    eventHandler = nil

    FUA.symbolCount = 0
    FUA.difficultyName = nil
    FUA.isEncounterActive = false
    FUA.currentImportPriority = 99
    FUA_DEBUG_DIFFICULTY = nil
end

-----------------------------------------------------------------------
-- Tests
-----------------------------------------------------------------------

test("UpdateDifficulty sets LFR to three symbols", function()
    resetState()

    currentDifficultyID = 17
    FUA:UpdateDifficulty()

    assertEqual(FUA.symbolCount, 3)
    assertEqual(FUA.difficultyName, FUA.L.DIFFICULTY_LFR)
end)

test("UpdateDifficulty sets Normal to three symbols", function()
    resetState()

    currentDifficultyID = 14
    FUA:UpdateDifficulty()

    assertEqual(FUA.symbolCount, 3)
    assertEqual(FUA.difficultyName, FUA.L.DIFFICULTY_NORMAL)
end)

test("UpdateDifficulty sets Heroic to five symbols", function()
    resetState()

    currentDifficultyID = 15
    FUA:UpdateDifficulty()

    assertEqual(FUA.symbolCount, 5)
    assertEqual(FUA.difficultyName, FUA.L.DIFFICULTY_HEROIC)
end)

test("UpdateDifficulty sets Mythic to five symbols", function()
    resetState()

    currentDifficultyID = 16
    FUA:UpdateDifficulty()

    assertEqual(FUA.symbolCount, 5)
    assertEqual(FUA.difficultyName, FUA.L.DIFFICULTY_MYTHIC)
end)

test("UpdateDifficulty defaults unknown difficulty to Outside Raid", function()
    resetState()

    currentDifficultyID = 0
    FUA:UpdateDifficulty()

    assertEqual(FUA.symbolCount, 3)
    assertEqual(FUA.difficultyName, FUA.L.DIFFICULTY_OUTSIDE_RAID)
end)

test("RegisterEncounterEvents registers expected events", function()
    resetState()

    FUA:RegisterEncounterEvents()

    assertTrue(registeredEvents["PLAYER_ENTERING_WORLD"])
    assertTrue(registeredEvents["GROUP_ROSTER_UPDATE"])
    assertTrue(registeredEvents["ZONE_CHANGED_NEW_AREA"])
    assertTrue(registeredEvents["PLAYER_DIFFICULTY_CHANGED"])
    assertTrue(registeredEvents["ENCOUNTER_START"])
    assertTrue(registeredEvents["ENCOUNTER_END"])
end)

test("ENCOUNTER_START activates Midnight Falls encounter", function()
    resetState()

    FUA:RegisterEncounterEvents()
    eventHandler(nil, "ENCOUNTER_START", FUA.MIDNIGHT_FALLS_ENCOUNTER_ID)

    assertTrue(FUA.isEncounterActive)
    assertEqual(FUA.currentImportPriority, 0)
end)

test("ENCOUNTER_START ignores other encounters", function()
    resetState()

    FUA:RegisterEncounterEvents()
    eventHandler(nil, "ENCOUNTER_START", 9999)

    assertEqual(FUA.isEncounterActive, false)
    assertEqual(FUA.currentImportPriority, 99)
end)

test("ENCOUNTER_END deactivates Midnight Falls encounter", function()
    resetState()

    FUA.isEncounterActive = true

    FUA:RegisterEncounterEvents()
    eventHandler(nil, "ENCOUNTER_END", FUA.MIDNIGHT_FALLS_ENCOUNTER_ID)

    assertEqual(FUA.isEncounterActive, false)
    assertEqual(FUA.currentImportPriority, 0)
end)

test("PLAYER_ENTERING_WORLD resets encounter state", function()
    resetState()

    FUA.isEncounterActive = true
    FUA.currentImportPriority = 3

    FUA:RegisterEncounterEvents()
    eventHandler(nil, "PLAYER_ENTERING_WORLD")

    assertEqual(FUA.isEncounterActive, false)
    assertEqual(FUA.currentImportPriority, 0)
end)

-----------------------------------------------------------------------
-- Execute
-----------------------------------------------------------------------

runTests()
