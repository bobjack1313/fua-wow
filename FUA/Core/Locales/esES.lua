-----------------------------------------------------------------------
-- FUA
-- File: Core/Locales/esES.lua
--
-- Spanish (Spain) localization.
--
-- Responsible for:
--   * Spanish translations
--   * Shared UI labels
--   * Shared status messages
--   * Slash command text
-----------------------------------------------------------------------

local addonName, FUA = ...

FUA.Locales = FUA.Locales or {}

FUA.Locales.esES = {

    -------------------------------------------------------------------
    -- Addon
    -------------------------------------------------------------------

    ADDON_NAME = "FUA",
    TITLE = "FUA",
    VERSION_LABEL = "Versión",

    -------------------------------------------------------------------
    -- Common UI
    -------------------------------------------------------------------

    SHOW = "Mostrar",
    HIDE = "Ocultar",
    CLOSE = "Cerrar",
    CLEAR = "Limpiar",
    UNDO = "Deshacer",
    OPTIONS = "Opciones",
    EXPAND = "Expandir",
    COLLAPSE = "Contraer",

    -------------------------------------------------------------------
    -- Core UI
    -------------------------------------------------------------------

    HUB_TITLE = "Centro FUA",
    OPTIONS_TITLE = "Opciones de FUA",
    MINIMAP_TOOLTIP = "FUA",

    -------------------------------------------------------------------
    -- Slash Commands
    -------------------------------------------------------------------

    HELP_TITLE = "Ayuda de FUA",

    HELP_TOGGLE = "/fua - Mostrar u ocultar la ventana",
    HELP_SHOW = "/fua show - Mostrar la ventana",
    HELP_HIDE = "/fua hide - Ocultar la ventana",
    HELP_CLEAR = "/fua clear - Limpiar el orden actual",

    HELP_USAGE =
        "Construye el orden de runas, revisa el diagrama y luego pulsa Preparar Mensaje. Después envíalo manualmente a la banda.",

    -------------------------------------------------------------------
    -- Status Messages
    -------------------------------------------------------------------

    MF_MSG_READY =
        "Asistente de Midnight Falls listo. Usa /fua para preparar los avisos de runas.",

    MSG_IMPORTED =
        "Asignación importada desde el chat.",

    -------------------------------------------------------------------
    -- Errors
    -------------------------------------------------------------------

    ERR_SYMBOL_EXISTS =
        "Ese símbolo ya está seleccionado.",

    ERR_SYMBOL_LIMIT =
        "Se ha alcanzado el límite de símbolos.",

    ERR_NO_ORDER =
        "Todavía no se ha creado ningún orden.",

    -------------------------------------------------------------------
    -- Midnight Falls
    -------------------------------------------------------------------

    MF_TITLE = "FUA | Midnight Falls",

    DIFFICULTY_LABEL = "Dificultad",

    DIFFICULTY_UNKNOWN = "Desconocida",
    DIFFICULTY_LFR = "Buscador de Bandas",
    DIFFICULTY_NORMAL = "Normal",
    DIFFICULTY_HEROIC = "Heroica",
    DIFFICULTY_MYTHIC = "Mítica",
    DIFFICULTY_OUTSIDE_RAID = "Fuera de Banda",

    STRATEGY = "Estrategia",

    CLOCKWISE = "Horario",
    COUNTER_CLOCKWISE = "Antihorario",

    OUTPUT = "Salida",

    MARKERS = "Marcadores",
    CHARACTERS = "Caracteres",

    PREPARE_MESSAGE = "Preparar Mensaje",
}

-- Latin American Spanish currently reuses Spain Spanish.
FUA.Locales.esMX = FUA.Locales.esES
