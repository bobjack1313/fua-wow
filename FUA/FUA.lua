-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: FUA.lua
--
-- Addon namespace and runtime state initialization.
--
-- Responsible for:
--   * Creating the shared addon table
--   * Initializing runtime state
--   * Providing shared addon globals
--
-- Does NOT contain:
--   * User interface code
--   * Encounter logic
--   * Chat handling
--   * Order management logic
-----------------------------------------------------------------------

local addonName, FUA = ...

-----------------------------------------------------------------------
-- Runtime State
-----------------------------------------------------------------------

FUA.order = FUA.order or {}
FUA.reverseOrder = true
