-----------------------------------------------------------------------
-- FUA - Azta'rec Intermission Tracker
-- File: Modules/Encounters/TCI/AZ/Data.lua
--
-- Static addon data and configuration.
--
-- Contains:
--   * Encounter identifiers
--   * Symbol definitions
--   * Default configuration values
-----------------------------------------------------------------------

local addonName, FUA = ...

FUA.AZ = FUA.AZ or {}

-----------------------------------------------------------------------
-- Default Configuration
-----------------------------------------------------------------------

FUA.AZ.DEFAULT_SYMBOL_COUNT = 5
FUA.AZ.DEFAULT_OUTPUT_MODE = "markers"
FUA.AZ.DEFAULT_COLLAPSED = false

-----------------------------------------------------------------------
-- Encounter Data
-----------------------------------------------------------------------

FUA.AZ.AZTAREC_ENCOUNTER_ID = 3525
FUA.AZ.COILED_ISLE_INSTANCE_ID = 3079

-----------------------------------------------------------------------
-- Symbol Definitions
-----------------------------------------------------------------------

FUA.AZ.symbols = {
    {
        label = "X",
        char = "X",
        marker = "{rt7}",
        raidIcon = 7,
        displayMarker =
            "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:52:52|t",
        texture =
            "Interface\\AddOns\\FUA\\Textures\\Encounters\\TCI\\AZ\\cross.png",
        color = FUA.Colors.CROSS
    },
    {
        label = "Square",
        char = "Square",
        marker = "{rt6}",
        raidIcon = 6,
        displayMarker =
            "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:52:52|t",
        texture =
            "Interface\\AddOns\\FUA\\Textures\\Encounters\\TCI\\AZ\\square.png",
        color = FUA.Colors.SQUARE
    },
    {
        label = "Circle",
        char = "O",
        marker = "{rt2}",
        raidIcon = 2,
        displayMarker =
            "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:52:52|t",
        texture =
            "Interface\\AddOns\\FUA\\Textures\\Encounters\\TCI\\AZ\\circle.png",
        color = FUA.Colors.CIRCLE
    },
    {
        label = "Diamond",
        char = "D",
        marker = "{rt3}",
        raidIcon = 3,
        displayMarker =
            "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:52:52|t",
        texture =
            "Interface\\AddOns\\FUA\\Textures\\Encounters\\TCI\\AZ\\diamond.png",
        color = FUA.Colors.DIAMOND
    },
}
