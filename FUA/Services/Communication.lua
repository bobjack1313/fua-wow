-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Communication.lua
--
-- Inter-addon and chat communication.
--
-- Responsible for:
--   * Receiving assignment messages
--   * Assignment import validation
--   * Source priority handling
--   * Future addon message synchronization
--   * Assignment parsing
-----------------------------------------------------------------------

local addonName, FUA = ...

-----------------------------------------------------------------------
-- Runtime State
-----------------------------------------------------------------------

FUA.importSourcePriority = {
    CHAT_MSG_INSTANCE_CHAT = 1,
    CHAT_MSG_RAID = 2,
    CHAT_MSG_RAID_WARNING = 3,
}

FUA.currentImportPriority = 0

-----------------------------------------------------------------------
-- Communication Events
-----------------------------------------------------------------------

local commFrame = CreateFrame("Frame")

commFrame:RegisterEvent("CHAT_MSG_ADDON")
commFrame:RegisterEvent("CHAT_MSG_RAID")
commFrame:RegisterEvent("CHAT_MSG_RAID_WARNING")
commFrame:RegisterEvent("CHAT_MSG_INSTANCE_CHAT")

commFrame:SetScript("OnEvent", function(_, event, ...)
    if event == "CHAT_MSG_ADDON" then
        FUA:HandleAddonMessage(...)
        return
    end

    FUA:HandleChatAssignment(event, ...)
end)

-----------------------------------------------------------------------
-- Addon Message Handling
-----------------------------------------------------------------------

function FUA:HandleAddonMessage(prefix, message, channel, sender)
    if prefix ~= "FUA" then
        return
    end
end

-----------------------------------------------------------------------
-- Chat Message Handling
-----------------------------------------------------------------------

function FUA:HandleChatAssignment(event, message, sender)
    if not self.isEncounterActive then
        return
    end

    if sender and UnitName and sender == UnitName("player") then
        return
    end

    local priority = self.importSourcePriority[event]
    if not priority then
        return
    end

    local parsed = self:ParseChatAssignment(message)
    if not parsed then
        return
    end

    self:ImportAssignment(parsed, priority)
end

-----------------------------------------------------------------------
-- Symbol Lookup
-----------------------------------------------------------------------

function FUA:GetSymbolByToken(token)
    if not token then
        return nil
    end

    token = strtrim(token)

    for _, symbol in ipairs(self.symbols) do
        if token == symbol.char or token == symbol.marker then
            return symbol
        end
    end

    return nil
end

-----------------------------------------------------------------------
-- Assignment Parsing
-----------------------------------------------------------------------

function FUA:ParseChatAssignment(message)
    if not message then
        return nil
    end

    -- Only accept FUA-prefixed messages.
    if not string.match(message, "^FUA:%s*") then
        return nil
    end

    local parsed = {}

    for token in string.gmatch(message, "%[%s*(.-)%s*%]") do
        local symbol = self:GetSymbolByToken(token)

        if not symbol then
            return nil
        end

        table.insert(parsed, symbol)
    end

    if #parsed ~= self.symbolCount then
        return nil
    end

    return parsed
end

-----------------------------------------------------------------------
-- Assignment Import
-----------------------------------------------------------------------

function FUA:ImportAssignment(symbols, priority)
    if not symbols then
        return
    end

    if priority < self.currentImportPriority then
        return
    end

    wipe(self.order)

    for _, symbol in ipairs(symbols) do
        table.insert(self.order, symbol)
    end

    self.currentImportPriority = priority
    self:UpdateDisplay()

    self:PrintSuccess(self.L.MSG_IMPORTED)
end

