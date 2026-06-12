-----------------------------------------------------------------------
-- FUA
-- File: Core/Colors.lua
--
-- Centralized color definitions.
--
-- Responsible for:
--   * Chat message colors
--   * Addon branding colors
--   * Status colors
--   * Shared UI color definitions
--
-- Notes:
--   All user-facing colors should originate here.
--   Avoid hardcoded RGB values elsewhere whenever possible.
-----------------------------------------------------------------------

local addonName, FUA = ...

FUA.Colors = {

    -------------------------------------------------------------------
    -- Chat Colors
    -------------------------------------------------------------------

    SUCCESS = "00ff88",
    ERROR   = "ff5555",
    WARNING = "ffaa00",
    INFO    = "66ccff",

    -------------------------------------------------------------------
    -- Branding
    -------------------------------------------------------------------

    TITLE = "00ff88",
    PREFIX = "00ff88",

    -------------------------------------------------------------------
    -- Rune Colors
    -------------------------------------------------------------------

    CROSS    = { 1.00, 0.05, 0.05, 0.75 },
    TRIANGLE = { 0.00, 1.00, 0.25, 0.75 },
    DIAMOND  = { 0.75, 0.10, 1.00, 0.75 },
    TEE      = { 1.00, 0.82, 0.00, 0.75 },
    CIRCLE   = { 1.00, 0.55, 0.00, 0.75 },

    -------------------------------------------------------------------
    -- Rune Button
    -------------------------------------------------------------------
    BUTTON_SELECTED_BORDER = { 1.0, 1.0, 1.0, 0.95 },

    -------------------------------------------------------------------
    -- Frame Colors
    -------------------------------------------------------------------

    FRAME_BACKGROUND = { 0.02, 0.02, 0.03, 0.70 },
    FRAME_BORDER     = { 0.35, 0.35, 0.45, 0.85 },

    OPTIONS_BACKGROUND        = { 0.02, 0.02, 0.03, 0.86 },
    OPTIONS_BORDER            = { 0.35, 0.35, 0.45, 0.90 },
    OPTIONS_TEXT_ACTIVE       = { 1.00, 1.00, 1.00, 1.00 },
    OPTIONS_TEXT_INACTIVE     = { 0.60, 0.60, 0.60, 0.65 },
    OPTIONS_BUTTON_VERT       = { 1.00, 1.00, 1.00, 1.00 },
    OPTIONS_BUTTON_VERT_LEAVE = { 0.85, 0.85, 0.85, 1.00 },

    -------------------------------------------------------------------
    -- Diagram Colors
    -------------------------------------------------------------------

    DIAGRAM_SLOT_BACKGROUND = { 0.02, 0.02, 0.03, 0.50 },
    DIAGRAM_SLOT_SELECTED   = { 0.18, 0.12, 0.28, 0.85 },
    DIAGRAM_SLOT_BORDER     = { 0.50, 0.50, 0.60, 0.55 },

    LURA_BACKGROUND = { 0.08, 0.02, 0.12, 0.46 },
    LURA_BORDER     = { 0.55, 0.25, 0.85, 0.52 },

    -------------------------------------------------------------------
    -- Display Box
    -------------------------------------------------------------------

    DISPLAY_BACKGROUND = { 0.00, 0.00, 0.00, 0.38 },
    DISPLAY_BORDER     = { 0.50, 0.50, 0.60, 0.38 },
    DISPLAY_TEXT       = { 1.00, 0.82, 0.00, 1.00 },

    -------------------------------------------------------------------
    -- Divider
    -------------------------------------------------------------------

    DIVIDER = { 0.55, 0.55, 0.65, 0.35 },
}

-----------------------------------------------------------------------
-- Color Helpers
-----------------------------------------------------------------------

function FUA:ColorText(hexColor, text)
    return "|cff" .. hexColor .. text .. "|r"
end

function FUA:GetPrefix()
    return self:ColorText(self.Colors.PREFIX, "FUA:")
end

function FUA:PrintInfo(message)
    print(self:ColorText(self.Colors.INFO, "FUA:") .. " " .. message)
end

function FUA:PrintSuccess(message)
    print(self:ColorText(self.Colors.SUCCESS, "FUA:") .. " " .. message)
end

function FUA:PrintWarning(message)
    print(self:ColorText(self.Colors.WARNING, "FUA:") .. " " .. message)
end

function FUA:PrintError(message)
    print(self:ColorText(self.Colors.ERROR, "FUA:") .. " " .. message)
end
