-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Order.lua
--
-- Responsible for:
--   * Rune order storage
--   * Symbol validation
--   * Order formatting
--   * Undo/Clear operations
-----------------------------------------------------------------------

local addonName, FUA = ...

FUA.order = FUA.order or {}

-----------------------------------------------------------------------
-- Symbol Formatting
-----------------------------------------------------------------------

function FUA:GetSymbolText(symbol)
    if self.outputMode == "markers" then
        return symbol.marker
    end

    return symbol.char
end

function FUA:GetChatSymbolText(symbol)
    if self.outputMode == "markers" then
        return "[ " .. symbol.marker .. " ]"
    end

    return "[ " .. symbol.char .. " ]"
end

-----------------------------------------------------------------------
-- Order String Construction
-----------------------------------------------------------------------

-- Build the display/chat string using the configured order direction.
-- function FUA:BuildOrderString(useDisplay)
--     local output = {}

--     for i = 1, #self.order do
--         local index = self.reverseOrder and (#self.order - i + 1) or i
--         local symbol = self.order[index]

--         if useDisplay then
--             table.insert(output, self:GetDisplaySymbolText(symbol))
--         else
--             table.insert(output, self:GetChatSymbolText(symbol))
--         end
--     end

--     return table.concat(output, "    ")
-- end

-- function FUA:GetDisplayOrderString()
--     return self:BuildOrderString(true)
-- end

-- function FUA:GetChatOrderString()
--     return self:BuildOrderString(false)
-- end

function FUA:BuildInputOrderString(useDisplay)
    local output = {}

    for i = 1, #self.order do
        local symbol = self.order[i]

        if useDisplay then
            table.insert(output, self:GetDisplaySymbolText(symbol))
        else
            table.insert(output, self:GetChatSymbolText(symbol))
        end
    end

    return table.concat(output, "    ")
end

function FUA:GetDisplayOrderString()
    return self:BuildInputOrderString(true)
end

-- Changing to where the chat display string shows true input
function FUA:GetChatOrderString()
    return self:BuildInputOrderString(false)
end

function FUA:GetStrategyOrderedSymbols()
    local ordered = {}

    for i = 1, #self.order do
        local index = self.reverseOrder and (#self.order - i + 1) or i
        table.insert(ordered, self.order[index])
    end

    return ordered
end

-----------------------------------------------------------------------
-- Validation
-----------------------------------------------------------------------

-- Prevent duplicate rune assignments.
function FUA:HasSymbol(symbol)
    for _, existing in ipairs(self.order) do
        if existing.label == symbol.label then
            return true
        end
    end

    return false
end

-----------------------------------------------------------------------
-- Order Modification
-----------------------------------------------------------------------

-- LFR and Normal only require three rune assignments.
-- Heroic and Mythic require all five.
function FUA:AddSymbol(symbol)
    self:UpdateDifficulty()

    if self:HasSymbol(symbol) then
        print("|cffff5555FUA:|r Symbol already selected.")
        return
    end

    if #self.order >= self.symbolCount then
        print("|cffff5555FUA:|r Symbol limit reached.")
        return
    end

    table.insert(self.order, symbol)
    self:UpdateDisplay()
end

function FUA:ClearOrder()
    wipe(self.order)
    self:UpdateDisplay()
end

function FUA:UndoLast()
    table.remove(self.order)
    self:UpdateDisplay()
end

