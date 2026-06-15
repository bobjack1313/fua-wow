-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Core/FUA.lua
--
-- Addon namespace and shared runtime state.
--
-- Responsible for:
--   * Accessing the shared addon table
--   * Initializing base runtime containers
-----------------------------------------------------------------------

local addonName, FUA = ...

-----------------------------------------------------------------------
-- Runtime State
-----------------------------------------------------------------------

FUA.order = FUA.order or {}

FUA.DEBUG_COMMS = false

-----------------------------------------------------------------------
-- Protected Combat Detection
-----------------------------------------------------------------------

function FUA:IsProtectedCombat()
    return InCombatLockdown and InCombatLockdown()
end

-----------------------------------------------------------------------
-- Debug Logging
-----------------------------------------------------------------------

function FUA:DebugLog(event, data)
    FUADB.debugLog = FUADB.debugLog or {}

    table.insert(FUADB.debugLog, {
        time = date("%H:%M:%S"),
        event = event,
        data = data,
    })

    while #FUADB.debugLog > 100 do
        table.remove(FUADB.debugLog, 1)
    end
end

function FUA:ClearDebugLog()
    FUADB.debugLog = {}
end

