-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: FUA.lua
--
-- Addon namespace and shared runtime state.
--
-- Responsible for:
--   * Accessing the shared addon table
--   * Initializing base runtime containers
--
-- Does NOT contain:
--   * Saved variable initialization
--   * User interface code
--   * Encounter logic
--   * Chat handling
--   * Order management logic
-----------------------------------------------------------------------

local addonName, FUA = ...

_G.FUA = FUA -- temporary debug access

-----------------------------------------------------------------------
-- Runtime State
-----------------------------------------------------------------------

FUA.order = FUA.order or {}
