-----------------------------------------------------------------------
-- FUA
-- File: Core/Locales/deDE.lua
--
-- German localization.
-----------------------------------------------------------------------

local addonName, FUA = ...

FUA.Locales = FUA.Locales or {}

FUA.Locales.deDE = {
    ADDON_NAME = "FUA",
    TITLE = "FUA",
    VERSION_LABEL = "Version",

    SHOW = "Anzeigen",
    HIDE = "Ausblenden",
    CLOSE = "Schließen",
    CLEAR = "Leeren",
    UNDO = "Rückgängig",
    OPTIONS = "Optionen",
    EXPAND = "Erweitern",
    COLLAPSE = "Einklappen",

    HUB_TITLE = "FUA-Zentrale",
    OPTIONS_TITLE = "FUA-Optionen",
    MINIMAP_TOOLTIP = "FUA",

    HELP_TITLE = "FUA-Hilfe",
    HELP_TOGGLE = "/fua - Fenster ein-/ausblenden",
    HELP_SHOW = "/fua show - Fenster anzeigen",
    HELP_HIDE = "/fua hide - Fenster ausblenden",
    HELP_CLEAR = "/fua clear - Aktuelle Reihenfolge leeren",
    HELP_USAGE =
        "Erstelle die Runenreihenfolge, prüfe das Diagramm und klicke dann auf Nachricht vorbereiten. Sende sie danach manuell an den Schlachtzug.",

    MSG_READY =
        "Midnight-Falls-Helfer bereit. Nutze /fua, um Runenansagen vorzubereiten.",

    MSG_IMPORTED =
        "Zuweisung aus dem Chat importiert.",

    ERR_SYMBOL_EXISTS =
        "Dieses Symbol ist bereits ausgewählt.",

    ERR_SYMBOL_LIMIT =
        "Symbollimit erreicht.",

    ERR_NO_ORDER =
        "Es wurde noch keine Reihenfolge erstellt.",

    MF_TITLE = "FUA | Midnight Falls",

    DIFFICULTY_LABEL = "Schwierigkeit",

    DIFFICULTY_UNKNOWN = "Unbekannt",
    DIFFICULTY_LFR = "Schlachtzugsbrowser",
    DIFFICULTY_NORMAL = "Normal",
    DIFFICULTY_HEROIC = "Heroisch",
    DIFFICULTY_MYTHIC = "Mythisch",
    DIFFICULTY_OUTSIDE_RAID = "Außerhalb des Schlachtzugs",

    STRATEGY = "Strategie",

    CLOCKWISE = "Uhrzeiger",
    COUNTER_CLOCKWISE = "Gegen-Uhrz.",

    OUTPUT = "Ausgabe",

    MARKERS = "Markierungen",
    CHARACTERS = "Zeichen",

    PREPARE_MESSAGE = "Nachricht vorbereiten",
}
