-----------------------------------------------------------------------
-- FUA Tests
-- File: test_data.lua
--
-- Tests:
--   * Default configuration
--   * Encounter constants
--   * Symbol definitions
--   * Required symbol fields
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

-----------------------------------------------------------------------
-- Tests
-----------------------------------------------------------------------

test("Data defines default configuration", function()
    assertEqual(FUA.DEFAULT_SYMBOL_COUNT, 5)
    assertEqual(FUA.DEFAULT_OUTPUT_MODE, "char")
end)

test("Data defines encounter constants", function()
    assertEqual(FUA.MIDNIGHT_FALLS_ENCOUNTER_ID, 3183)
    assertEqual(FUA.MARCH_OF_QUELDANAS_INSTANCE_ID, 2913)
end)

test("Data defines five symbols", function()
    assertEqual(#FUA.symbols, 5)
end)

test("Symbols have required fields", function()
    for _, symbol in ipairs(FUA.symbols) do
        assertTrue(symbol.label ~= nil)
        assertTrue(symbol.char ~= nil)
        assertTrue(symbol.marker ~= nil)
        assertTrue(symbol.displayMarker ~= nil)
        assertTrue(symbol.texture ~= nil)
        assertTrue(symbol.color ~= nil)
    end
end)

test("Symbols have expected labels", function()
    assertEqual(FUA.symbols[1].label, "X")
    assertEqual(FUA.symbols[2].label, "V")
    assertEqual(FUA.symbols[3].label, "<>")
    assertEqual(FUA.symbols[4].label, "T")
    assertEqual(FUA.symbols[5].label, "O")
end)

test("Symbols have expected marker mappings", function()
    assertEqual(FUA.symbols[1].marker, "{rt7}")
    assertEqual(FUA.symbols[2].marker, "{rt4}")
    assertEqual(FUA.symbols[3].marker, "{rt3}")
    assertEqual(FUA.symbols[4].marker, "T")
    assertEqual(FUA.symbols[5].marker, "{rt2}")
end)

-----------------------------------------------------------------------
-- Execute
-----------------------------------------------------------------------

runTests()
