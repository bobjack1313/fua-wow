-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: UI/MainFrame.lua
--
-- Main addon window shell.
-----------------------------------------------------------------------

local addonName, FUA = ...

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

    frame:SetSize(360, 280)

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
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })

    frame:SetBackdropColor(0.02, 0.02, 0.03, 0.70)
    frame:SetBackdropBorderColor(0.35, 0.35, 0.45, 0.85)

    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.title:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -8)
    frame.title:SetText("FUA | Midnight Falls")

    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 2, 2)
    closeButton:SetScript("OnClick", function()
        frame:Hide()
    end)

    local difficultyText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    difficultyText:SetPoint("RIGHT", closeButton, "LEFT", -6, -4)
    difficultyText:SetJustifyH("RIGHT")
    self.difficultyText = difficultyText

    local optionsButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
    optionsButton:SetSize(32, 22)
    optionsButton:SetPoint("TOPRIGHT", closeButton, "BOTTOMRIGHT", -6, -2)
    optionsButton:SetText("Opt")
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
        self.collapseButton:SetText(self.collapsed and "Expand" or "Collapse")
    end

    if self.compactClearButton then
        self.compactClearButton:SetShown(self.collapsed)
    end

    if self.fullControlsFrame then
        self.fullControlsFrame:SetShown(not self.collapsed)
    end

    if self.collapsed then
        self.frame:SetSize(360, 200)
    else
        self.frame:SetSize(360, 280)
    end

    if self.divider then
        self.divider:ClearAllPoints()
        self.divider:SetPoint("LEFT", self.frame, "LEFT", 10, 0)
        self.divider:SetPoint("RIGHT", self.frame, "RIGHT", -10, 0)

        if self.collapsed then
            self.divider:SetPoint("BOTTOM", self.frame, "BOTTOM", 10, 0)
        else
            self.divider:SetPoint("BOTTOM", self.frame, "BOTTOM", 10, 80)
        end

        self.divider:SetHeight(1)
    end

    if self.divider then
        self.divider:SetShown(not self.collapsed)
    end

end

function FUA:CreateDivider()

    local divider = self.frame:CreateTexture(nil, "BORDER")

    divider:SetColorTexture(0.55, 0.55, 0.65, 0.35)
    divider:SetPoint("LEFT", self.frame, "LEFT", 10, 0)
    divider:SetPoint("RIGHT", self.frame, "RIGHT", -10, 0)
    divider:SetPoint("BOTTOM", self.frame, "BOTTOM", 10, 80)
    divider:SetHeight(1)

    self.divider = divider
end

function FUA:ToggleCollapsed()
    self.collapsed = not self.collapsed
    FUADB.collapsed = self.collapsed

    self:ApplyCollapsedState()
end

