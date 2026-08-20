-----------------------------------------------------------------------
-- FUA
-- File: Core/Init.lua
--
-- Addon startup and module initialization.
--
-- Responsible for:
--   * Initializing shared SavedVariables
--   * Initializing Midnight Falls runtime state
--   * Initializing Azta'rec runtime state
--   * Creating module user interfaces
--   * Registering encounter events and slash commands
-----------------------------------------------------------------------

local addonName, FUA = ...

-----------------------------------------------------------------------
-- Module Runtime Initialization
-----------------------------------------------------------------------

local function InitializeMidnightFalls()
    FUA.outputMode =
        FUADB.outputMode
        or FUA.DEFAULT_OUTPUT_MODE

    FUA.symbolCount =
        FUA.DEFAULT_SYMBOL_COUNT

    FUA.reverseOrder = FUADB.reverseOrder

    if FUA.reverseOrder == nil then
        FUA.reverseOrder = true
    end

    FUA.showOnLogin =
        FUADB.showOnLogin == true

    FUA.collapsed = FUADB.collapsed

    if FUA.collapsed == nil then
        FUA.collapsed = FUA.DEFAULT_COLLAPSED
    end
end

local function InitializeAztaRec()
    local AZ = FUA.AZ
    local settings = FUADB.modules.AZ

    AZ.outputMode =
        settings.outputMode
        or AZ.DEFAULT_OUTPUT_MODE

    AZ.symbolCount =
        AZ.DEFAULT_SYMBOL_COUNT

    AZ.showOnLogin =
        settings.showOnLogin == true

    AZ.isEncounterActive = false
end

-----------------------------------------------------------------------
-- Module Startup
-----------------------------------------------------------------------

local function StartMidnightFalls()
    FUA:CreateUI()
    FUA:RegisterEncounterEvents()
    FUA:UpdateDifficulty()
    FUA:UpdateDisplay()
end

local function StartAztaRec()
    local AZ = FUA.AZ

    AZ:CreateUI()
    AZ:RegisterEncounterEvents()
end

-----------------------------------------------------------------------
-- Addon Initialization
-----------------------------------------------------------------------

local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("ADDON_LOADED")

initFrame:SetScript("OnEvent", function(_, _, loadedAddon)
    if loadedAddon ~= addonName then
        return
    end

    -------------------------------------------------------------------
    -- SavedVariables
    -------------------------------------------------------------------

    FUADB = FUADB or {}
    FUADB.modules = FUADB.modules or {}
    FUADB.modules.AZ = FUADB.modules.AZ or {}

    -------------------------------------------------------------------
    -- Runtime State
    -------------------------------------------------------------------

    InitializeMidnightFalls()
    InitializeAztaRec()

    -------------------------------------------------------------------
    -- Encounter Modules
    -------------------------------------------------------------------

    StartMidnightFalls()
    StartAztaRec()

    -------------------------------------------------------------------
    -- Shared Services
    -------------------------------------------------------------------

    FUA:RegisterCommands()

    C_ChatInfo.RegisterAddonMessagePrefix("FUA")
end)
