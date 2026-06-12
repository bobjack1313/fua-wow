-----------------------------------------------------------------------
-- FUA
-- File: Core/Locales/itIT.lua
--
-- Italian localization.
-----------------------------------------------------------------------

local addonName, FUA = ...

FUA.Locales = FUA.Locales or {}

FUA.Locales.itIT = {
    ADDON_NAME = "FUA",
    TITLE = "FUA",
    VERSION_LABEL = "Versione",

    SHOW = "Mostra",
    HIDE = "Nascondi",
    CLOSE = "Chiudi",
    CLEAR = "Cancella",
    UNDO = "Annulla",
    OPTIONS = "Opzioni",
    EXPAND = "Espandi",
    COLLAPSE = "Riduci",

    HUB_TITLE = "Centro FUA",
    OPTIONS_TITLE = "Opzioni FUA",
    MINIMAP_TOOLTIP = "FUA",

    HELP_TITLE = "Aiuto FUA",
    HELP_TOGGLE = "/fua - Mostra o nasconde la finestra",
    HELP_SHOW = "/fua show - Mostra la finestra",
    HELP_HIDE = "/fua hide - Nasconde la finestra",
    HELP_CLEAR = "/fua clear - Cancella l'ordine corrente",
    HELP_USAGE =
        "Costruisci l'ordine delle rune, controlla il diagramma e fai clic su Prepara Messaggio. Poi invialo manualmente al raid.",

    MSG_READY =
        "Assistente Midnight Falls pronto. Usa /fua per preparare gli avvisi delle rune.",

    MSG_IMPORTED =
        "Assegnazione importata dalla chat.",

    ERR_SYMBOL_EXISTS =
        "Questo simbolo è già selezionato.",

    ERR_SYMBOL_LIMIT =
        "Limite di simboli raggiunto.",

    ERR_NO_ORDER =
        "Nessun ordine ancora creato.",

    MF_TITLE = "FUA | Midnight Falls",

    DIFFICULTY_LABEL = "Difficoltà",

    DIFFICULTY_UNKNOWN = "Sconosciuta",
    DIFFICULTY_LFR = "Ricerca Incursione",
    DIFFICULTY_NORMAL = "Normale",
    DIFFICULTY_HEROIC = "Eroica",
    DIFFICULTY_MYTHIC = "Mitica",
    DIFFICULTY_OUTSIDE_RAID = "Fuori dall'incursione",

    STRATEGY = "Strategia",

    CLOCKWISE = "Orario",
    COUNTER_CLOCKWISE = "Antiorario",

    OUTPUT = "Output",

    MARKERS = "Indicatori",
    CHARACTERS = "Caratteri",

    PREPARE_MESSAGE = "Prepara Messaggio",
}
