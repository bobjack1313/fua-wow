-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Modules/Encounters/MFQ/MF/Data.lua
--
-- Static addon data and configuration.
--
-- Contains:
--   * Encounter identifiers
--   * Symbol definitions
--   * Default configuration values
--   * Other non-runtime constants
-----------------------------------------------------------------------

local addonName, FUA = ...

-----------------------------------------------------------------------
-- Default Configuration
-----------------------------------------------------------------------

FUA.DEFAULT_SYMBOL_COUNT = 5
FUA.DEFAULT_OUTPUT_MODE = "char"
FUA_DEBUG_DIFFICULTY = 15
FUA.DEFAULT_COLLAPSED = false

-----------------------------------------------------------------------
-- Encounter Data
-----------------------------------------------------------------------

FUA.MIDNIGHT_FALLS_ENCOUNTER_ID = 3183
FUA.MARCH_OF_QUELDANAS_INSTANCE_ID = 2913

-----------------------------------------------------------------------
-- Symbol Definitions
-----------------------------------------------------------------------

FUA.symbols = {
    {
        label = "X",
        char = "X",
        marker = "{rt7}",
        displayMarker = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:22:22|t",
        texture = "Interface\\AddOns\\FUA\\Textures\\Encounters\\MFQ\\MF\\cross.png",
        color = FUA.Colors.CROSS
    },
    {
        label = "V",
        char = "V",
        marker = "{rt4}",
        displayMarker = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:22:22|t",
        texture = "Interface\\AddOns\\FUA\\Textures\\Encounters\\MFQ\\MF\\triangle.png",
        color = FUA.Colors.TRIANGLE
    },
    {
        label = "<>",
        char = "<>",
        marker = "{rt3}",
        displayMarker = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:22:22|t",
        texture = "Interface\\AddOns\\FUA\\Textures\\Encounters\\MFQ\\MF\\diamond.png",
        color = FUA.Colors.DIAMOND
    },
    {
        label = "T",
        char = "T",
        marker = "T",
        displayMarker = "T",
        texture = "Interface\\AddOns\\FUA\\Textures\\Encounters\\MFQ\\MF\\tee.png",
        color = FUA.Colors.TEE
    },
    {
        label = "O",
        char = "O",
        marker = "{rt2}",
        displayMarker = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:22:22|t",
        texture = "Interface\\AddOns\\FUA\\Textures\\Encounters\\MFQ\\MF\\circle.png",
        color = FUA.Colors.CIRCLE
    },
}
