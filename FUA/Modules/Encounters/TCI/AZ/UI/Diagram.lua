-----------------------------------------------------------------------
-- FUA - Azta'rec Intermission Tracker
-- File: Modules/Encounters/TCI/AZ/UI/Diagram.lua
--
-- Large five-position memory display.
--
-- Displays symbols in the exact order they were entered.
-----------------------------------------------------------------------

local addonName, FUA = ...

local AZ = FUA.AZ
local UI = AZ.UI

function AZ:CreateDiagram()
    local frame = self.frame

    local diagram = CreateFrame(
        "Frame",
        nil,
        frame,
        "BackdropTemplate"
    )

    diagram:SetSize(
        UI.DIAGRAM_FRAME_WIDTH,
        UI.DIAGRAM_FRAME_HEIGHT
    )

    diagram:SetPoint(
        "TOP",
        frame,
        "TOP",
        UI.DIAGRAM_FRAME_X,
        UI.DIAGRAM_FRAME_Y
    )

    self.diagramFrame = diagram

    -------------------------------------------------------------------
    -- Diagram Label
    -------------------------------------------------------------------

    local label = diagram:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontNormal"
    )

    label:SetPoint(
        "TOP",
        diagram,
        "TOP",
        UI.DIAGRAM_LABEL_X,
        UI.DIAGRAM_LABEL_Y
    )

    label:SetText(FUA.L.AZ_MEMORY_ORDER)
    self.diagramLabel = label

    -------------------------------------------------------------------
    -- Memory Position Slots
    -------------------------------------------------------------------

    self.positionFrames = {}

    local previousSlot

    for position = 1, 5 do
        local slot = self:CreatePositionSlot(
            diagram,
            position
        )

        if position == 1 then
            slot:SetPoint(
                "LEFT",
                diagram,
                "LEFT",
                UI.SLOT_START_X,
                UI.SLOT_Y
            )
        else
            slot:SetPoint(
                "LEFT",
                previousSlot,
                "RIGHT",
                UI.SLOT_GAP,
                0
            )
        end

        self.positionFrames[position] = slot
        previousSlot = slot
    end
end

function AZ:CreatePositionSlot(parent, position)
    local slot = CreateFrame(
        "Frame",
        nil,
        parent,
        "BackdropTemplate"
    )

    slot:SetSize(
        UI.SLOT_WIDTH,
        UI.SLOT_HEIGHT
    )

    slot.position = position

    slot:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = UI.SLOT_BD_EDGE,
        insets = {
            left = UI.SLOT_BD_INSET,
            right = UI.SLOT_BD_INSET,
            top = UI.SLOT_BD_INSET,
            bottom = UI.SLOT_BD_INSET
        },
    })


    slot:SetBackdropColor(
        unpack(FUA.Colors.DIAGRAM_SLOT_BACKGROUND)
    )

    slot:SetBackdropBorderColor(
        unpack(FUA.Colors.AZ_DIAGRAM_SLOT_BORDER)
    )

    -------------------------------------------------------------------
    -- Position Number
    -------------------------------------------------------------------

    local number = slot:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontNormalSmall"
    )

    number:SetPoint(
        "TOP",
        slot,
        "TOP",
        UI.SLOT_NUMBER_X,
        UI.SLOT_NUMBER_Y
    )

    number:SetText(position)
    slot.numberText = number

    -------------------------------------------------------------------
    -- Symbol Icon
    -------------------------------------------------------------------

    local icon = slot:CreateTexture(
        nil,
        "ARTWORK"
    )

    icon:SetSize(
        UI.SLOT_ICON_SIZE,
        UI.SLOT_ICON_SIZE
    )

    icon:SetPoint(
        "CENTER",
        slot,
        "CENTER",
        UI.SLOT_ICON_X,
        UI.SLOT_ICON_Y
    )

    icon:Hide()
    slot.icon = icon

    return slot
end

function AZ:UpdatePositionSlots()
    if not self.positionFrames then
        return
    end

    for position = 1, 5 do
        local slot = self.positionFrames[position]
        local symbol = self.order[position]

        if symbol then
            slot.icon:SetTexture(
                "Interface\\TargetingFrame\\UI-RaidTargetingIcon_" .. symbol.raidIcon
            )
            slot.icon:SetTexCoord(0, 1, 0, 1)
            slot.icon:Show()

            slot:SetBackdropBorderColor(
                symbol.color[1],
                symbol.color[2],
                symbol.color[3],
                UI.SLOT_BORDER_ALPHA
            )
        else
            slot.icon:Hide()

            slot:SetBackdropBorderColor(
                unpack(FUA.Colors.DIAGRAM_SLOT_BORDER)
            )
        end
    end
end
