-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Modules/Encounters/MFQ/MF/UI/MainFrame.lua
--
-- Main addon window shell for Midnight Falls module.
-----------------------------------------------------------------------

local addonName, FUA = ...

local UI = FUA.MF.UI

function FUA:CreateUI()
    self:CreateMainFrame()
    self:CreateDiagram()
    self:CreateDivider()
    self:CreateControls()
    self:CreateOptionsWindow()

    self:UpdateDifficulty()
    self:UpdateDisplayFont()
    self:UpdateDisplay()
    self:ApplyCollapsedState()

    if self.showOnLogin then
        self.frame:Show()
    else
        self.frame:Hide()
    end
end

function FUA:CreateMainFrame()
    local frame = CreateFrame("Frame", "FUAFrame", UIParent, "BackdropTemplate")
    self.frame = frame

    frame:SetSize(UI.FRAME_WIDTH, UI.FRAME_HEIGHT)

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

    frame:SetScript("OnDragStop", function(selfFrame)
        selfFrame:StopMovingOrSizing()

        local point, _, relativePoint, xOfs, yOfs = selfFrame:GetPoint()
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
        edgeSize = UI.BACKDROP_EDGE,
        insets = {
            left = UI.BACKDROP_INSET,
            right = UI.BACKDROP_INSET,
            top = UI.BACKDROP_INSET,
            bottom = UI.BACKDROP_INSET
        },
    })

    frame:SetBackdropColor(unpack(self.Colors.FRAME_BACKGROUND))
    frame:SetBackdropBorderColor(unpack(self.Colors.FRAME_BORDER))

    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.title:SetPoint("TOPLEFT", frame, "TOPLEFT", UI.FRAME_TITLE_X , UI.FRAME_TITLE_Y)
    frame.title:SetText(self.L.MF_TITLE)

    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", UI.CLOSE_BUTTON_X, UI.CLOSE_BUTTON_Y)
    closeButton:SetScript("OnClick", function()
        frame:Hide()
    end)

    local difficultyText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    difficultyText:SetPoint("RIGHT", closeButton, "LEFT", UI.DIFFICULTY_TEXT_X, UI.DIFFICULTY_TEXT_Y)
    difficultyText:SetJustifyH("RIGHT")
    self.difficultyText = difficultyText

    local optionsButton = CreateFrame("Button", nil, frame)
    optionsButton:SetSize(UI.OPTIONS_BUTTON_WIDTH, UI.OPTIONS_BUTTON_HEIGHT)
    optionsButton:SetPoint(
        "TOPRIGHT",
        closeButton,
        "BOTTOMRIGHT",
        UI.OPTIONS_BUTTON_X,
        UI.OPTIONS_BUTTON_Y
    )

    local optionsIcon = optionsButton:CreateTexture(nil, "ARTWORK")
    optionsIcon:SetSize(UI.OPTIONS_BUTTON_ICON_SIZE, UI.OPTIONS_BUTTON_ICON_SIZE)
    optionsIcon:SetPoint("CENTER")
    optionsIcon:SetTexture("Interface\\AddOns\\FUA\\Textures\\Core\\gold_gear_icon.png")

    optionsButton.icon = optionsIcon

    optionsButton:SetScript("OnEnter", function()
        optionsIcon:SetVertexColor(unpack(self.Colors.OPTIONS_BUTTON_VERT))
    end)

    optionsButton:SetScript("OnLeave", function()
        optionsIcon:SetVertexColor(unpack(self.Colors.OPTIONS_BUTTON_VERT_LEAVE))
    end)

    optionsButton:SetScript("OnClick", function()
        self:ToggleOptionsWindow()
    end)

    self.optionsButton = optionsButton
end

function FUA:ApplyCollapsedState()
    if not self.frame then
        return
    end

    if self.collapseButton then
        self.collapseButton:SetText(self.collapsed and self.L.EXPAND or self.L.COLLAPSE)
    end

    if self.compactClearButton then
        self.compactClearButton:SetShown(self.collapsed)
    end

    if self.fullControlsFrame then
        self.fullControlsFrame:SetShown(not self.collapsed)
    end

    if self.collapsed then
        self.frame:SetSize(UI.FRAME_WIDTH, UI.FRAME_COLLAPSED_HEIGHT)
    else
        self.frame:SetSize(UI.FRAME_WIDTH, UI.FRAME_HEIGHT)
    end

    if self.divider then
        self.divider:ClearAllPoints()
        self.divider:SetPoint("LEFT", self.frame, "LEFT", UI.DIVIDER_MARGIN_X, UI.DIVIDER_COLLAPSED_Y)
        self.divider:SetPoint("RIGHT", self.frame, "RIGHT", -UI.DIVIDER_MARGIN_X, UI.DIVIDER_COLLAPSED_Y)

        if self.collapsed then
            self.divider:SetPoint("BOTTOM", self.frame, "BOTTOM", UI.DIVIDER_MARGIN_X, UI.DIVIDER_COLLAPSED_Y)
        else
            self.divider:SetPoint("BOTTOM", self.frame, "BOTTOM", UI.DIVIDER_MARGIN_X, UI.DIVIDER_EXPANDED_Y)
        end

        self.divider:SetHeight(UI.DIVIDER_HEIGHT)
    end

    if self.divider then
        self.divider:SetShown(not self.collapsed)
    end

end

function FUA:CreateDivider()

    local divider = self.frame:CreateTexture(nil, "BORDER")

    divider:SetColorTexture(unpack(self.Colors.DIVIDER))
    divider:SetPoint("LEFT", self.frame, "LEFT", UI.DIVIDER_MARGIN_X, UI.DIVIDER_COLLAPSED_Y)
    divider:SetPoint("RIGHT", self.frame, "RIGHT", -UI.DIVIDER_MARGIN_X, UI.DIVIDER_COLLAPSED_Y)
    divider:SetPoint("BOTTOM", self.frame, "BOTTOM", UI.DIVIDER_MARGIN_X, UI.DIVIDER_EXPANDED_Y)
    divider:SetHeight(UI.DIVIDER_HEIGHT)

    self.divider = divider
end

function FUA:ToggleCollapsed()
    self.collapsed = not self.collapsed
    FUADB.collapsed = self.collapsed

    self:ApplyCollapsedState()
end
