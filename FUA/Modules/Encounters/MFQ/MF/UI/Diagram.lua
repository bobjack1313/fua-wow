-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Modules/Encounters/MFQ/MF/UI/Diagram.lua
--
-- Static fight diagram and assignment position slots.
-----------------------------------------------------------------------

local addonName, FUA = ...

local UI = FUA.MF.UI

function FUA:CreateDiagram()
    local frame = self.frame

    local diagram = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    diagram:SetSize(UI.DIAGRAM_FRAME_WIDTH, UI.DIAGRAM_FRAME_HEIGHT)
    diagram:SetPoint("TOP", frame, "TOP", UI.DIAGRAM_FRAME_X, UI.DIAGRAM_FRAME_Y)
    self.diagramFrame = diagram

    local luraPlate = CreateFrame("Frame", nil, diagram, "BackdropTemplate")
    luraPlate:SetSize(UI.LURA_PLATE_WIDTH, UI.LURA_PLATE_HEIGHT)
    luraPlate:SetPoint("CENTER", diagram, "CENTER", UI.LURA_PLATE_X, UI.LURA_PLATE_Y)
    luraPlate:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = UI.LURA_PLATE_BD_EDGE,
        insets = {
            left = UI.LURA_PLATE_BD_INSET,
            right = UI.LURA_PLATE_BD_INSET,
            top = UI.LURA_PLATE_BD_INSET,
            bottom = UI.LURA_PLATE_BD_INSET
        },
    })
    luraPlate:SetBackdropColor(unpack(self.Colors.LURA_BACKGROUND))
    luraPlate:SetBackdropBorderColor(unpack(self.Colors.LURA_BORDER))
    self.luraPlate = luraPlate

    local luraTexture = luraPlate:CreateTexture(nil, "ARTWORK")
    luraTexture:SetPoint("TOPLEFT", luraPlate, "TOPLEFT", UI.LURA_ICON_TOP_X, UI.LURA_ICON_TOP_Y)
    luraTexture:SetPoint("BOTTOMRIGHT", luraPlate, "BOTTOMRIGHT", UI.LURA_ICON_BOTTOM_X, UI.LURA_ICON_BOTTOM_Y)
    luraTexture:SetTexture("Interface\\AddOns\\FUA\\Textures\\Encounters\\MFQ\\MF\\lura.png")

    self.luraTexture = luraTexture

    self.positionFrames = {}

    for position = 1, 5 do
        local offset = UI.POSITION_LAYOUT_5[position]
        self.positionFrames[position] = self:CreatePositionSlot(diagram, position, offset.x, offset.y)
    end
end

function FUA:CreatePositionSlot(parent, position, x, y)
    local slot = CreateFrame("Button", nil, parent, "BackdropTemplate")
    slot:SetSize(UI.SLOT_SIZE, UI.SLOT_SIZE)
    slot:SetPoint("CENTER", parent, "CENTER", x, y)
    slot.position = position

    slot:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = UI.SLOT_BD_EDGE,
        insets = {
            left = UI.SLOT_BD_INSET,
            right = UI.SLOT_BD_INSET,
            top = UI.SLOT_BD_INSET,
            bottom = UI.SLOT_BD_INSET
        },
    })
    slot:SetBackdropColor(unpack(self.Colors.DIAGRAM_SLOT_BACKGROUND))
    slot:SetBackdropBorderColor(unpack(self.Colors.DIAGRAM_SLOT_BORDER))

    local number = slot:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    number:SetPoint("TOP", slot, "TOP", UI.SLOT_NUMBER_X, UI.SLOT_NUMBER_Y)
    number:SetText(position)
    slot.numberText = number

    local icon = slot:CreateTexture(nil, "ARTWORK")
    icon:SetSize(UI.SLOT_ICON_SIZE, UI.SLOT_ICON_SIZE)
    icon:SetPoint("CENTER", slot, "CENTER", UI.SLOT_ICON_X, UI.SLOT_ICON_Y)
    icon:Hide()
    slot.icon = icon

    slot:SetScript("OnClick", function()
        self.myPosition = position
        self:UpdateDisplay()
    end)

    return slot
end

function FUA:UpdatePositionSlots()
    if not self.positionFrames then
        return
    end

    for position, slot in pairs(self.positionFrames) do
        local symbol = self.order[position]

        if symbol then
            slot.icon:SetTexture(symbol.texture)
            slot.icon:Show()
            slot:SetBackdropBorderColor(symbol.color[1], symbol.color[2], symbol.color[3], UI.SLOT_BORDER_ALPHA)
        else
            slot.icon:Hide()
            slot:SetBackdropBorderColor(unpack(self.Colors.DIAGRAM_SLOT_BORDER))
        end

        if self.myPosition == position then
            slot:SetBackdropColor(unpack(self.Colors.DIAGRAM_SLOT_SELECTED))
        else
            slot:SetBackdropColor(unpack(self.Colors.DIAGRAM_SLOT_BACKGROUND))
        end
    end
end

function FUA:UpdatePositionLayout()
    local layout = self.symbolCount == 3 and UI.POSITION_LAYOUT_3 or UI.POSITION_LAYOUT_5

    for position = 1, 5 do
        local slot = self.positionFrames[position]
        local offset = layout[position]

        if slot and offset then
            slot:ClearAllPoints()
            slot:SetPoint("CENTER", self.diagramFrame, "CENTER", offset.x, offset.y)
            slot:Show()

            if slot.numberText then
                slot.numberText:SetText(position)
            end
        elseif slot then
            slot:Hide()
        end
    end
end
