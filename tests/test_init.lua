-----------------------------------------------------------------------
-- FUA Tests
-- File: test_init.lua
--
-- Tests:
--   * SavedVariables initialization
--   * Runtime setting initialization
--   * Startup method calls
--   * Addon message prefix registration
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Setup
-----------------------------------------------------------------------

dofile("tests/test_runner.lua")
dofile("tests/wow_stubs.lua")

_G.FUA = {}

local addonName = "FUA"
local FUA = _G.FUA

local registeredEvent = nil
local eventHandler = nil
local registeredPrefix = nil

function CreateFrame()
    return {
        RegisterEvent = function(_, event)
            registeredEvent = event
        end,

        SetScript = function(_, scriptName, handler)
            if scriptName == "OnEvent" then
                eventHandler = handler
            end
        end,
    }
end

C_ChatInfo = {
    RegisterAddonMessagePrefix = function(prefix)
        registeredPrefix = prefix
    end,
}

FUA.DEFAULT_OUTPUT_MODE = "char"
FUA.DEFAULT_SYMBOL_COUNT = 5
FUA.DEFAULT_COLLAPSED = false

local calls = {}

FUA.CreateUI = function()
    calls.CreateUI = true
end

FUA.RegisterEncounterEvents = function()
    calls.RegisterEncounterEvents = true
end

FUA.RegisterCommands = function()
    calls.RegisterCommands = true
end

FUA.UpdateDifficulty = function()
    calls.UpdateDifficulty = true
end

FUA.UpdateDisplay = function()
    calls.UpdateDisplay = true
end

local function resetState()
    FUADB = nil
    calls = {}
    registeredEvent = nil
    eventHandler = nil
    registeredPrefix = nil

    FUA.outputMode = nil
    FUA.symbolCount = nil
    FUA.reverseOrder = nil
    FUA.showOnLogin = nil
    FUA.collapsed = nil
end

local function loadInit()
    loadAddonFile("FUA/Core/Init.lua", addonName, FUA)
end

local function fireAddonLoaded(name)
    eventHandler(nil, "ADDON_LOADED", name or addonName)
end

-----------------------------------------------------------------------
-- Tests
-----------------------------------------------------------------------

test("Init registers ADDON_LOADED event", function()
    resetState()

    loadInit()

    assertEqual(registeredEvent, "ADDON_LOADED")
    assertTrue(eventHandler ~= nil)
end)

test("Init ignores other addons", function()
    resetState()

    loadInit()
    fireAddonLoaded("OtherAddon")

    assertNil(FUADB)
    assertNil(FUA.outputMode)
end)

test("Init creates FUADB when missing", function()
    resetState()

    loadInit()
    fireAddonLoaded()

    assertTrue(FUADB ~= nil)
end)

test("Init loads outputMode from SavedVariables", function()
    resetState()

    FUADB = {
        outputMode = "markers",
    }

    loadInit()
    fireAddonLoaded()

    assertEqual(FUA.outputMode, "markers")
end)

test("Init defaults outputMode when missing", function()
    resetState()

    FUADB = {}

    loadInit()
    fireAddonLoaded()

    assertEqual(FUA.outputMode, "char")
end)

test("Init sets default symbolCount", function()
    resetState()

    loadInit()
    fireAddonLoaded()

    assertEqual(FUA.symbolCount, 5)
end)

test("Init loads reverseOrder from SavedVariables", function()
    resetState()

    FUADB = {
        reverseOrder = false,
    }

    loadInit()
    fireAddonLoaded()

    assertEqual(FUA.reverseOrder, false)
end)

test("Init defaults reverseOrder to true when nil", function()
    resetState()

    FUADB = {}

    loadInit()
    fireAddonLoaded()

    assertEqual(FUA.reverseOrder, true)
end)

test("Init loads showOnLogin true only when true", function()
    resetState()

    FUADB = {
        showOnLogin = true,
    }

    loadInit()
    fireAddonLoaded()

    assertEqual(FUA.showOnLogin, true)
end)

test("Init defaults showOnLogin to false", function()
    resetState()

    FUADB = {}

    loadInit()
    fireAddonLoaded()

    assertEqual(FUA.showOnLogin, false)
end)

test("Init calls startup methods", function()
    resetState()

    loadInit()
    fireAddonLoaded()

    assertTrue(calls.CreateUI)
    assertTrue(calls.RegisterEncounterEvents)
    assertTrue(calls.RegisterCommands)
    assertTrue(calls.UpdateDifficulty)
    assertTrue(calls.UpdateDisplay)
end)

test("Init registers addon message prefix", function()
    resetState()

    loadInit()
    fireAddonLoaded()

    assertEqual(registeredPrefix, "FUA")
end)

test("Init loads collapsed from SavedVariables", function()
    resetState()

    FUADB = {
        collapsed = true,
    }

    loadInit()
    fireAddonLoaded()

    assertEqual(FUA.collapsed, true)
end)

test("Init defaults collapsed to false", function()
    resetState()

    FUADB = {}

    loadInit()
    fireAddonLoaded()

    assertEqual(FUA.collapsed, false)
end)

-----------------------------------------------------------------------
-- Execute
-----------------------------------------------------------------------

runTests()
