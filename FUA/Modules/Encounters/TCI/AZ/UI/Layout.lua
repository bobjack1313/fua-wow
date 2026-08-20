-----------------------------------------------------------------------
-- FUA
-- File: Modules/Encounters/TCI/AZ/UI/Layout.lua
--
-- User interface layout constants for the Azta'rec module.
-----------------------------------------------------------------------

local addonName, FUA = ...

FUA.AZ = FUA.AZ or {}

FUA.AZ.UI = {

    -------------------------------------------------------------------
    -- MainFrame.lua
    -------------------------------------------------------------------

    FRAME_WIDTH                = 300,
    FRAME_HEIGHT               = 200,

    FRAME_TITLE_X              = 12,
    FRAME_TITLE_Y              = -8,

    BACKDROP_EDGE              = 16,
    BACKDROP_INSET             = 4,

    CLOSE_BUTTON_X             = 2,
    CLOSE_BUTTON_Y             = 2,

    DIVIDER_MARGIN_X           = 10,
    DIVIDER_EXPANDED_Y         = 78,
    DIVIDER_COLLAPSED_Y        = 0,
    DIVIDER_HEIGHT             = 1,

    -------------------------------------------------------------------
    -- Controls.lua
    -------------------------------------------------------------------

    CONTROLS_FRAME_WIDTH       = 260,
    CONTROLS_FRAME_HEIGHT      = 30,
    CONTROLS_FRAME_X           = 0,
    CONTROLS_FRAME_Y           = -6,

    RUNE_SIZE                  = 35,
    RUNE_GAP                   = 8,
    RUNE_BUTTON_X              = 0,
    RUNE_BUTTON_Y_1            = -5,
    RUNE_BUTTON_Y              = 0,
    RUNE_BUTTON_BD_EDGE        = 10,
    RUNE_BUTTON_BD_INSET       = 3,
    RUNE_BD_ALPHA              = 0.75,
    RUNE_BD_BORDER_ALPHA       = 0.55,
    RUNE_ICON_TOP_X            = 5,
    RUNE_ICON_TOP_Y            = -5,
    RUNE_ICON_BOTTOM_X         = -5,
    RUNE_ICON_BOTTOM_Y         = 5,
    RUNE_ICON_BD1_ALPHA        = 0.88,
    RUNE_ICON_BD2_ALPHA        = 0.55,
    RUNE_ICON_BD_BORDER_ALPHA  = 0.45,

    UNDO_BUTTON_WIDTH          = 75,
    UNDO_BUTTON_HEIGHT         = 26,
    UNDO_BUTTON_X              = 0,
    UNDO_BUTTON_Y              = 0,

    CLEAR_BUTTON_WIDTH         = 75,
    CLEAR_BUTTON_HEIGHT        = 26,
    CLEAR_BUTTON_X             = 0,
    CLEAR_BUTTON_Y             = 0,

    -------------------------------------------------------------------
    -- Diagram.lua
    -------------------------------------------------------------------

    DIAGRAM_FRAME_WIDTH        = 300,
    DIAGRAM_FRAME_HEIGHT       = 160,
    DIAGRAM_FRAME_X            = 0,
    DIAGRAM_FRAME_Y            = 0,

    DIAGRAM_LABEL_X            = 0,
    DIAGRAM_LABEL_Y            = -25,

    SLOT_WIDTH                 = 50,
    SLOT_HEIGHT                = 70,
    SLOT_START_X               = 10,
    SLOT_Y                     = 0,
    SLOT_GAP                   = 8,

    SLOT_BD_EDGE               = 10,
    SLOT_BD_INSET              = 3,

    SLOT_NUMBER_X              = 0,
    SLOT_NUMBER_Y              = -5,

    SLOT_ICON_SIZE             = 40,
    SLOT_ICON_X                = 0,
    SLOT_ICON_Y                = -8,

    SLOT_BORDER_ALPHA          = 0.72,
}
