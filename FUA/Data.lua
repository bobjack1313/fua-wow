-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Data.lua
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
FUA_DEBUG_DIFFICULTY = nil

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
        texture = "Interface\\AddOns\\FUA\\textures\\cross.png",
        color = {1.0, 0.05, 0.05, 0.75}
    },
    {
        label = "V",
        char = "V",
        marker = "{rt4}",
        displayMarker = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:22:22|t",
        texture = "Interface\\AddOns\\FUA\\textures\\triangle.png",
        color = {0.0, 1.0, 0.25, 0.75}
    },
    {
        label = "<>",
        char = "<>",
        marker = "{rt3}",
        displayMarker = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:22:22|t",
        texture = "Interface\\AddOns\\FUA\\textures\\diamond.png",
        color = {0.75, 0.1, 1.0, 0.75}
    },
    {
        label = "T",
        char = "T",
        marker = "T",
        displayMarker = "T",
        texture = "Interface\\AddOns\\FUA\\textures\\tee.png",
        color = {1.0, 0.82, 0.0, 0.75}
    },
    {
        label = "O",
        char = "O",
        marker = "{rt2}",
        displayMarker = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:22:22|t",
        texture = "Interface\\AddOns\\FUA\\textures\\circle.png",
        color = {1.0, 0.55, 0.0, 0.75}
    },
}
