-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: UI/Diagram.lua
--
-- Static fight diagram and assignment position slots.
-----------------------------------------------------------------------

local addonName, FUA = ...

local POSITION_LAYOUT_5 = {
    [5] = { x = -115, y =  10 },
    [1] = { x =  115, y =  10 },
    [4] = { x =  -65, y = -52 },
    [3] = { x =    0, y = -52 },
    [2] = { x =   65, y = -52 },
}

local POSITION_LAYOUT_3 = {
    [1] = { x =  72, y = -52 },
    [2] = { x =   0, y = -52 },
    [3] = { x = -72, y = -52 },
}

function FUA:CreateDiagram()
    local frame = self.frame

    local diagram = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    diagram:SetSize(360, 180)
    diagram:SetPoint("TOP", frame, "TOP", 0, 0)
    self.diagramFrame = diagram

    local luraPlate = CreateFrame("Frame", nil, diagram, "BackdropTemplate")
    luraPlate:SetSize(118, 74)
    luraPlate:SetPoint("CENTER", diagram, "CENTER", 0, 16)
    luraPlate:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    luraPlate:SetBackdropColor(0.08, 0.02, 0.12, 0.46)
    luraPlate:SetBackdropBorderColor(0.55, 0.25, 0.85, 0.52)
    self.luraPlate = luraPlate

    local luraTexture = luraPlate:CreateTexture(nil, "ARTWORK")
    luraTexture:SetPoint("TOPLEFT", luraPlate, "TOPLEFT", 3, -3)
    luraTexture:SetPoint("BOTTOMRIGHT", luraPlate, "BOTTOMRIGHT", -3, 3)
    luraTexture:SetTexture("Interface\\AddOns\\FUA\\textures\\lura.png")

    self.luraTexture = luraTexture

    self.positionFrames = {}

    for position = 1, 5 do
        local offset = POSITION_LAYOUT_5[position]
        self.positionFrames[position] = self:CreatePositionSlot(diagram, position, offset.x, offset.y)
    end
end

function FUA:CreatePositionSlot(parent, position, x, y)
    local slot = CreateFrame("Button", nil, parent, "BackdropTemplate")
    slot:SetSize(54, 54)
    slot:SetPoint("CENTER", parent, "CENTER", x, y)
    slot.position = position

    slot:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    slot:SetBackdropColor(0.02, 0.02, 0.03, 0.50)
    slot:SetBackdropBorderColor(0.50, 0.50, 0.60, 0.55)

    local number = slot:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    number:SetPoint("TOP", slot, "TOP", 0, -3)
    number:SetText(position)
    slot.numberText = number

    local icon = slot:CreateTexture(nil, "ARTWORK")
    icon:SetSize(40, 40)
    icon:SetPoint("CENTER", slot, "CENTER", 0, -6)
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
            slot:SetBackdropBorderColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.72)
        else
            slot.icon:Hide()
            slot:SetBackdropBorderColor(0.50, 0.50, 0.60, 0.55)
        end

        if self.myPosition == position then
            slot:SetBackdropColor(0.18, 0.12, 0.28, 0.85)
        else
            slot:SetBackdropColor(0.02, 0.02, 0.03, 0.50)
        end
    end
end

function FUA:UpdatePositionLayout()
    local layout = self.symbolCount == 3 and POSITION_LAYOUT_3 or POSITION_LAYOUT_5

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
