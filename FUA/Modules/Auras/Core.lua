-----------------------------------------------------------------------
-- FUA
-- File: Modules/Auras/Core.lua
--
-- Shared namespace and runtime state for the aura utility module.
--
-- Responsible for:
--   * Creating the Auras module namespace
--   * Holding shared aura module state
-----------------------------------------------------------------------

local addonName, FUA = ...

FUA.Auras = FUA.Auras or {}

local Auras = FUA.Auras

Auras.enabled = true
Auras.initialized = false
