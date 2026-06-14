-----------------------------------------------------------------------
-- FUA Tests
-- File: test_communication.lua
--
-- Tests:
--   * Symbol token lookup
--   * Assignment parsing
--   * Assignment import priority
--   * Addon message receive/import
--   * Addon message broadcast
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Setup
-----------------------------------------------------------------------

dofile("tests/test_runner.lua")
dofile("tests/wow_stubs.lua")

_G.FUA = {}

local addonName = "FUA"
local FUA = _G.FUA

local sentAddonMessage = nil

C_ChatInfo = C_ChatInfo or {}

C_ChatInfo.SendAddonMessage = function(prefix, message, channel, target)
    sentAddonMessage = {
        prefix = prefix,
        message = message,
        channel = channel,
        target = target,
    }

    return 0
end

loadAddonFile("FUA/Core/Colors.lua", addonName, FUA)
loadAddonFile("FUA/Core/Locales/enUS.lua", addonName, FUA)
loadAddonFile("FUA/Core/Locale.lua", addonName, FUA)
loadAddonFile("FUA/Modules/Encounters/MFQ/MF/Data.lua", addonName, FUA)
loadAddonFile("FUA/Modules/Encounters/MFQ/MF/Order.lua", addonName, FUA)
loadAddonFile("FUA/Services/Communication.lua", addonName, FUA)

FUA.UpdateDisplay = function() end
FUA.DEBUG_COMMS = false
FUA.UpdateDifficulty = function() end
FUA.DEBUG_COMMS = false

local function resetState()
    FUA.order = {}
    FUA.symbolCount = 3
    FUA.outputMode = "char"
    FUA.currentImportPriority = 0
    sentAddonMessage = nil
    FUA.isEncounterActive = true
end

-----------------------------------------------------------------------
-- Tests
-----------------------------------------------------------------------

test("ParseChatAssignment parses character output", function()
    resetState()

    local parsed = FUA:ParseChatAssignment("FUA: [ <> ]    [ V ]    [ X ]")

    assertEqual(#parsed, 3)
    assertEqual(parsed[1].char, "<>")
    assertEqual(parsed[2].char, "V")
    assertEqual(parsed[3].char, "X")
end)

test("ParseChatAssignment parses marker output", function()
    resetState()

    local parsed = FUA:ParseChatAssignment("FUA: [ {rt3} ]    [ {rt4} ]    [ {rt7} ]")

    assertEqual(#parsed, 3)
    assertEqual(parsed[1].marker, "{rt3}")
    assertEqual(parsed[2].marker, "{rt4}")
    assertEqual(parsed[3].marker, "{rt7}")
end)

test("ParseChatAssignment rejects missing prefix", function()
    resetState()

    local parsed = FUA:ParseChatAssignment("[ <> ] [ V ] [ X ]")

    assertNil(parsed)
end)

test("ParseChatAssignment rejects wrong symbol count", function()
    resetState()

    local parsed = FUA:ParseChatAssignment("FUA: [ <> ] [ V ]")

    assertNil(parsed)
end)

test("ImportAssignment allows equal priority override", function()
    resetState()

    local first = FUA:ParseChatAssignment("FUA: [ <> ] [ V ] [ X ]")
    local second = FUA:ParseChatAssignment("FUA: [ X ] [ V ] [ <> ]")

    FUA.currentImportPriority = 2
    FUA:ImportAssignment(first, 2)
    FUA:ImportAssignment(second, 2)

    assertEqual(FUA.order[1].char, "X")
end)

test("ImportAssignment rejects lower priority override", function()
    resetState()

    local first = FUA:ParseChatAssignment("FUA: [ <> ] [ V ] [ X ]")
    local second = FUA:ParseChatAssignment("FUA: [ X ] [ V ] [ <> ]")

    FUA.currentImportPriority = 0
    FUA:ImportAssignment(first, 3)
    FUA:ImportAssignment(second, 2)

    assertEqual(FUA.order[1].char, "<>")
end)

test("HandleAddonMessage ignores other prefixes", function()
    resetState()

    FUA:HandleAddonMessage(
        "OTHER",
        "[ X ] [ V ] [ <> ]",
        "RAID",
        "PlayerA"
    )

    assertEqual(#FUA.order, 0)
end)

test("HandleAddonMessage imports FUA character payload", function()
    resetState()

    FUA:HandleAddonMessage(
        "FUA",
        "[ X ] [ V ] [ <> ]",
        "RAID",
        "PlayerA"
    )

    assertEqual(#FUA.order, 3)
    assertEqual(FUA.order[1].char, "X")
    assertEqual(FUA.order[2].char, "V")
    assertEqual(FUA.order[3].char, "<>")
end)

test("HandleAddonMessage imports FUA marker payload", function()
    resetState()

    FUA.outputMode = "markers"

    FUA:HandleAddonMessage(
        "FUA",
        "[ {rt7} ] [ {rt4} ] [ {rt3} ]",
        "RAID",
        "PlayerA"
    )

    assertEqual(#FUA.order, 3)
    assertEqual(FUA.order[1].marker, "{rt7}")
    assertEqual(FUA.order[2].marker, "{rt4}")
    assertEqual(FUA.order[3].marker, "{rt3}")
end)

test("HandleAddonMessage rejects invalid payload", function()
    resetState()

    FUA:HandleAddonMessage(
        "FUA",
        "[ X ] [ BAD ] [ <> ]",
        "RAID",
        "PlayerA"
    )

    assertEqual(#FUA.order, 0)
end)

test("BroadcastAssignment sends addon message", function()
    resetState()

    IsInGroup = function(category)
        return category == LE_PARTY_CATEGORY_INSTANCE
    end

    IsInRaid = function()
        return false
    end

    FUA:AddSymbol(FUA.symbols[1]) -- X
    FUA:AddSymbol(FUA.symbols[2]) -- V
    FUA:AddSymbol(FUA.symbols[3]) -- <>

    FUA:BroadcastAssignment()

    assertEqual(sentAddonMessage.prefix, "FUA")
    assertEqual(sentAddonMessage.message, "[ X ]    [ V ]    [ <> ]")
    assertEqual(sentAddonMessage.channel, "INSTANCE_CHAT")
end)

test("BroadcastAssignment whispers self when solo", function()
    resetState()

    IsInGroup = function()
        return false
    end

    IsInRaid = function()
        return false
    end

    UnitName = function()
        return "PlayerA"
    end

    FUA:AddSymbol(FUA.symbols[1])
    FUA:AddSymbol(FUA.symbols[2])
    FUA:AddSymbol(FUA.symbols[3])

    FUA:BroadcastAssignment()

    assertEqual(sentAddonMessage.prefix, "FUA")
    assertEqual(sentAddonMessage.channel, "WHISPER")
    assertEqual(sentAddonMessage.target, "PlayerA")
end)

-----------------------------------------------------------------------
-- Execute
-----------------------------------------------------------------------

runTests()
