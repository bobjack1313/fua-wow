local FUA = {}
FUA.order = {}
FUA.reverseOrder = true
FUA.symbolCount = 5
FUA.outputMode = "char"

local LUA_ENCOUNTER_ID = 3183

local symbols = {
    {
        label = "X",
        char = "X",
        marker = "{rt7}",
        displayMarker = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:22:22|t",
        texture = "Interface\\AddOns\\FUA\\textures\\cross.png",
        color = {1.0, 0.05, 0.05, 0.75}
    },
    { 
        label = "V",
        char = "V",
        marker = "{rt4}",
        displayMarker = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:22:22|t",
        texture = "Interface\\AddOns\\FUA\\textures\\triangle.png",
        color = {0.0, 1.0, 0.25, 0.75}
    },
    {
        label = "<>",
        char = "<>",
        marker = "{rt3}",
        displayMarker = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:22:22|t",
        texture = "Interface\\AddOns\\FUA\\textures\\diamond.png",
        color = {0.75, 0.1, 1.0, 0.75}
    },
    {
        label = "T",
        char = "T",
        marker = "{rt1}",
        displayMarker = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:22:22|t",
        texture = "Interface\\AddOns\\FUA\\textures\\tee.png",
        color = {1.0, 0.82, 0.0, 0.75}
    },
    {
        label = "O",
        char = "O",
        marker = "{rt2}",
        displayMarker = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:22:22|t",      
        texture = "Interface\\AddOns\\FUA\\textures\\circle.png",
        color = {1.0, 0.55, 0.0, 0.75}
    },
}

local function UpdateDifficulty()
    local _, _, difficultyID = GetInstanceInfo()

    local difficultyName = "Unknown"

    if difficultyID == 17 then
        FUA.symbolCount = 3
        difficultyName = "LFR"
    elseif difficultyID == 14 then
        FUA.symbolCount = 3
        difficultyName = "Normal"
    elseif difficultyID == 15 then
        FUA.symbolCount = 5
        difficultyName = "Heroic"
    elseif difficultyID == 16 then
        FUA.symbolCount = 5
        difficultyName = "Mythic"
    else
        FUA.symbolCount = 5
        difficultyName = "Outside Raid"
    end

    FUA.difficultyName = difficultyName

    if FUA.difficultyText then
        FUA.difficultyText:SetText("Difficulty: " .. difficultyName)
    end
end

local function GetSymbolText(symbol)
    if FUA.outputMode == "markers" then
        return symbol.marker
    end

    return symbol.char
end

local function GetChatSymbolText(symbol)
    if FUA.outputMode == "markers" then
        return "[ " .. symbol.marker .. " ]"
    end

    return "[ " .. symbol.char .. " ]"
end

local function GetDisplaySymbolText(symbol)
    if FUA.outputMode == "markers" then
        return symbol.displayMarker
    end

    return "[ " .. symbol.char .. " ]"
end

local function BuildOrderString(useDisplay)
    local output = {}

    local function AddOutput(symbol)
        if useDisplay then
            table.insert(output, GetDisplaySymbolText(symbol))
        else
            table.insert(output, GetChatSymbolText(symbol))
        end
    end

    if FUA.reverseOrder then
        for i = #FUA.order, 1, -1 do
            AddOutput(FUA.order[i])
        end
    else
        for i = 1, #FUA.order do
            AddOutput(FUA.order[i])
        end
    end

    return table.concat(output, "    ")
end

local function GetDisplayOrderString()
    return BuildOrderString(true)
end

local function GetChatOrderString()
    return BuildOrderString(false)
end

local function UpdateDisplay()
    FUA.displayText:SetText(GetDisplayOrderString())

    if FUA.countText then
        FUA.countText:SetText(#FUA.order .. "/" .. FUA.symbolCount)
    end
end

local function HasSymbol(symbol)
    for _, existing in ipairs(FUA.order) do
        if existing.label == symbol.label then
            return true
        end
    end

    return false
end

local function AddSymbol(symbol)
    UpdateDifficulty()

    if HasSymbol(symbol) then
        print("|cffff5555FUA:|r Symbol already selected.")
        return
    end

    if #FUA.order >= FUA.symbolCount then
        print("|cffff5555FUA:|r Symbol limit reached.")
        return
    end

    table.insert(FUA.order, symbol)
    UpdateDisplay()
end

local function UpdateDisplayFont()
    if FUA.outputMode == "markers" then
        FUA.displayText:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
    else
        FUA.displayText:SetFont("Fonts\\FRIZQT__.TTF", 18, "OUTLINE")
    end
end

local function ClearOrder()
    wipe(FUA.order)
    UpdateDisplay()
end

local function UndoLast()
    table.remove(FUA.order)
    UpdateDisplay()
end

local function OpenRaidChat()
    local text = GetChatOrderString()

    if text == "" then
        print("|cffff5555FUA:|r No order built yet.")
        return
    end

    local prefix = "/raid "

    if IsInRaid() and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) then
        prefix = "/rw "
    elseif IsInRaid() then
        prefix = "/raid "
    elseif IsInGroup() then
        prefix = "/party "
    else
        prefix = "/say "
    end

    ChatFrame_OpenChat(prefix .. text)
end

local frame = CreateFrame("Frame", "FUAFrame", UIParent, "BackdropTemplate")
frame:SetSize(360, 210)
frame:SetPoint("CENTER")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
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
FUA.difficultyText = difficultyText
UpdateDifficulty()

local reverseButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
reverseButton:SetSize(130, 22)
reverseButton:SetPoint("TOP", frame, "TOP", 75, -25)
reverseButton:SetText("Clockwise")

local function ToggleReverse()
    FUA.reverseOrder = not FUA.reverseOrder

    if FUA.reverseOrder then
        reverseButton:SetText("Clockwise")
    else
        reverseButton:SetText("Counter Clockwise")
    end

    UpdateDisplay()
end

reverseButton:SetScript("OnClick", ToggleReverse)

local outputButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
outputButton:SetSize(100, 22)
outputButton:SetPoint("TOP", frame, "TOP", -75, -25)
outputButton:SetText("Characters")

local function ToggleOutputMode()
    if FUA.outputMode == "char" then
        FUA.outputMode = "markers"
        outputButton:SetText("Markers")
    else
        FUA.outputMode = "char"
        outputButton:SetText("Characters")
    end

    UpdateDisplayFont()
    UpdateDisplay()
end

outputButton:SetScript("OnClick", ToggleOutputMode)

local displayBox = CreateFrame("Frame", nil, frame, "BackdropTemplate")
displayBox:SetSize(300, 38)
displayBox:SetPoint("TOP", frame, "TOP", 0, -50)
displayBox:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8x8",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    edgeSize = 10,
    insets = { left = 3, right = 3, top = 3, bottom = 3 },
})
displayBox:SetBackdropColor(0, 0, 0, 0.45)
displayBox:SetBackdropBorderColor(0.5, 0.5, 0.6, 0.5)

local displayText = displayBox:CreateFontString(nil, "OVERLAY")
displayText:SetPoint("CENTER", displayBox, "CENTER", 0, 0)
displayText:SetFont("Fonts\\FRIZQT__.TTF", 18, "OUTLINE")
displayText:SetTextColor(1, 0.82, 0)
FUA.displayText = displayText

local previousButton

for i, symbol in ipairs(symbols) do
    local button = CreateFrame("Button", nil, frame, "BackdropTemplate")
    button:SetSize(52, 52)

    if i == 1 then
        button:SetPoint("TOPLEFT", frame, "TOPLEFT", 34, -105)
    else
        button:SetPoint("LEFT", previousButton, "RIGHT", 8, 0)
    end

    button:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 3,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })

    button:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })

    button:SetBackdropColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.75)
    button:SetBackdropBorderColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.55)

    local glass = button:CreateTexture(nil, "BORDER")
    glass:SetPoint("TOPLEFT", button, "TOPLEFT", 5, -5)
    glass:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -5, 5)
    glass:SetColorTexture(symbol.color[1], symbol.color[2], symbol.color[3], 0.18)
    button.glass = glass

    local icon = button:CreateTexture(nil, "ARTWORK")
    icon:SetPoint("TOPLEFT", button, "TOPLEFT", 5, -5)
    icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -5, 5)
    icon:SetTexture(symbol.texture)
    button.icon = icon

    button:SetScript("OnClick", function()
        AddSymbol(symbol)
    end)

    button:SetScript("OnEnter", function()
        button:SetBackdropColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.88)
        button:SetBackdropBorderColor(1, 1, 1, 0.9)
    end)

    button:SetScript("OnLeave", function()
        button:SetBackdropColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.75)
        button:SetBackdropBorderColor(symbol.color[1], symbol.color[2], symbol.color[3], 0.55)
    end)

    previousButton = button
end

local undoButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
undoButton:SetSize(70, 28)
undoButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 34, -168)
undoButton:SetText("Undo")
undoButton:SetScript("OnClick", UndoLast)

local clearButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
clearButton:SetSize(70, 28)
clearButton:SetPoint("LEFT", undoButton, "RIGHT", 8, 0)
clearButton:SetText("Clear")
clearButton:SetScript("OnClick", ClearOrder)

local chatButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
chatButton:SetSize(120, 28)
chatButton:SetPoint("LEFT", clearButton, "RIGHT", 8, 0)
chatButton:SetText("Load Message")
chatButton:SetScript("OnClick", OpenRaidChat)

local encounterFrame = CreateFrame("Frame")

encounterFrame:RegisterEvent("ENCOUNTER_START")

encounterFrame:SetScript("OnEvent", function(_, _, encounterID)
    if encounterID == LUA_ENCOUNTER_ID then
        ClearOrder()

        if not frame:IsShown() then
            frame:Show()
        end
    end
end)

SLASH_FUA1 = "/fua"
SlashCmdList["FUA"] = function(msg)
    msg = string.lower(msg or "")

    if msg == "show" then
        frame:Show()
    elseif msg == "hide" then
        frame:Hide()
    elseif msg == "clear" then
        ClearOrder()
    else
        frame:SetShown(not frame:IsShown())
    end
end
