-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Modules/Encounters/MFQ/MF/UI/Options.lua
--
-- Settings window for strategy/output preferences.
-----------------------------------------------------------------------

local addonName, FUA = ...

local UI = FUA.MF.UI

local function SetButtonSelected(addon, button, selected)
    local text = button:GetFontString()
    if not text then
        return
    end

    if selected then
        text:SetTextColor(unpack(addon.Colors.OPTIONS_TEXT_ACTIVE))
    else
        text:SetTextColor(unpack(addon.Colors.OPTIONS_TEXT_INACTIVE))
    end
end

function FUA:CreateOptionsWindow()
    local parent = self.frame

    local options = CreateFrame("Frame", "FUAOptionsFrame", parent, "BackdropTemplate")
    options:SetSize(UI.OPTIONS_FRAME_WIDTH, UI.OPTIONS_FRAME_HEIGHT)
    options:SetPoint("TOPLEFT", parent, "TOPRIGHT", UI.OPTIONS_FRAME_X, UI.OPTIONS_FRAME_Y)
    options:SetFrameStrata("DIALOG")
    options:Hide()
    self.optionsFrame = options

    options:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = UI.OPTIONS_FRAME_BD_EDGE,
        insets = {
            left = UI.OPTIONS_FRAME_BD_INSET,
            right = UI.OPTIONS_FRAME_BD_INSET,
            top = UI.OPTIONS_FRAME_BD_INSET,
            bottom = UI.OPTIONS_FRAME_BD_INSET
        },
    })
    options:SetBackdropColor(unpack(self.Colors.OPTIONS_BACKGROUND))
    options:SetBackdropBorderColor(unpack(self.Colors.OPTIONS_BORDER))

    local title = options:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    title:SetPoint("TOPLEFT", options, "TOPLEFT", UI.OPTIONS_TITLE_X, UI.OPTIONS_TITLE_Y)
    title:SetText(self.L.OPTIONS_TITLE)

    local closeButton = CreateFrame("Button", nil, options, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", options, "TOPRIGHT", UI.OPTIONS_CLOSE_BUTTON_X, UI.OPTIONS_CLOSE_BUTTON_Y)
    closeButton:SetScript("OnClick", function()
        options:Hide()
    end)

    local strategyLabel = options:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    strategyLabel:SetPoint("TOPLEFT", options, "TOPLEFT", UI.STRATEGY_LABEL_X, UI.STRATEGY_LABEL_Y)
    strategyLabel:SetText(self.L.STRATEGY)

    local clockwiseButton = CreateFrame("Button", nil, options, "GameMenuButtonTemplate")
    clockwiseButton:SetSize(UI.CLOCKWISE_BUTTON_WIDTH, UI.CLOCKWISE_BUTTON_HEIGHT)
    clockwiseButton:SetPoint("TOPLEFT", strategyLabel, "BOTTOMLEFT", UI.CLOCKWISE_BUTTON_X, UI.CLOCKWISE_BUTTON_Y)
    clockwiseButton:SetText(self.L.CLOCKWISE)

    local counterButton = CreateFrame("Button", nil, options, "GameMenuButtonTemplate")
    counterButton:SetSize(UI.COUNTER_BUTTON_WIDTH, UI.COUNTER_BUTTON_HEIGHT)
    counterButton:SetPoint("LEFT", clockwiseButton, "RIGHT", UI.COUNTER_BUTTON_X, UI.COUNTER_BUTTON_Y)
    counterButton:SetText(self.L.COUNTER_CLOCKWISE)

    local outputLabel = options:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    outputLabel:SetPoint("TOPLEFT", clockwiseButton, "BOTTOMLEFT", UI.OUTPUT_LABEL_X, UI.OUTPUT_LABEL_Y)
    outputLabel:SetText(self.L.OUTPUT)

    local markersButton = CreateFrame("Button", nil, options, "GameMenuButtonTemplate")
    markersButton:SetSize(UI.MARKERS_BUTTON_WIDTH, UI.MARKERS_BUTTON_HEIGHT)
    markersButton:SetPoint("TOPLEFT", outputLabel, "BOTTOMLEFT", UI.MARKERS_BUTTON_X, UI.MARKERS_BUTTON_Y)
    markersButton:SetText(self.L.MARKERS)

    local charsButton = CreateFrame("Button", nil, options, "GameMenuButtonTemplate")
    charsButton:SetSize(UI.CHARACTERS_BUTTON_WIDTH, UI.CHARACTERS_BUTTON_HEIGHT)
    charsButton:SetPoint("LEFT", markersButton, "RIGHT", UI.CHARACTERS_BUTTON_X, UI.CHARACTERS_BUTTON_Y)
    charsButton:SetText(self.L.CHARACTERS)

    local function RefreshOptions()
        SetButtonSelected(self, clockwiseButton, self.reverseOrder == true)
        SetButtonSelected(self, counterButton, self.reverseOrder ~= true)
        SetButtonSelected(self, markersButton, self.outputMode == "markers")
        SetButtonSelected(self, charsButton, self.outputMode ~= "markers")
    end

    clockwiseButton:SetScript("OnClick", function()
        self.reverseOrder = true
        FUADB.reverseOrder = self.reverseOrder
        RefreshOptions()
        self:UpdateDisplay()
    end)

    counterButton:SetScript("OnClick", function()
        self.reverseOrder = false
        FUADB.reverseOrder = self.reverseOrder
        RefreshOptions()
        self:UpdateDisplay()
    end)

    markersButton:SetScript("OnClick", function()
        self.outputMode = "markers"
        FUADB.outputMode = self.outputMode
        RefreshOptions()
        self:UpdateDisplayFont()
        self:UpdateDisplay()
    end)

    charsButton:SetScript("OnClick", function()
        self.outputMode = "char"
        FUADB.outputMode = self.outputMode
        RefreshOptions()
        self:UpdateDisplayFont()
        self:UpdateDisplay()
    end)

    options:SetScript("OnShow", RefreshOptions)
end

function FUA:ToggleOptionsWindow()
    if not self.optionsFrame then
        return
    end

    self.optionsFrame:SetShown(not self.optionsFrame:IsShown())
end
