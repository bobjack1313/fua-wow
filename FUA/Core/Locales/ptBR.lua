-----------------------------------------------------------------------
-- FUA
-- File: Core/Locales/ptBR.lua
--
-- Portuguese (Brazil) localization.
--
-- Responsible for:
--   * Portuguese translations
--   * Shared UI labels
--   * Shared status messages
--   * Slash command text
-----------------------------------------------------------------------

local addonName, FUA = ...

FUA.Locales = FUA.Locales or {}

FUA.Locales.ptBR = {

    -------------------------------------------------------------------
    -- Addon
    -------------------------------------------------------------------

    ADDON_NAME = "FUA",
    TITLE = "FUA",
    VERSION_LABEL = "Versão",

    -------------------------------------------------------------------
    -- Common UI
    -------------------------------------------------------------------

    SHOW = "Mostrar",
    HIDE = "Ocultar",
    CLOSE = "Fechar",
    CLEAR = "Limpar",
    UNDO = "Desfazer",
    OPTIONS = "Opções",
    EXPAND = "Expandir",
    COLLAPSE = "Recolher",

    -------------------------------------------------------------------
    -- Core UI
    -------------------------------------------------------------------

    HUB_TITLE = "Central FUA",
    OPTIONS_TITLE = "Opções do FUA",
    MINIMAP_TOOLTIP = "FUA",

    -------------------------------------------------------------------
    -- Slash Commands
    -------------------------------------------------------------------

    HELP_TITLE = "Ajuda do FUA",

    HELP_TOGGLE = "/fua - Alterna a janela",
    HELP_SHOW = "/fua show - Mostra a janela",
    HELP_HIDE = "/fua hide - Oculta a janela",
    HELP_CLEAR = "/fua clear - Limpa a ordem atual",

    HELP_USAGE =
        "Monte a sequência de runas, revise o diagrama e clique em Preparar Mensagem. Depois envie manualmente para a raide.",

    -------------------------------------------------------------------
    -- Status Messages
    -------------------------------------------------------------------

    MF_MSG_READY =
        "Assistente de Midnight Falls pronto. Use /fua para preparar os avisos de runas.",

    MSG_IMPORTED =
        "Atribuição importada do chat.",

    -------------------------------------------------------------------
    -- Errors
    -------------------------------------------------------------------

    ERR_SYMBOL_EXISTS =
        "Esse símbolo já foi selecionado.",

    ERR_SYMBOL_LIMIT =
        "Limite de símbolos atingido.",

    ERR_NO_ORDER =
        "Nenhuma ordem foi criada ainda.",

    -------------------------------------------------------------------
    -- Midnight Falls
    -------------------------------------------------------------------

    MF_TITLE = "FUA | Midnight Falls",

    DIFFICULTY_LABEL = "Dificuldade",

    DIFFICULTY_UNKNOWN = "Desconhecida",
    DIFFICULTY_LFR = "Localizador de Raides",
    DIFFICULTY_NORMAL = "Normal",
    DIFFICULTY_HEROIC = "Heroica",
    DIFFICULTY_MYTHIC = "Mítica",
    DIFFICULTY_OUTSIDE_RAID = "Fora da Raide",

    STRATEGY = "Estratégia",

    CLOCKWISE = "Horário",
    COUNTER_CLOCKWISE = "Anti-horário",

    OUTPUT = "Saída",

    MARKERS = "Marcadores",
    CHARACTERS = "Caracteres",

    PREPARE_MESSAGE = "Preparar Mensagem",
    SEND_MESSAGE = "Enviar Mensagem",
}
