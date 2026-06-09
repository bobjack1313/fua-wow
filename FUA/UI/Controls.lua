-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: UI/Controls.lua
--
-- Input buttons, action buttons, and display helpers.
-----------------------------------------------------------------------

local addonName, FUA = ...

function FUA:CreateControls()
    local frame = self.frame

    -----------------------------------------------------------------------
    -- Compact Order Preview
    -----------------------------------------------------------------------

    local displayBox = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    displayBox:SetSize(180, 25)
    displayBox:SetPoint("TOPLEFT", self.divider, "BOTTOMLEFT", -20, -6)
    displayBox:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 10,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    displayBox:SetBackdropColor(0, 0, 0, 0.38)
    displayBox:SetBackdropBorderColor(0.5, 0.5, 0.6, 0.38)
    self.displayBox = displayBox

    local displayText = displayBox:CreateFontString(nil, "OVERLAY")
    displayText:SetPoint("CENTER", displayBox, "CENTER", 0, 0)
    displayText:SetFont("Fonts\\FRIZQT__.TTF", 8, "OUTLINE")
    displayText:SetTextColor(1, 0.82, 0)
    self.displayText = displayText

    -----------------------------------------------------------------------
    -- Symbol Selection Buttons
    -----------------------------------------------------------------------

    local runeSize = 32
    local runeGap = 5
    local leftX = 20
    local bottomY = 16
    local previousButton

    for i, symbol in ipairs(self.symbols) do
        local button = CreateFrame("Button", nil, frame, "BackdropTemplate")
        button:SetSize(runeSize, runeSize)

        if i == 1 then
            button:SetPoint("TOPLEFT", displayBox, "BOTTOMLEFT", 0, -4)
        else
            button:SetPoint("LEFT", previousButton, "RIGHT", runeGap, 0)
        end

        button:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 10,
            insets = { left = 3, right = 3, top = 3, bottom = 3 },
        })

        button:SetBackdropColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.75)
        button:SetBackdropBorderColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.55)

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
            button:SetBackdropBorderColor(1, 1, 1, 0.95)
        end)

        button:SetScript("OnLeave", function()
            button:SetBackdropColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.55)
            button:SetBackdropBorderColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.45)
        end)

        previousButton = button
    end

    -----------------------------------------------------------------------
    -- Action Buttons
    -----------------------------------------------------------------------

    local undoButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
    undoButton:SetSize(70, 26)
    undoButton:SetPoint("BOTTOMLEFT", self.divider, "BOTTOMLEFT", 180, -34)
    undoButton:SetText("Undo")
    undoButton:SetScript("OnClick", function()
        self:UndoLast()
    end)

    local clearButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
    clearButton:SetSize(70, 26)
    clearButton:SetPoint("LEFT", undoButton, "RIGHT", 6, 0)
    clearButton:SetText("Clear")
    clearButton:SetScript("OnClick", function()
        self:ClearOrder()
    end)

    local chatButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
    chatButton:SetSize(146, 30)
    chatButton:SetPoint("TOPLEFT", undoButton, "BOTTOMLEFT", 0, -4)
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

    self:UpdatePositionLayout()
    self:UpdatePositionSlots()
end

function FUA:UpdateDisplayFont()
    if not self.displayText then
        return
    end

    if self.outputMode == "markers" then
        self.displayText:SetFont("Fonts\\FRIZQT__.TTF", 8, "OUTLINE")
    else
        self.displayText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    end
end
