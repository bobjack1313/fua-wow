-----------------------------------------------------------------------
-- FUA Tests
-- File: test_chat.lua
--
-- Tests:
--   * Chat prefix selection
--   * Prepared message handling
--   * Empty order rejection
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Setup
-----------------------------------------------------------------------

dofile("tests/test_runner.lua")
dofile("tests/wow_stubs.lua")

_G.FUA = {}

local addonName = "FUA"
local FUA = _G.FUA

local openedChatText = nil

function ChatFrame_OpenChat(text)
    openedChatText = text
end

local inInstanceGroup = false
local inRaid = false
local inGroup = false
local isLeader = false
local isAssistant = false

function IsInGroup(category)
    if category == LE_PARTY_CATEGORY_INSTANCE then
        return inInstanceGroup
    end

    return inGroup
end

function IsInRaid()
    return inRaid
end

function UnitIsGroupLeader()
    return isLeader
end

function UnitIsGroupAssistant()
    return isAssistant
end

FUA.IsProtectedCombat = function()
    return false
end

LE_PARTY_CATEGORY_INSTANCE = 2

loadAddonFile("FUA/Core/Colors.lua", addonName, FUA)
loadAddonFile("FUA/Core/Locales/enUS.lua", addonName, FUA)
loadAddonFile("FUA/Core/Locale.lua", addonName, FUA)
loadAddonFile("FUA/Modules/Encounters/MFQ/MF/Data.lua", addonName, FUA)
loadAddonFile("FUA/Modules/Encounters/MFQ/MF/Order.lua", addonName, FUA)
loadAddonFile("FUA/Services/Chat.lua", addonName, FUA)

FUA.UpdateDisplay = function() end
FUA.UpdateDifficulty = function() end

local broadcastCalled = false

FUA.BroadcastAssignment = function()
    broadcastCalled = true
end

local function resetState()
    FUA.order = {}
    FUA.symbolCount = 3
    FUA.outputMode = "char"
    FUA.reverseOrder = false

    chatOpened = false
    openedChatText = nil
    inInstanceGroup = false
    broadcastCalled = false
    inRaid = false
    inGroup = false
    isLeader = false
    isAssistant = false
    FUA.IsProtectedCombat = function()
        return false
    end
end

-----------------------------------------------------------------------
-- Tests
-----------------------------------------------------------------------

test("GetChatPrefix returns instance prefix in instance group", function()
    resetState()

    inInstanceGroup = true

    assertEqual(FUA:GetChatPrefix(), "/instance FUA:  ")
end)

test("GetChatPrefix returns raid warning for raid leader", function()
    resetState()

    inRaid = true
    inGroup = true
    isLeader = true

    assertEqual(FUA:GetChatPrefix(), "/rw FUA:  ")
end)

test("GetChatPrefix returns raid warning for raid assistant", function()
    resetState()

    inRaid = true
    inGroup = true
    isAssistant = true

    assertEqual(FUA:GetChatPrefix(), "/rw FUA:  ")
end)

test("GetChatPrefix returns raid for raid member", function()
    resetState()

    inRaid = true
    inGroup = true

    assertEqual(FUA:GetChatPrefix(), "/raid FUA:  ")
end)

test("GetChatPrefix returns party for party member", function()
    resetState()

    inGroup = true

    assertEqual(FUA:GetChatPrefix(), "/party FUA:  ")
end)

test("GetChatPrefix returns say when solo", function()
    resetState()

    assertEqual(FUA:GetChatPrefix(), "/say FUA:  ")
end)

test("OpenRaidChat opens prepared message", function()
    resetState()

    FUA.order = {
        { char = "X", marker = "{rt7}" },
        { char = "V", marker = "{rt4}" },
        { char = "D", marker = "{rt3}" },
    }

    FUA:OpenRaidChat()

    assertEqual(broadcastCalled, true)
end)

test("OpenRaidChat respects reverse order", function()
    resetState()

    FUA.IsProtectedCombat = function()
        return true
    end

    FUA.reverseOrder = true

    FUA:AddSymbol(FUA.symbols[1])
    FUA:AddSymbol(FUA.symbols[2])
    FUA:AddSymbol(FUA.symbols[3])

    FUA:OpenRaidChat()

    assertEqual(openedChatText, "/say FUA:  [ D ]    [ V ]    [ X ]")
end)

test("OpenRaidChat does not open chat for empty order", function()
    resetState()

    FUA:OpenRaidChat()

    assertNil(openedChatText)
end)

test("OpenRaidChat opens chat during protected combat", function()
    resetState()

    FUA.IsProtectedCombat = function()
        return true
    end

    FUA.BroadcastAssignment = function()
        broadcastCalled = true
    end

    FUA.GetPreparedMessageOrderString = function()
        return "[ X ] [ V ] [ T ]"
    end

    FUA:OpenRaidChat()

    assertEqual(FUA:IsProtectedCombat(), true)
    assertEqual(FUA:GetPreparedMessageOrderString(), "[ X ] [ V ] [ T ]")
    assertEqual(broadcastCalled, false)
end)

-----------------------------------------------------------------------
-- Execute
-----------------------------------------------------------------------

runTests()
