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

_G.FUA = FUA -- temporary debug access

-----------------------------------------------------------------------
-- Runtime State
-----------------------------------------------------------------------

FUA.order = FUA.order or {}
