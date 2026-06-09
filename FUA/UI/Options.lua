-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: UI/Options.lua
--
-- Settings window for strategy/output preferences.
-----------------------------------------------------------------------

local addonName, FUA = ...

local function SetButtonSelected(button, selected)
    if selected then
        button:SetNormalFontObject("GameFontHighlight")
    else
        button:SetNormalFontObject("GameFontNormal")
    end
end

function FUA:CreateOptionsWindow()
    local parent = self.frame

    local options = CreateFrame("Frame", "FUAOptionsFrame", parent, "BackdropTemplate")
    options:SetSize(260, 180)
    options:SetPoint("TOPLEFT", parent, "TOPRIGHT", 8, 0)
    options:SetFrameStrata("DIALOG")
    options:Hide()
    self.optionsFrame = options

    options:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    options:SetBackdropColor(0.02, 0.02, 0.03, 0.86)
    options:SetBackdropBorderColor(0.35, 0.35, 0.45, 0.9)

    local title = options:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    title:SetPoint("TOPLEFT", options, "TOPLEFT", 12, -10)
    title:SetText("FUA Options")

    local closeButton = CreateFrame("Button", nil, options, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", options, "TOPRIGHT", 2, 2)
    closeButton:SetScript("OnClick", function()
        options:Hide()
    end)

    local strategyLabel = options:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    strategyLabel:SetPoint("TOPLEFT", options, "TOPLEFT", 14, -42)
    strategyLabel:SetText("Strategy")

    local clockwiseButton = CreateFrame("Button", nil, options, "GameMenuButtonTemplate")
    clockwiseButton:SetSize(108, 22)
    clockwiseButton:SetPoint("TOPLEFT", strategyLabel, "BOTTOMLEFT", 0, -6)
    clockwiseButton:SetText("Clockwise")

    local counterButton = CreateFrame("Button", nil, options, "GameMenuButtonTemplate")
    counterButton:SetSize(126, 22)
    counterButton:SetPoint("LEFT", clockwiseButton, "RIGHT", 6, 0)
    counterButton:SetText("Counter")

    local outputLabel = options:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    outputLabel:SetPoint("TOPLEFT", clockwiseButton, "BOTTOMLEFT", 0, -18)
    outputLabel:SetText("Output")

    local markersButton = CreateFrame("Button", nil, options, "GameMenuButtonTemplate")
    markersButton:SetSize(108, 22)
    markersButton:SetPoint("TOPLEFT", outputLabel, "BOTTOMLEFT", 0, -6)
    markersButton:SetText("Markers")

    local charsButton = CreateFrame("Button", nil, options, "GameMenuButtonTemplate")
    charsButton:SetSize(126, 22)
    charsButton:SetPoint("LEFT", markersButton, "RIGHT", 6, 0)
    charsButton:SetText("Characters")

    local function RefreshOptions()
        SetButtonSelected(clockwiseButton, self.reverseOrder == true)
        SetButtonSelected(counterButton, self.reverseOrder ~= true)
        SetButtonSelected(markersButton, self.outputMode == "markers")
        SetButtonSelected(charsButton, self.outputMode ~= "markers")
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
