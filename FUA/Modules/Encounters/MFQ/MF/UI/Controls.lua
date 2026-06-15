-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Modules/Encounters/MFQ/MF/UI/Controls.lua
--
-- Input buttons, action buttons, and display helpers.
-----------------------------------------------------------------------

local addonName, FUA = ...

local UI = FUA.MF.UI

function FUA:CreateControls()
    local frame = self.frame

    -----------------------------------------------------------------------
    -- Compact Controls
    -----------------------------------------------------------------------

    local compactControlsFrame = CreateFrame("Frame", nil, frame)
    compactControlsFrame:SetSize(UI.COMP_CONTROLS_FRAME_WIDTH, UI.COMP_CONTROLS_FRAME_HEIGHT)
    compactControlsFrame:SetPoint("BOTTOM", self.divider, "TOP", UI.COMP_CONTROLS_FRAME_X, UI.COMP_CONTROLS_FRAME_Y)
    self.compactControlsFrame = compactControlsFrame

    local collapseButton = CreateFrame("Button", nil, compactControlsFrame, "GameMenuButtonTemplate")
    collapseButton:SetSize(UI.COLLAPSE_BUTTON_WIDTH, UI.COLLAPSE_BUTTON_HEIGHT)
    collapseButton:SetPoint("LEFT", compactControlsFrame, "LEFT", UI.COLLAPSE_BUTTON_X, UI.COLLAPSE_BUTTON_Y)
    collapseButton:SetText(self.collapsed and self.L.EXPAND or self.L.COLLAPSE)
    collapseButton:SetScript("OnClick", function()
        self:ToggleCollapsed()
    end)
    self.collapseButton = collapseButton

    local compactClearButton = CreateFrame("Button", nil, compactControlsFrame, "GameMenuButtonTemplate")
    compactClearButton:SetSize(UI.COMP_CLEAR_BUTTON_WIDTH, UI.COMP_CLEAR_BUTTON_HEIGHT)
    compactClearButton:SetPoint("RIGHT", compactControlsFrame, "RIGHT", UI.COMP_CLEAR_BUTTON_X, UI.COMP_CLEAR_BUTTON_Y)
    compactClearButton:SetText(self.L.CLEAR)
    compactClearButton:SetScript("OnClick", function()
        self:ClearOrder()
    end)
    self.compactClearButton = compactClearButton

    -----------------------------------------------------------------------
    -- Full Controls Container
    -----------------------------------------------------------------------

    local fullControlsFrame = CreateFrame("Frame", nil, frame)
    fullControlsFrame:SetSize(UI.CONTROLS_FRAME_WIDTH, UI.CONTROLS_FRAME_HEIGHT)
    fullControlsFrame:SetPoint("TOP", self.divider, "BOTTOM", UI.CONTROLS_FRAME_X, UI.CONTROLS_FRAME_Y)
    self.fullControlsFrame = fullControlsFrame

    -----------------------------------------------------------------------
    -- Compact Order Preview
    -----------------------------------------------------------------------
    local displayBox = CreateFrame("Frame", nil, fullControlsFrame, "BackdropTemplate")
    displayBox:SetSize(UI.DISPLAY_BOX_WIDTH, UI.DISPLAY_BOX_HEIGHT)
    displayBox:SetPoint("TOPLEFT", fullControlsFrame, "TOPLEFT", UI.DISPLAY_BOX_X, UI.DISPLAY_BOX_Y)

    displayBox:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = UI.DISPLAY_BOX_BD_EDGE,
        insets = {
            left = UI.DISPLAY_BOX_BD_INSET,
            right = UI.DISPLAY_BOX_BD_INSET,
            top = UI.DISPLAY_BOX_BD_INSET,
            bottom = UI.DISPLAY_BOX_BD_INSET
        },
    })
    displayBox:SetBackdropColor(unpack(self.Colors.DISPLAY_BACKGROUND))
    displayBox:SetBackdropBorderColor(unpack(self.Colors.DISPLAY_BORDER))
    self.displayBox = displayBox

    local displayText = displayBox:CreateFontString(nil, "OVERLAY")
    displayText:SetPoint("CENTER", displayBox, "CENTER", UI.DISPLAY_TEXT_X, UI.DISPLAY_TEXT_Y)
    displayText:SetFont("Fonts\\FRIZQT__.TTF", UI.CONTROLS_FONT_SIZE_MARK, "OUTLINE")
    displayText:SetTextColor(unpack(self.Colors.DISPLAY_TEXT))
    self.displayText = displayText

    -----------------------------------------------------------------------
    -- Symbol Selection Buttons
    -----------------------------------------------------------------------

    local previousButton

    for i, symbol in ipairs(self.symbols) do
        local button = CreateFrame("Button", nil, fullControlsFrame, "BackdropTemplate")
        button:SetSize(UI.RUNE_SIZE, UI.RUNE_SIZE)

        if i == 1 then
            button:SetPoint("TOPLEFT", displayBox, "BOTTOMLEFT", UI.RUNE_BUTTON_X, UI.RUNE_BUTTON_Y_1)
        else
            button:SetPoint("LEFT", previousButton, "RIGHT", UI.RUNE_GAP, UI.RUNE_BUTTON_Y)
        end

        button:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = UI.RUNE_BUTTON_BD_EDGE,
            insets = {
                left = UI.RUNE_BUTTON_BD_INSET,
                right = UI.RUNE_BUTTON_BD_INSET,
                top = UI.RUNE_BUTTON_BD_INSET,
                bottom = UI.RUNE_BUTTON_BD_INSET
            },
        })

        button:SetBackdropColor(symbol.color[1], symbol.color[2], symbol.color[3], UI.RUNE_BD_ALPHA)
        button:SetBackdropBorderColor(symbol.color[1], symbol.color[2], symbol.color[3], UI.RUNE_BD_BORDER_ALPHA)

        local icon = button:CreateTexture(nil, "ARTWORK")
        icon:SetPoint("TOPLEFT", button, "TOPLEFT", UI.RUNE_ICON_TOP_X, UI.RUNE_ICON_TOP_Y)
        icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", UI.RUNE_ICON_BOTTOM_X, UI.RUNE_ICON_BOTTOM_Y)
        icon:SetTexture(symbol.texture)
        button.icon = icon

        button:SetScript("OnClick", function()
            self:AddSymbol(symbol)
        end)

        button:SetScript("OnEnter", function()
            button:SetBackdropColor(symbol.color[1], symbol.color[2], symbol.color[3], UI.RUNE_ICON_BD1_ALPHA)
            button:SetBackdropBorderColor(
                unpack(self.Colors.BUTTON_SELECTED_BORDER)
            )
        end)

        button:SetScript("OnLeave", function()
            button:SetBackdropColor(symbol.color[1], symbol.color[2], symbol.color[3], UI.RUNE_ICON_BD2_ALPHA)
            button:SetBackdropBorderColor(symbol.color[1], symbol.color[2], symbol.color[3], UI.RUNE_ICON_BD_BORDER_ALPHA)
        end)

        self.symbolButtons = self.symbolButtons or {}
        table.insert(self.symbolButtons, button)

        previousButton = button
    end

    -----------------------------------------------------------------------
    -- Action Buttons
    -----------------------------------------------------------------------

    local undoButton = CreateFrame("Button", nil, fullControlsFrame, "GameMenuButtonTemplate")
    undoButton:SetSize(UI.UNDO_BUTTON_WIDTH, UI.UNDO_BUTTON_HEIGHT)
    undoButton:SetPoint("TOPRIGHT", fullControlsFrame, "TOPRIGHT", UI.UNDO_BUTTON_X, UI.UNDO_BUTTON_Y)
    undoButton:SetText(self.L.UNDO)
    undoButton:SetScript("OnClick", function()
        self:UndoLast()
    end)

    local clearButton = CreateFrame("Button", nil, fullControlsFrame, "GameMenuButtonTemplate")
    clearButton:SetSize(UI.CLEAR_BUTTON_WIDTH, UI.CLEAR_BUTTON_HEIGHT)
    clearButton:SetPoint("LEFT", undoButton, "RIGHT", UI.CLEAR_BUTTON_X, UI.CLEAR_BUTTON_Y)
    clearButton:SetText(self.L.CLEAR)
    clearButton:SetScript("OnClick", function()
        self:ClearOrder()
    end)

    local chatButton = CreateFrame("Button", nil, fullControlsFrame, "GameMenuButtonTemplate")
    chatButton:SetSize(UI.CHAT_BUTTON_WIDTH, UI.CHAT_BUTTON_HEIGHT)
    chatButton:SetPoint("TOPLEFT", undoButton, "BOTTOMLEFT", UI.CHAT_BUTTON_X, UI.CHAT_BUTTON_Y)
    chatButton:SetText(self.L.PREPARE_MESSAGE)
    chatButton:SetScript("OnClick", function()
        self:OpenRaidChat()
    end)
    self.chatButton = chatButton
end

-----------------------------------------------------------------------
-- Display Management
-----------------------------------------------------------------------

function FUA:UpdateChatButtonText()
    if not self.chatButton then
        return
    end

    -- Not working as expected
    self.chatButton:SetText(
        self:IsSecureEncounterCombat()
            and self.L.PREPARE_MESSAGE
            or self.L.PREPARE_MESSAGE
    )
end

function FUA:UpdateDisplay()
    if self.displayText then
        self.displayText:SetText(self:GetDisplayOrderString())
    end

    if self.countText then
        self.countText:SetText(#self.order .. "/" .. self.symbolCount)
    end

    self:UpdateChatButtonText()
    self:UpdatePositionLayout()
    self:UpdatePositionSlots()
end

function FUA:UpdateDisplayFont()
    if not self.displayText then
        return
    end

    if self.outputMode == "markers" then
        self.displayText:SetFont("Fonts\\FRIZQT__.TTF", UI.CONTROLS_FONT_SIZE_MARK, "OUTLINE")
    else
        self.displayText:SetFont("Fonts\\FRIZQT__.TTF", UI.CONTROLS_FONT_SIZE_CHAR, "OUTLINE")
    end
end
