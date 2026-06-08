-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: UI.lua
--
-- User interface construction and visual presentation.
--
-- Responsible for:
--   * Main window creation
--   * Button creation and layout
--   * Display text and counters
--   * Visual styling
--   * User interaction wiring
--
-- Does NOT contain:
--   * Encounter logic
--   * Order management
--   * Symbol data definitions
-----------------------------------------------------------------------

local addonName, FUA = ...

function FUA:CreateUI()

    -----------------------------------------------------------------------
    -- Main Frame
    -----------------------------------------------------------------------

    local frame = CreateFrame("Frame", "FUAFrame", UIParent, "BackdropTemplate")
    self.frame = frame

    frame:SetSize(360, 210)

    if FUADB.position then
        frame:SetPoint(
            FUADB.position.point or "CENTER",
            UIParent,
            FUADB.position.relativePoint or "CENTER",
            FUADB.position.x or 0,
            FUADB.position.y or 0
        )
    else
        frame:SetPoint("CENTER")
    end

    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)

    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()

        local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
            FUADB.position = {
                point = point,
                relativePoint = relativePoint,
                x = xOfs,
                y = yOfs,
            }
    end)

    frame:SetScript("OnShow", function()
        FUADB.showOnLogin = true
    end)

    frame:SetScript("OnHide", function()
        FUADB.showOnLogin = false
    end)

    frame:SetFrameStrata("HIGH")

    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })

    frame:SetBackdropColor(0.02, 0.02, 0.03, 0.62)
    frame:SetBackdropBorderColor(0.35, 0.35, 0.45, 0.85)

    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.title:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -8)
    frame.title:SetText("FUA | Midnight Falls")
    if self.showOnLogin then
        frame:Show()
    else
        frame:Hide()
    end

    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 2, 2)
    closeButton:SetScript("OnClick", function()
        frame:Hide()
    end)

    local difficultyText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    difficultyText:SetPoint("RIGHT", closeButton, "LEFT", -6, -4)
    difficultyText:SetJustifyH("RIGHT")
    self.difficultyText = difficultyText
    self:UpdateDifficulty()

    -----------------------------------------------------------------------
    -- Header Controls
    -----------------------------------------------------------------------

    local reverseButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
    reverseButton:SetSize(130, 22)
    reverseButton:SetPoint("TOP", frame, "TOP", 75, -25)

    local function UpdateReverseButton()
        if self.reverseOrder then
            reverseButton:SetText("Clockwise")
        else
            reverseButton:SetText("Counter Clockwise")
        end
    end

    local function ToggleReverse()
        self.reverseOrder = not self.reverseOrder
        FUADB.reverseOrder = self.reverseOrder
        reverseButton:SetText(self.reverseOrder and "Clockwise" or "Counter Clockwise")
        self:UpdateDisplay()
    end

    reverseButton:SetScript("OnClick", ToggleReverse)

    local outputButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
    outputButton:SetSize(100, 22)
    outputButton:SetPoint("TOP", frame, "TOP", -75, -25)

    local function UpdateOutputButton()
        if self.outputMode == "markers" then
            outputButton:SetText("Markers")
        else
            outputButton:SetText("Characters")
        end
    end

    local function ToggleOutputMode()
        if self.outputMode == "char" then
            self.outputMode = "markers"
        else
            self.outputMode = "char"
        end

        FUADB.outputMode = self.outputMode
        outputButton:SetText(self.outputMode == "markers" and "Markers" or "Characters")
        self:UpdateDisplayFont()
        self:UpdateDisplay()
    end

    outputButton:SetScript("OnClick", ToggleOutputMode)

    -- Synchronize button state from saved settings
    UpdateReverseButton()
    UpdateOutputButton()
    self:UpdateDisplayFont()
    self:UpdateDisplay()

    -----------------------------------------------------------------------
    -- Display Area
    -----------------------------------------------------------------------

    local displayBox = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    displayBox:SetSize(300, 38)
    displayBox:SetPoint("TOP", frame, "TOP", 0, -50)
    displayBox:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 10,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    displayBox:SetBackdropColor(0, 0, 0, 0.45)
    displayBox:SetBackdropBorderColor(0.5, 0.5, 0.6, 0.5)

    local displayText = displayBox:CreateFontString(nil, "OVERLAY")
    displayText:SetPoint("CENTER", displayBox, "CENTER", 0, 0)
    displayText:SetFont("Fonts\\FRIZQT__.TTF", 18, "OUTLINE")
    displayText:SetTextColor(1, 0.82, 0)
    self.displayText = displayText

    -----------------------------------------------------------------------
    -- Symbol Selection Buttons
    -----------------------------------------------------------------------

    local previousButton

    for i, symbol in ipairs(self.symbols) do
        local button = CreateFrame("Button", nil, frame, "BackdropTemplate")
        button:SetSize(52, 52)

        if i == 1 then
            button:SetPoint("TOPLEFT", frame, "TOPLEFT", 34, -105)
        else
            button:SetPoint("LEFT", previousButton, "RIGHT", 8, 0)
        end

        button:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 12,
            insets = { left = 3, right = 3, top = 3, bottom = 3 },
        })

        button:SetBackdropColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.75)
        button:SetBackdropBorderColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.55)

        local glass = button:CreateTexture(nil, "BORDER")
        glass:SetPoint("TOPLEFT", button, "TOPLEFT", 5, -5)
        glass:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -5, 5)
        glass:SetColorTexture(symbol.color[1], symbol.color[2], symbol.color[3], 0.18)
        button.glass = glass

        local icon = button:CreateTexture(nil, "ARTWORK")
        icon:SetPoint("TOPLEFT", button, "TOPLEFT", 5, -5)
        icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -5, 5)
        icon:SetTexture(symbol.texture)
        button.icon = icon

        button:SetScript("OnClick", function()
            self:AddSymbol(symbol)
        end)

        button:SetScript("OnEnter", function()
            button:SetBackdropColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.88)
            button:SetBackdropBorderColor(1, 1, 1, 0.9)
        end)

        button:SetScript("OnLeave", function()
            button:SetBackdropColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.75)
            button:SetBackdropBorderColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.55)
        end)

        previousButton = button
    end

    -----------------------------------------------------------------------
    -- Action Buttons
    -----------------------------------------------------------------------

    local undoButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
    undoButton:SetSize(70, 28)
    undoButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 34, -168)
    undoButton:SetText("Undo")
    undoButton:SetScript("OnClick", function()
        self:UndoLast()
    end)

    local clearButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
    clearButton:SetSize(70, 28)
    clearButton:SetPoint("LEFT", undoButton, "RIGHT", 8, 0)
    clearButton:SetText("Clear")

    clearButton:SetScript("OnClick", function()
        self:ClearOrder()
    end)

    local chatButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
    chatButton:SetSize(120, 28)
    chatButton:SetPoint("LEFT", clearButton, "RIGHT", 8, 0)
    chatButton:SetText("Prepare Message")
    chatButton:SetScript("OnClick", function()
        self:OpenRaidChat()
    end)
end

-----------------------------------------------------------------------
-- Display Management
-----------------------------------------------------------------------

function FUA:GetDisplaySymbolText(symbol)
    if self.outputMode == "markers" then
        return symbol.displayMarker
    end

    return "[ " .. symbol.char .. " ]"
end

function FUA:UpdateDisplay()
    if self.displayText then
        self.displayText:SetText(self:GetDisplayOrderString())
    end

    if self.countText then
        self.countText:SetText(#self.order .. "/" .. self.symbolCount)
    end
end

function FUA:UpdateDisplayFont()
    if not self.displayText then
        return
    end

    if self.outputMode == "markers" then
        self.displayText:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
    else
        self.displayText:SetFont("Fonts\\FRIZQT__.TTF", 18, "OUTLINE")
    end
end
