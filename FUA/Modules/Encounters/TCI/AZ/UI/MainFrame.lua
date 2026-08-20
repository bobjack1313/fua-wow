-----------------------------------------------------------------------
-- FUA - Azta'rec Intermission Tracker
-- File: Modules/Encounters/TCI/AZ/UI/MainFrame.lua
--
-- Main addon window shell for the Azta'rec module.
-----------------------------------------------------------------------

local addonName, FUA = ...

local AZ = FUA.AZ
local UI = AZ.UI

-----------------------------------------------------------------------
-- UI Creation
-----------------------------------------------------------------------

function AZ:CreateUI()
    self:CreateMainFrame()
    self:CreateDiagram()
    self:CreateDivider()
    self:CreateControls()
    self:UpdateDisplay()

    if self.showOnLogin then
        self.frame:Show()
    else
        self.frame:Hide()
    end
end

-----------------------------------------------------------------------
-- Main Frame
-----------------------------------------------------------------------

function AZ:CreateMainFrame()
    local frame = CreateFrame(
        "Frame",
        "FUAAztaRecFrame",
        UIParent,
        "BackdropTemplate"
    )

    self.frame = frame

    frame:SetSize(
        UI.FRAME_WIDTH,
        UI.FRAME_HEIGHT
    )

    -------------------------------------------------------------------
    -- Saved Position
    -------------------------------------------------------------------

    FUADB.aztarec = FUADB.aztarec or {}

    if FUADB.aztarec.position then
        frame:SetPoint(
            FUADB.aztarec.position.point or "CENTER",
            UIParent,
            FUADB.aztarec.position.relativePoint or "CENTER",
            FUADB.aztarec.position.x or 0,
            FUADB.aztarec.position.y or 0
        )
    else
        frame:SetPoint("CENTER")
    end

    -------------------------------------------------------------------
    -- Movement
    -------------------------------------------------------------------

    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")

    frame:SetScript("OnDragStart", function(selfFrame)
        selfFrame:StartMoving()
    end)

    frame:SetScript("OnDragStop", function(selfFrame)
        selfFrame:StopMovingOrSizing()

        local point, _, relativePoint, xOfs, yOfs =
            selfFrame:GetPoint()

        FUADB.aztarec.position = {
            point = point,
            relativePoint = relativePoint,
            x = xOfs,
            y = yOfs,
        }
    end)

    -------------------------------------------------------------------
    -- Visibility State
    -------------------------------------------------------------------

    frame:SetScript("OnShow", function()
        FUADB.aztarec.showOnLogin = true
    end)

    frame:SetScript("OnHide", function()
        FUADB.aztarec.showOnLogin = false
    end)

    -------------------------------------------------------------------
    -- Appearance
    -------------------------------------------------------------------

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

    frame:SetBackdropColor(
        unpack(FUA.Colors.FRAME_BACKGROUND)
    )

    frame:SetBackdropBorderColor(
        unpack(FUA.Colors.FRAME_BORDER)
    )

    -------------------------------------------------------------------
    -- Title
    -------------------------------------------------------------------

    local title = frame:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontHighlight"
    )

    title:SetPoint(
        "TOPLEFT",
        frame,
        "TOPLEFT",
        UI.FRAME_TITLE_X,
        UI.FRAME_TITLE_Y
    )

    title:SetText(FUA.L.AZ_TITLE)
    frame.title = title

    -------------------------------------------------------------------
    -- Close Button
    -------------------------------------------------------------------

    local closeButton = CreateFrame(
        "Button",
        nil,
        frame,
        "UIPanelCloseButton"
    )

    closeButton:SetPoint(
        "TOPRIGHT",
        frame,
        "TOPRIGHT",
        UI.CLOSE_BUTTON_X,
        UI.CLOSE_BUTTON_Y
    )

    closeButton:SetScript("OnClick", function()
        frame:Hide()
    end)
end

-----------------------------------------------------------------------
-- Divider
-----------------------------------------------------------------------

function AZ:CreateDivider()
    local divider = self.frame:CreateTexture(
        nil,
        "BORDER"
    )

    divider:SetColorTexture(
        unpack(FUA.Colors.DIVIDER)
    )

    divider:SetPoint(
        "LEFT",
        self.frame,
        "LEFT",
        UI.DIVIDER_MARGIN_X,
        UI.DIVIDER_EXPANDED_Y
    )

    divider:SetPoint(
        "RIGHT",
        self.frame,
        "RIGHT",
        -UI.DIVIDER_MARGIN_X,
        UI.DIVIDER_EXPANDED_Y
    )

    divider:SetPoint(
        "BOTTOM",
        self.frame,
        "BOTTOM",
        0,
        UI.DIVIDER_EXPANDED_Y
    )

    divider:SetHeight(UI.DIVIDER_HEIGHT)

    self.divider = divider
end
