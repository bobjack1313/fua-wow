-----------------------------------------------------------------------
-- FUA
-- File: Core/Locales/enGB.lua
--
-- English (Great Britain) localisation.
--
-- Responsible for:
--   * British English text
--   * Shared UI labels
--   * Shared status messages
--   * Slash command text
--
-- Notes:
--   This locale inherits the same meaning as enUS but may use
--   region-specific spelling and wording where appropriate.
-----------------------------------------------------------------------

local addonName, FUA = ...

FUA.Locales = FUA.Locales or {}

FUA.Locales.enGB = {

    -------------------------------------------------------------------
    -- Addon
    -------------------------------------------------------------------

    ADDON_NAME = "FUA",
    TITLE = "FUA",
    VERSION_LABEL = "Version",

    -------------------------------------------------------------------
    -- Common UI
    -------------------------------------------------------------------

    SHOW = "Show",
    HIDE = "Hide",
    CLOSE = "Close",
    CLEAR = "Clear",
    UNDO = "Undo",
    OPTIONS = "Options",
    EXPAND = "Expand",
    COLLAPSE = "Collapse",

    -------------------------------------------------------------------
    -- Core UI
    -------------------------------------------------------------------

    HUB_TITLE = "FUA Hub",
    OPTIONS_TITLE = "FUA Options",
    MINIMAP_TOOLTIP = "FUA",

    -------------------------------------------------------------------
    -- Slash Commands
    -------------------------------------------------------------------

    HELP_TITLE = "FUA Help",

    HELP_TOGGLE = "/fua - Toggle the window",
    HELP_SHOW = "/fua show - Show the window",
    HELP_HIDE = "/fua hide - Hide the window",
    HELP_CLEAR = "/fua clear - Clear the current order",

    HELP_USAGE =
        "Build the rune order, review the diagram, then click Prepare Message. Then manually send it to the raid to share the rune assignment.",

    -------------------------------------------------------------------
    -- Status Messages
    -------------------------------------------------------------------

    MF_MSG_READY =
        "Midnight Falls helper ready. Use /fua to prepare rune call-outs.",

    MSG_IMPORTED =
        "Assignment imported from chat.",

    -------------------------------------------------------------------
    -- Errors
    -------------------------------------------------------------------

    ERR_SYMBOL_EXISTS =
        "Symbol already selected.",

    ERR_SYMBOL_LIMIT =
        "Symbol limit reached.",

    ERR_NO_ORDER =
        "No order has been created yet.",

    -------------------------------------------------------------------
    -- Midnight Falls
    -------------------------------------------------------------------

    MF_TITLE = "FUA | Midnight Falls",

    DIFFICULTY_LABEL = "Difficulty",

    DIFFICULTY_UNKNOWN = "Unknown",
    DIFFICULTY_LFR = "LFR",
    DIFFICULTY_NORMAL = "Normal",
    DIFFICULTY_HEROIC = "Heroic",
    DIFFICULTY_MYTHIC = "Mythic",
    DIFFICULTY_OUTSIDE_RAID = "Outside Raid",

    STRATEGY = "Strategy",

    CLOCKWISE = "Clockwise",
    COUNTER_CLOCKWISE = "Anti-clockwise",

    OUTPUT = "Output",

    MARKERS = "Markers",
    CHARACTERS = "Characters",

    PREPARE_MESSAGE = "Prepare Message",
}
