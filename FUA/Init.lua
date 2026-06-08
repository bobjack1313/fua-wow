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
FUADB = FUADB or {}

FUA.outputMode = FUADB.outputMode or FUA.DEFAULT_OUTPUT_MODE
FUA.symbolCount = FUA.symbolCount or FUA.DEFAULT_SYMBOL_COUNT

FUA.reverseOrder = FUADB.reverseOrder
if FUA.reverseOrder == nil then
    FUA.reverseOrder = true
end

FUA.showOnLogin = FUADB.showOnLogin or false

-----------------------------------------------------------------------
-- Addon Startup
-----------------------------------------------------------------------

FUA:CreateUI()
FUA:RegisterEncounterEvents()
FUA:RegisterCommands()
FUA:UpdateDifficulty()
FUA:UpdateDisplay()

-----------------------------------------------------------------------
-- Interapp Comms
-----------------------------------------------------------------------

C_ChatInfo.RegisterAddonMessagePrefix("FUA")
