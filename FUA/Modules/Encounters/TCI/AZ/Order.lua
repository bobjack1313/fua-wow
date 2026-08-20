-----------------------------------------------------------------------
-- FUA - Azta'rec Intermission Tracker
-- File: Modules/Encounters/TCI/AZ/Order.lua
--
-- Responsible for:
--   * Memory order storage
--   * Symbol formatting
--   * Five-position entry limit
--   * Undo/Clear operations
-----------------------------------------------------------------------

local addonName, FUA = ...

local AZ = FUA.AZ

AZ.order = AZ.order or {}

-----------------------------------------------------------------------
-- Symbol Formatting
-----------------------------------------------------------------------

-- function AZ:GetDisplaySymbolText(symbol)
--     if self.outputMode == "markers" then
--         return symbol.displayMarker
--     end

--     return "[ " .. symbol.char .. " ]"
-- end

-----------------------------------------------------------------------
-- Order String Construction
-----------------------------------------------------------------------

-- function AZ:GetDisplayOrderString()
--     local output = {}

--     for _, symbol in ipairs(self.order) do
--         table.insert(output, self:GetDisplaySymbolText(symbol))
--     end

--     return table.concat(output, "    ")
-- end

-----------------------------------------------------------------------
-- Order Modification
-----------------------------------------------------------------------

function AZ:AddSymbol(symbol)
    if not symbol then
        return
    end

    if #self.order >= self.symbolCount then
        FUA:PrintError(FUA.L.ERR_SYMBOL_LIMIT)
        return
    end

    table.insert(self.order, symbol)
    self:UpdateDisplay()
end

function AZ:ClearOrder()
    wipe(self.order)
    self:UpdateDisplay()
end

function AZ:UndoLast()
    if #self.order == 0 then
        return
    end

    table.remove(self.order)
    self:UpdateDisplay()
end
