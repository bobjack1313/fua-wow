-----------------------------------------------------------------------
-- FUA Tests
-- File: test_order.lua
--
-- Tests:
--   * Symbol insertion
--   * Duplicate prevention
--   * Symbol limit enforcement
--   * Undo behavior
--   * Clear behavior
--   * Display/chat string formatting
--   * Strategy order reversal
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Setup
-----------------------------------------------------------------------

dofile("tests/test_runner.lua")
dofile("tests/wow_stubs.lua")

_G.FUA = {}

local addonName = "FUA"
local FUA = _G.FUA

loadAddonFile("FUA/Data.lua", addonName, FUA)
loadAddonFile("FUA/Order.lua", addonName, FUA)

FUA.UpdateDisplay = function() end
FUA.UpdateDifficulty = function() end

local function resetState()
    FUA.order = {}
    FUA.symbolCount = 3
    FUA.outputMode = "char"
    FUA.reverseOrder = false
end

-----------------------------------------------------------------------
-- Test Data
-----------------------------------------------------------------------

local X = FUA.symbols[1]
local V = FUA.symbols[2]
local DIAMOND = FUA.symbols[3]
local T = FUA.symbols[4]
local O = FUA.symbols[5]

-----------------------------------------------------------------------
-- Tests
-----------------------------------------------------------------------

test("AddSymbol adds symbol", function()
    resetState()

    FUA:AddSymbol(X)

    assertEqual(#FUA.order, 1)
    assertEqual(FUA.order[1].char, "X")
end)

test("AddSymbol rejects duplicate symbols", function()
    resetState()

    FUA:AddSymbol(X)
    FUA:AddSymbol(X)

    assertEqual(#FUA.order, 1)
    assertEqual(FUA.order[1].char, "X")
end)

test("AddSymbol respects symbolCount limit", function()
    resetState()

    FUA:AddSymbol(X)
    FUA:AddSymbol(V)
    FUA:AddSymbol(DIAMOND)
    FUA:AddSymbol(T)

    assertEqual(#FUA.order, 3)
    assertEqual(FUA.order[1].char, "X")
    assertEqual(FUA.order[2].char, "V")
    assertEqual(FUA.order[3].char, "<>")
end)

test("UndoLast removes most recent symbol", function()
    resetState()

    FUA:AddSymbol(X)
    FUA:AddSymbol(V)

    FUA:UndoLast()

    assertEqual(#FUA.order, 1)
    assertEqual(FUA.order[1].char, "X")
end)

test("UndoLast on empty order does not error", function()
    resetState()

    FUA:UndoLast()

    assertEqual(#FUA.order, 0)
end)

test("ClearOrder removes all symbols", function()
    resetState()

    FUA:AddSymbol(X)
    FUA:AddSymbol(V)
    FUA:AddSymbol(DIAMOND)

    FUA:ClearOrder()

    assertEqual(#FUA.order, 0)
end)

test("GetDisplayOrderString returns input order in char mode", function()
    resetState()

    FUA:AddSymbol(X)
    FUA:AddSymbol(V)
    FUA:AddSymbol(DIAMOND)

    assertEqual(FUA:GetDisplayOrderString(), "[ X ]    [ V ]    [ <> ]")
end)

test("GetChatOrderString returns strategy order when not reversed", function()
    resetState()

    FUA.reverseOrder = false

    FUA:AddSymbol(X)
    FUA:AddSymbol(V)
    FUA:AddSymbol(DIAMOND)

    assertEqual(FUA:GetChatOrderString(), "[ X ]    [ V ]    [ <> ]")
end)

test("GetChatOrderString returns reversed strategy order when reversed", function()
    resetState()

    FUA.reverseOrder = true

    FUA:AddSymbol(X)
    FUA:AddSymbol(V)
    FUA:AddSymbol(DIAMOND)

    assertEqual(FUA:GetChatOrderString(), "[ <> ]    [ V ]    [ X ]")
end)

test("GetPreparedMessageOrderString returns input order when not reversed", function()
    resetState()

    FUA.reverseOrder = false

    FUA:AddSymbol(X)
    FUA:AddSymbol(V)
    FUA:AddSymbol(DIAMOND)

    assertEqual(FUA:GetPreparedMessageOrderString(), "[ X ]    [ V ]    [ <> ]")
end)

test("GetPreparedMessageOrderString returns reversed order when reversed", function()
    resetState()

    FUA.reverseOrder = true

    FUA:AddSymbol(X)
    FUA:AddSymbol(V)
    FUA:AddSymbol(DIAMOND)

    assertEqual(FUA:GetPreparedMessageOrderString(), "[ <> ]    [ V ]    [ X ]")
end)

test("GetStrategyOrderedSymbols returns input order when not reversed", function()
    resetState()

    FUA.reverseOrder = false

    FUA:AddSymbol(X)
    FUA:AddSymbol(V)
    FUA:AddSymbol(DIAMOND)

    local ordered = FUA:GetStrategyOrderedSymbols()

    assertEqual(#ordered, 3)
    assertEqual(ordered[1].char, "X")
    assertEqual(ordered[2].char, "V")
    assertEqual(ordered[3].char, "<>")
end)

test("GetStrategyOrderedSymbols returns reversed order when reversed", function()
    resetState()

    FUA.reverseOrder = true

    FUA:AddSymbol(X)
    FUA:AddSymbol(V)
    FUA:AddSymbol(DIAMOND)

    local ordered = FUA:GetStrategyOrderedSymbols()

    assertEqual(#ordered, 3)
    assertEqual(ordered[1].char, "<>")
    assertEqual(ordered[2].char, "V")
    assertEqual(ordered[3].char, "X")
end)

test("GetChatSymbolText uses marker format in marker mode", function()
    resetState()

    FUA.outputMode = "markers"

    assertEqual(FUA:GetChatSymbolText(X), "[ {rt7} ]")
end)

test("GetSymbolText uses char format in char mode", function()
    resetState()

    FUA.outputMode = "char"

    assertEqual(FUA:GetSymbolText(X), "X")
end)

test("GetSymbolText uses marker format in marker mode", function()
    resetState()

    FUA.outputMode = "markers"

    assertEqual(FUA:GetSymbolText(X), "{rt7}")
end)

-----------------------------------------------------------------------
-- Execute
-----------------------------------------------------------------------

runTests()
