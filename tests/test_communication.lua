-----------------------------------------------------------------------
-- FUA Tests
-- File: test_communication.lua
--
-- Tests:
--   * Symbol token lookup
--   * Chat assignment parsing
--   * Invalid message rejection
--   * Assignment import priority
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Setup
-----------------------------------------------------------------------

dofile("tests/test_runner.lua")
dofile("tests/wow_stubs.lua")

_G.FUA = {}

local addonName = "FUA"
local FUA = _G.FUA

loadAddonFile("FUA/Core/Colors.lua", addonName, FUA)
loadAddonFile("FUA/Core/Locales/enUS.lua", addonName, FUA)
loadAddonFile("FUA/Core/Locale.lua", addonName, FUA)
loadAddonFile("FUA/Modules/Encounters/MFQ/MF/Data.lua", addonName, FUA)
loadAddonFile("FUA/Modules/Encounters/MFQ/MF/Order.lua", addonName, FUA)
loadAddonFile("FUA/Services/Communication.lua", addonName, FUA)

FUA.UpdateDisplay = function() end

FUA.symbolCount = 3
FUA.isEncounterActive = true

-----------------------------------------------------------------------
-- Tests
-----------------------------------------------------------------------

test("ParseChatAssignment parses character output", function()
    local parsed = FUA:ParseChatAssignment("FUA: [ <> ]    [ V ]    [ X ]")

    assertEqual(#parsed, 3)
    assertEqual(parsed[1].char, "<>")
    assertEqual(parsed[2].char, "V")
    assertEqual(parsed[3].char, "X")
end)

test("ParseChatAssignment parses marker output", function()
    local parsed = FUA:ParseChatAssignment("FUA: [ {rt3} ]    [ {rt4} ]    [ {rt7} ]")

    assertEqual(#parsed, 3)
    assertEqual(parsed[1].marker, "{rt3}")
    assertEqual(parsed[2].marker, "{rt4}")
    assertEqual(parsed[3].marker, "{rt7}")
end)

test("ParseChatAssignment rejects missing prefix", function()
    local parsed = FUA:ParseChatAssignment("[ <> ] [ V ] [ X ]")

    assertNil(parsed)
end)

test("ParseChatAssignment rejects wrong symbol count", function()
    local parsed = FUA:ParseChatAssignment("FUA: [ <> ] [ V ]")

    assertNil(parsed)
end)

test("ImportAssignment allows equal priority override", function()
    local first = FUA:ParseChatAssignment("FUA: [ <> ] [ V ] [ X ]")
    local second = FUA:ParseChatAssignment("FUA: [ X ] [ V ] [ <> ]")

    FUA.currentImportPriority = 2
    FUA:ImportAssignment(first, 2)
    FUA:ImportAssignment(second, 2)

    assertEqual(FUA.order[1].char, "X")
end)

test("ImportAssignment rejects lower priority override", function()
    local first = FUA:ParseChatAssignment("FUA: [ <> ] [ V ] [ X ]")
    local second = FUA:ParseChatAssignment("FUA: [ X ] [ V ] [ <> ]")

    FUA.currentImportPriority = 0
    FUA:ImportAssignment(first, 3)
    FUA:ImportAssignment(second, 2)

    assertEqual(FUA.order[1].char, "<>")
end)

test("HandleChatAssignment ignores messages from player", function()
    FUA.order = {}
    FUA.symbolCount = 3
    FUA.isEncounterActive = true
    FUA.currentImportPriority = 0

    FUA:HandleChatAssignment(
        "CHAT_MSG_RAID",
        "FUA: [ <> ] [ V ] [ X ]",
        "Player"
    )

    assertEqual(#FUA.order, 0)
end)

test("HandleChatAssignment imports messages from other players", function()
    FUA.order = {}
    FUA.symbolCount = 3
    FUA.isEncounterActive = true
    FUA.currentImportPriority = 0

    FUA:HandleChatAssignment(
        "CHAT_MSG_RAID",
        "FUA: [ <> ] [ V ] [ X ]",
        "Otherplayer"
    )

    assertEqual(#FUA.order, 3)
    assertEqual(FUA.order[1].char, "<>")
end)

test("HandleChatAssignment ignores messages outside encounter", function()
    FUA.order = {}
    FUA.symbolCount = 3
    FUA.isEncounterActive = false
    FUA.currentImportPriority = 0

    FUA:HandleChatAssignment(
        "CHAT_MSG_RAID",
        "FUA: [ <> ] [ V ] [ X ]",
        "Otherplayer"
    )

    assertEqual(#FUA.order, 0)
end)

test("HandleChatAssignment ignores unsupported channels", function()
    FUA.order = {}
    FUA.symbolCount = 3
    FUA.isEncounterActive = true
    FUA.currentImportPriority = 0

    FUA:HandleChatAssignment(
        "CHAT_MSG_GUILD",
        "FUA: [ <> ] [ V ] [ X ]",
        "Otherplayer"
    )

    assertEqual(#FUA.order, 0)
end)

test("Raid warning overrides raid assignment", function()
    FUA.order = {}
    FUA.symbolCount = 3
    FUA.isEncounterActive = true
    FUA.currentImportPriority = 0

    FUA:HandleChatAssignment(
        "CHAT_MSG_RAID",
        "FUA: [ <> ] [ V ] [ X ]",
        "PlayerA"
    )

    FUA:HandleChatAssignment(
        "CHAT_MSG_RAID_WARNING",
        "FUA: [ X ] [ V ] [ <> ]",
        "PlayerB"
    )

    assertEqual(FUA.order[1].char, "X")
end)

test("Raid cannot override raid warning", function()
    FUA.order = {}
    FUA.symbolCount = 3
    FUA.isEncounterActive = true
    FUA.currentImportPriority = 0

    FUA:HandleChatAssignment(
        "CHAT_MSG_RAID_WARNING",
        "FUA: [ X ] [ V ] [ <> ]",
        "PlayerA"
    )

    FUA:HandleChatAssignment(
        "CHAT_MSG_RAID",
        "FUA: [ <> ] [ V ] [ X ]",
        "PlayerB"
    )

    assertEqual(FUA.order[1].char, "X")
end)

test("Raid warning overrides previous raid warning", function()
    FUA.order = {}
    FUA.symbolCount = 3
    FUA.isEncounterActive = true
    FUA.currentImportPriority = 0

    FUA:HandleChatAssignment(
        "CHAT_MSG_RAID_WARNING",
        "FUA: [ <> ] [ V ] [ X ]",
        "Leader"
    )

    FUA:HandleChatAssignment(
        "CHAT_MSG_RAID_WARNING",
        "FUA: [ X ] [ V ] [ <> ]",
        "Leader"
    )

    assertEqual(FUA.order[1].char, "X")
end)

-----------------------------------------------------------------------
-- Execute
-----------------------------------------------------------------------

runTests()

