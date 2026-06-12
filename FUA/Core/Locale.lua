-----------------------------------------------------------------------
-- FUA
-- File: Core/Locale.lua
--
-- Centralized default English text.
--
-- Responsible for:
--   * Shared addon labels
--   * Slash command output
--   * Chat/status messages
--   * Common UI text
--
-- Notes:
--   Module-specific text should eventually live in that module's own
--   Locale.lua file. Core locale should remain shared/platform text.
-----------------------------------------------------------------------

local addonName, FUA = ...

local locale = GetLocale()
-- local locale = "frFR" -- TEMP TEST ONLY

FUA.L = FUA.Locales[locale] or FUA.Locales.enUS

-- print("FUA locale loaded:", locale)
