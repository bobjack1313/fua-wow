-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Core/Init.lua
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

local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("ADDON_LOADED")

initFrame:SetScript("OnEvent", function(_, event, loadedAddon)
    if loadedAddon ~= addonName then
        return
    end

    FUADB = FUADB or {}

    FUA.outputMode = FUADB.outputMode or FUA.DEFAULT_OUTPUT_MODE
    FUA.symbolCount = FUA.DEFAULT_SYMBOL_COUNT

    FUA.reverseOrder = FUADB.reverseOrder
    if FUA.reverseOrder == nil then
        FUA.reverseOrder = true
    end

    FUA.showOnLogin = FUADB.showOnLogin == true
    FUA.collapsed = FUADB.collapsed

    if FUA.collapsed == nil then
        FUA.collapsed = FUA.DEFAULT_COLLAPSED
    end

    -- print("FUA DB loaded:", FUADB.outputMode, FUADB.reverseOrder, FUADB.showOnLogin)
    -- print("FUA runtime:", FUA.outputMode, FUA.reverseOrder, FUA.showOnLogin)

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
end)
