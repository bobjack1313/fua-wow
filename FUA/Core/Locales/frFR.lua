-----------------------------------------------------------------------
-- FUA
-- File: Core/Locales/frFR.lua
--
-- French localization.
-----------------------------------------------------------------------

local addonName, FUA = ...

FUA.Locales = FUA.Locales or {}

FUA.Locales.frFR = {
    ADDON_NAME = "FUA",
    TITLE = "FUA",
    VERSION_LABEL = "Version",

    SHOW = "Afficher",
    HIDE = "Masquer",
    CLOSE = "Fermer",
    CLEAR = "Effacer",
    UNDO = "Annuler",
    OPTIONS = "Options",
    EXPAND = "Développer",
    COLLAPSE = "Réduire",

    HUB_TITLE = "Centre FUA",
    OPTIONS_TITLE = "Options FUA",
    MINIMAP_TOOLTIP = "FUA",

    HELP_TITLE = "Aide FUA",
    HELP_TOGGLE = "/fua - Afficher ou masquer la fenêtre",
    HELP_SHOW = "/fua show - Afficher la fenêtre",
    HELP_HIDE = "/fua hide - Masquer la fenêtre",
    HELP_CLEAR = "/fua clear - Effacer l'ordre actuel",
    HELP_USAGE =
        "Construisez l'ordre des runes, vérifiez le diagramme, puis cliquez sur Préparer le message. Envoyez ensuite le message manuellement au raid.",

    MSG_READY =
        "Assistant Midnight Falls prêt. Utilisez /fua pour préparer les annonces de runes.",

    MSG_IMPORTED =
        "Attribution importée depuis le chat.",

    ERR_SYMBOL_EXISTS =
        "Ce symbole est déjà sélectionné.",

    ERR_SYMBOL_LIMIT =
        "Limite de symboles atteinte.",

    ERR_NO_ORDER =
        "Aucun ordre n'a encore été créé.",

    MF_TITLE = "FUA | Midnight Falls",

    DIFFICULTY_LABEL = "Difficulté",

    DIFFICULTY_UNKNOWN = "Inconnue",
    DIFFICULTY_LFR = "Recherche de raid",
    DIFFICULTY_NORMAL = "Normal",
    DIFFICULTY_HEROIC = "Héroïque",
    DIFFICULTY_MYTHIC = "Mythique",
    DIFFICULTY_OUTSIDE_RAID = "Hors raid",

    STRATEGY = "Stratégie",

    CLOCKWISE = "Horaire",
    COUNTER_CLOCKWISE = "Anti-horaire",

    OUTPUT = "Sortie",

    MARKERS = "Marqueurs",
    CHARACTERS = "Caractères",

    PREPARE_MESSAGE = "Préparer le message",
}
