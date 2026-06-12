-----------------------------------------------------------------------
-- FUA Tests
-- File: test_commands.lua
--
-- Tests:
--   * Slash command registration
--   * Show command
--   * Hide command
--   * Clear command
--   * Default toggle behavior
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Setup
-----------------------------------------------------------------------

dofile("tests/test_runner.lua")
dofile("tests/wow_stubs.lua")

_G.FUA = {}
SlashCmdList = {}

local addonName = "FUA"
local FUA = _G.FUA

loadAddonFile("FUA/Core/Commands.lua", addonName, FUA)

local frameShown = false
local clearCalled = false

FUA.frame = {
    Show = function()
        frameShown = true
    end,

    Hide = function()
        frameShown = false
    end,

    SetShown = function(_, shown)
        frameShown = shown
    end,

    IsShown = function()
        return frameShown
    end,
}

FUA.ClearOrder = function()
    clearCalled = true
end

local function resetState()
    frameShown = false
    clearCalled = false
    SLASH_FUA1 = nil
    SLASH_FUADEBUG1 = nil
    SlashCmdList = {}
end

local function register()
    FUA:RegisterCommands()
end

-----------------------------------------------------------------------
-- Tests
-----------------------------------------------------------------------

test("RegisterCommands registers slash command", function()
    resetState()

    register()

    assertEqual(SLASH_FUA1, "/fua")
    assertTrue(SlashCmdList["FUA"] ~= nil)
end)

test("Slash command show displays frame", function()
    resetState()
    register()

    SlashCmdList["FUA"]("show")

    assertEqual(frameShown, true)
end)

test("Slash command hide hides frame", function()
    resetState()
    frameShown = true
    register()

    SlashCmdList["FUA"]("hide")

    assertEqual(frameShown, false)
end)

test("Slash command clear clears order", function()
    resetState()
    register()

    SlashCmdList["FUA"]("clear")

    assertEqual(clearCalled, true)
end)

test("Slash command default toggles frame on", function()
    resetState()
    register()

    SlashCmdList["FUA"]("")

    assertEqual(frameShown, true)
end)

test("Slash command unknown toggles frame on", function()
    resetState()
    register()

    SlashCmdList["FUA"]("banana")

    assertEqual(frameShown, true)
end)

test("Slash command is case insensitive", function()
    resetState()
    register()

    SlashCmdList["FUA"]("SHOW")

    assertEqual(frameShown, true)
end)

-----------------------------------------------------------------------
-- Execute
-----------------------------------------------------------------------

runTests()
