dofile("tests/test_runner.lua")
dofile("tests/wow_stubs.lua")

_G.FUA = {}

local addonName = "FUA"
local FUA = _G.FUA

FUA.Colors = {
    CROSS = {},
    TRIANGLE = {},
    DIAMOND = {},
    TEE = {},
    CIRCLE = {},
}

FUA.L = {
    ERR_SYMBOL_EXISTS = "Symbol already selected.",
    ERR_SYMBOL_LIMIT = "Symbol limit reached.",
    MSG_IMPORTED = "Assignment imported from chat.",
}

function FUA:PrintError() end
function FUA:PrintSuccess() end
function FUA:UpdateDifficulty() end
function FUA:UpdateDisplay() end

loadAddonFile("FUA/Core/Colors.lua", addonName, FUA)
loadAddonFile("FUA/Core/Locales/enUS.lua", addonName, FUA)
loadAddonFile("FUA/Core/Locale.lua", addonName, FUA)
loadAddonFile("FUA/Modules/Encounters/MFQ/MF/Data.lua", addonName, FUA)
loadAddonFile("FUA/Modules/Encounters/MFQ/MF/Order.lua", addonName, FUA)
loadAddonFile("FUA/Services/Communication.lua", addonName, FUA)

local function resetState()
    FUA.order = {}
    FUA.symbolCount = 5
    FUA.outputMode = "char"
    FUA.reverseOrder = true
    FUA.currentImportPriority = 0
end

local function labelString(symbols)
    local result = {}

    for i, symbol in ipairs(symbols) do
        result[i] = symbol.label
    end

    return table.concat(result, ",")
end

local function currentOrderLabels()
    return labelString(FUA.order)
end

-----------------------------------------------------------------------
-- Tests
-----------------------------------------------------------------------

test("Prepared chat output matches diagram order and parser round-trips", function()
    resetState()

    FUA:AddSymbol(FUA.symbols[1]) -- X
    FUA:AddSymbol(FUA.symbols[2]) -- V
    FUA:AddSymbol(FUA.symbols[3]) -- <>
    FUA:AddSymbol(FUA.symbols[4]) -- T
    FUA:AddSymbol(FUA.symbols[5]) -- O

    assertEqual(currentOrderLabels(), "X,V,<>,T,O")

    local displayInputString = FUA:GetDisplayOrderString()
    assertEqual(displayInputString, "[ X ]    [ V ]    [ <> ]    [ T ]    [ O ]")

    local diagramSymbols = FUA:GetStrategyOrderedSymbols()
    assertEqual(labelString(diagramSymbols), "O,T,<>,V,X")

    local preparedMessage = FUA:GetPreparedMessageOrderString()
    assertEqual(preparedMessage, "[ O ]    [ T ]    [ <> ]    [ V ]    [ X ]")

    local parsed = FUA:ParseChatAssignment("FUA:  " .. preparedMessage)

    assertTrue(parsed ~= nil)
    assertEqual(labelString(parsed), labelString(diagramSymbols))

    FUA:ImportAssignment(parsed, 3)

    assertEqual(currentOrderLabels(), labelString(diagramSymbols))
end)

test("Diagram slot order matches stored order", function()

    resetState()

    FUA:AddSymbol(FUA.symbols[1]) -- X
    FUA:AddSymbol(FUA.symbols[2]) -- V
    FUA:AddSymbol(FUA.symbols[3]) -- <>
    FUA:AddSymbol(FUA.symbols[4]) -- T
    FUA:AddSymbol(FUA.symbols[5]) -- O

    assertEqual(FUA.order[1].label, "X")
    assertEqual(FUA.order[2].label, "V")
    assertEqual(FUA.order[3].label, "<>")
    assertEqual(FUA.order[4].label, "T")
    assertEqual(FUA.order[5].label, "O")

    local prepared = FUA:GetPreparedMessageOrderString()

    assertEqual(
        prepared,
        "[ O ]    [ T ]    [ <> ]    [ V ]    [ X ]"
    )
end)

-----------------------------------------------------------------------
-- Execute
-----------------------------------------------------------------------

runTests()
