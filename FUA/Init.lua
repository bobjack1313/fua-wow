-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Init.lua
--
-- Addon startup and initialization.
--
-- Responsible for:
--   * Runtime configuration initialization
--   * User interface creation
--   * Event registration
--   * Slash command registration
--   * Initial addon state synchronization
--
-- Initialization Order:
--   1. Initialize runtime settings
--   2. Create user interface
--   3. Register events and commands
--   4. Synchronize display state
-----------------------------------------------------------------------

local addonName, FUA = ...

-----------------------------------------------------------------------
-- Runtime Initialization
-----------------------------------------------------------------------

FUA.outputMode = FUA.outputMode or FUA.DEFAULT_OUTPUT_MODE
FUA.symbolCount = FUA.symbolCount or FUA.DEFAULT_SYMBOL_COUNT

-----------------------------------------------------------------------
-- Addon Startup
-----------------------------------------------------------------------

FUA:CreateUI()
FUA:RegisterEncounterEvents()
FUA:RegisterCommands()
FUA:UpdateDifficulty()
FUA:UpdateDisplay()
