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

    if self.showOnLogin then
        self.frame:Show()
    else
        self.frame:Hide()
    end
end

function FUA:CreateMainFrame()
    local frame = CreateFrame("Frame", "FUAFrame", UIParent, "BackdropTemplate")
    self.frame = frame

    frame:SetSize(400, 260)

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

    frame:SetBackdropColor(0.02, 0.02, 0.03, 0.62)
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
    optionsButton:SetPoint("TOPRIGHT", closeButton, "BOTTOMRIGHT", -4, -2)
    optionsButton:SetText("Opt")
    optionsButton:SetScript("OnClick", function()
        self:ToggleOptionsWindow()
    end)
    self.optionsButton = optionsButton
end

function FUA:CreateDivider()

    local divider = self.frame:CreateTexture(nil, "BORDER")

    divider:SetColorTexture(0.55, 0.55, 0.65, 0.35)
    divider:SetSize(320, 1)
    divider:SetPoint("TOP", self.diagramFrame, "BOTTOM", 0, 0)

    self.divider = divider
end
