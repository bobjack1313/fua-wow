-----------------------------------------------------------------------
-- FUA
-- File: Modules/Encounters/MFQ/MF/UI/Layout.lua
--
-- User interface layout constants for the Midnight Falls module.
--
-- Responsible for:
--   * Frame dimensions
--   * Control sizing
--   * Element positioning
--   * Shared spacing values
--   * Layout state dimensions
--
-- Future Considerations:
--   * UI scaling support
--   * Multiple layout profiles
--   * Dynamic sizing based on module state
--   * Shared layout utilities across modules
-----------------------------------------------------------------------

local addonName, FUA = ...

FUA.MF = FUA.MF or {}

FUA.MF.UI = {

    -------------------------------------------------------------------
    -- MainFrame.lua
    -------------------------------------------------------------------
    FRAME_WIDTH                = 380,
    FRAME_HEIGHT               = 280,
    FRAME_COLLAPSED_HEIGHT     = 200,

    FRAME_TITLE_X              = 12,
    FRAME_TITLE_Y              = -8,

    BACKDROP_EDGE              = 16,
    BACKDROP_INSET             = 4,

    CLOSE_BUTTON_X             = 2,
    CLOSE_BUTTON_Y             = 2,

    DIFFICULTY_TEXT_X          = -8,
    DIFFICULTY_TEXT_Y          = -4,

    OPTIONS_BUTTON_WIDTH       = 18,
    OPTIONS_BUTTON_HEIGHT      = 18,
    OPTIONS_BUTTON_X           = -6,
    OPTIONS_BUTTON_Y           = -2,

    OPTIONS_BUTTON_ICON_SIZE   = 18,

    DIVIDER_MARGIN_X           = 10,
    DIVIDER_EXPANDED_Y         = 80,
    DIVIDER_COLLAPSED_Y        = 0,
    DIVIDER_HEIGHT             = 1,

    -------------------------------------------------------------------
    -- Controls.lua
    -------------------------------------------------------------------
    COMP_CONTROLS_FRAME_WIDTH  = 340,
    COMP_CONTROLS_FRAME_HEIGHT = 24,
    COMP_CONTROLS_FRAME_X      = 0,
    COMP_CONTROLS_FRAME_Y      = 4,

    COLLAPSE_BUTTON_WIDTH      = 80,
    COLLAPSE_BUTTON_HEIGHT     = 22,
    COLLAPSE_BUTTON_X          = -10,
    COLLAPSE_BUTTON_Y          = 0,

    COMP_CLEAR_BUTTON_WIDTH    = 75,
    COMP_CLEAR_BUTTON_HEIGHT   = 22,
    COMP_CLEAR_BUTTON_X        = 0,
    COMP_CLEAR_BUTTON_Y        = 0,

    CONTROLS_FRAME_WIDTH       = 360,
    CONTROLS_FRAME_HEIGHT      = 70,
    CONTROLS_FRAME_X           = 0,
    CONTROLS_FRAME_Y           = -6,

    DISPLAY_BOX_WIDTH          = 180,
    DISPLAY_BOX_HEIGHT         = 25,
    DISPLAY_BOX_X              = 0,
    DISPLAY_BOX_Y              = 0,
    DISPLAY_BOX_BD_EDGE        = 10,
    DISPLAY_BOX_BD_INSET       = 3,

    DISPLAY_TEXT_X             = 0,
    DISPLAY_TEXT_Y             = 0,

    CONTROLS_FONT_SIZE_CHAR    = 12,
    CONTROLS_FONT_SIZE_MARK    = 9,

    RUNE_SIZE                  = 32,
    RUNE_GAP                   = 5,
    RUNE_BUTTON_X              = 0,
    RUNE_BUTTON_Y_1            = -4,
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

    UNDO_BUTTON_WIDTH          = 85,
    UNDO_BUTTON_HEIGHT         = 26,
    UNDO_BUTTON_X              = -90,
    UNDO_BUTTON_Y              = 0,

    CLEAR_BUTTON_WIDTH         = 85,
    CLEAR_BUTTON_HEIGHT        = 26,
    CLEAR_BUTTON_X             = 0,
    CLEAR_BUTTON_Y             = 0,

    CHAT_BUTTON_WIDTH          = 170,
    CHAT_BUTTON_HEIGHT         = 30,
    CHAT_BUTTON_X              = 0,
    CHAT_BUTTON_Y              = -4,

    -------------------------------------------------------------------
    -- Diagram.lua
    -------------------------------------------------------------------
    POSITION_LAYOUT_5 = {
        [5] = { x = -115, y =  10 },
        [1] = { x =  115, y =  10 },
        [4] = { x =  -65, y = -52 },
        [3] = { x =    0, y = -52 },
        [2] = { x =   65, y = -52 },
    },

    POSITION_LAYOUT_3 = {
        [1] = { x =  72, y = -52 },
        [2] = { x =   0, y = -52 },
        [3] = { x = -72, y = -52 },
    },

    DIAGRAM_FRAME_WIDTH        = 360,
    DIAGRAM_FRAME_HEIGHT       = 180,
    DIAGRAM_FRAME_X            = 0,
    DIAGRAM_FRAME_Y            = 0,

    LURA_PLATE_WIDTH           = 118,
    LURA_PLATE_HEIGHT          = 74,
    LURA_PLATE_X               = 0,
    LURA_PLATE_Y               = 16,
    LURA_PLATE_BD_EDGE         = 12,
    LURA_PLATE_BD_INSET        = 3,

    LURA_ICON_TOP_X            = 3,
    LURA_ICON_TOP_Y            = -3,
    LURA_ICON_BOTTOM_X         = -3,
    LURA_ICON_BOTTOM_Y         = 3,

    SLOT_SIZE                  = 54,
    SLOT_BD_EDGE               = 10,
    SLOT_BD_INSET              = 3,

    SLOT_NUMBER_X              = 0,
    SLOT_NUMBER_Y              = -4,

    SLOT_ICON_SIZE             = 38,
    SLOT_ICON_X                = 0,
    SLOT_ICON_Y                = -5,

    SLOT_BORDER_ALPHA          = 0.72,

    -------------------------------------------------------------------
    -- Options.lua
    -------------------------------------------------------------------
    OPTIONS_FRAME_WIDTH        = 210,
    OPTIONS_FRAME_HEIGHT       = 140,
    OPTIONS_FRAME_X            = 8,
    OPTIONS_FRAME_Y            = 0,
    OPTIONS_FRAME_BD_EDGE      = 16,
    OPTIONS_FRAME_BD_INSET     = 4,

    OPTIONS_TITLE_X            = 12,
    OPTIONS_TITLE_Y            = -10,

    OPTIONS_CLOSE_BUTTON_X     = 2,
    OPTIONS_CLOSE_BUTTON_Y     = 2,

    STRATEGY_LABEL_X           = 14,
    STRATEGY_LABEL_Y           = -35,

    OUTPUT_LABEL_X             = 0,
    OUTPUT_LABEL_Y             = -15,

    CLOCKWISE_BUTTON_WIDTH     = 95,
    CLOCKWISE_BUTTON_HEIGHT    = 22,
    CLOCKWISE_BUTTON_X         = 0,
    CLOCKWISE_BUTTON_Y         = -6,

    COUNTER_BUTTON_WIDTH       = 95,
    COUNTER_BUTTON_HEIGHT      = 22,
    COUNTER_BUTTON_X           = 6,
    COUNTER_BUTTON_Y           = 0,

    MARKERS_BUTTON_WIDTH       = 95,
    MARKERS_BUTTON_HEIGHT      = 22,
    MARKERS_BUTTON_X           = 0,
    MARKERS_BUTTON_Y           = -6,

    CHARACTERS_BUTTON_WIDTH    = 95,
    CHARACTERS_BUTTON_HEIGHT   = 22,
    CHARACTERS_BUTTON_X        = 6,
    CHARACTERS_BUTTON_Y        = 0,
}
