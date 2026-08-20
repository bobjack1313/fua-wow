-----------------------------------------------------------------------
-- FUA - Azta'rec Intermission Tracker
-- File: Modules/Encounters/TCI/AZ/UI/Controls.lua
--
-- Input buttons, action buttons, and display helpers.
-----------------------------------------------------------------------

local addonName, FUA = ...

local AZ = FUA.AZ
local UI = AZ.UI

function AZ:CreateControls()
    local frame = self.frame

    -----------------------------------------------------------------------
    -- Full Controls Container
    -----------------------------------------------------------------------

    local fullControlsFrame = CreateFrame("Frame", nil, frame)
    fullControlsFrame:SetSize(UI.CONTROLS_FRAME_WIDTH, UI.CONTROLS_FRAME_HEIGHT)
    fullControlsFrame:SetPoint("TOP", self.divider, "BOTTOM", UI.CONTROLS_FRAME_X, UI.CONTROLS_FRAME_Y)
    self.fullControlsFrame = fullControlsFrame

    -----------------------------------------------------------------------
    -- Symbol Selection Buttons
    -----------------------------------------------------------------------

    local previousButton

    for i, symbol in ipairs(self.symbols) do
        local button = CreateFrame("Button", nil, fullControlsFrame, "BackdropTemplate")
        button:SetSize(UI.RUNE_SIZE, UI.RUNE_SIZE)

        if i == 1 then
            button:SetPoint(
                "TOPLEFT",
                fullControlsFrame,
                "TOPLEFT",
                UI.RUNE_BUTTON_X,
                UI.RUNE_BUTTON_Y_1
            )
        else
            button:SetPoint(
                "LEFT",
                previousButton,
                "RIGHT",
                UI.RUNE_GAP,
                UI.RUNE_BUTTON_Y
            )
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
        icon:SetTexture(
            "Interface\\TargetingFrame\\UI-RaidTargetingIcon_" .. symbol.raidIcon
        )
        button.icon = icon

        button:SetScript("OnClick", function()
            self:AddSymbol(symbol)
        end)

        button:SetScript("OnEnter", function()
            button:SetBackdropColor(symbol.color[1], symbol.color[2], symbol.color[3], UI.RUNE_ICON_BD1_ALPHA)
            button:SetBackdropBorderColor(
                unpack(FUA.Colors.BUTTON_SELECTED_BORDER)
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

    local undoButton = CreateFrame(
        "Button",
        nil,
        fullControlsFrame,
        "GameMenuButtonTemplate"
    )

    undoButton:SetSize(
        UI.UNDO_BUTTON_WIDTH,
        UI.UNDO_BUTTON_HEIGHT
    )

    undoButton:SetPoint(
        "TOPRIGHT",
        fullControlsFrame,
        "TOPRIGHT",
        UI.UNDO_BUTTON_X,
        UI.UNDO_BUTTON_Y
    )

    undoButton:SetText(FUA.L.UNDO)

    undoButton:SetScript("OnClick", function()
        self:UndoLast()
    end)

    local clearButton = CreateFrame(
        "Button",
        nil,
        fullControlsFrame,
        "GameMenuButtonTemplate"
    )

    clearButton:SetSize(
        UI.CLEAR_BUTTON_WIDTH,
        UI.CLEAR_BUTTON_HEIGHT
    )

    clearButton:SetPoint(
        "TOPLEFT",
        undoButton,
        "BOTTOMLEFT",
        0,
        UI.CLEAR_BUTTON_Y
    )

    clearButton:SetText(FUA.L.CLEAR)

    clearButton:SetScript("OnClick", function()
        self:ClearOrder()
    end)
end

-----------------------------------------------------------------------
-- Display Management
-----------------------------------------------------------------------

function AZ:UpdateDisplay()
    if self.countText then
        self.countText:SetText(
            #self.order .. "/" .. self.symbolCount
        )
    end

    self:UpdatePositionSlots()
end

