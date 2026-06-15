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

FUA.currentImportPriority = 0

-----------------------------------------------------------------------
-- Communication Events
-----------------------------------------------------------------------

local commFrame = CreateFrame("Frame")
commFrame:RegisterEvent("CHAT_MSG_ADDON")

commFrame:SetScript("OnEvent", function(_, event, ...)
    if event ~= "CHAT_MSG_ADDON" then
        return
    end

    FUA:HandleAddonMessage(...)
end)

-----------------------------------------------------------------------
-- Addon Message Handling
-----------------------------------------------------------------------

function FUA:HandleAddonMessage(prefix, message, channel, sender)
    if prefix ~= "FUA" then
        return
    end

    if not self.DEBUG_COMMS and not self.isEncounterActive then
        return
    end

    local playerName, playerRealm = UnitFullName("player")
    local fullPlayerName = playerRealm and (playerName .. "-" .. playerRealm) or playerName

    if sender == playerName or sender == fullPlayerName then
        if self.DEBUG_COMMS then
            self:PrintInfo("Ignoring own addon message.")
        end
        return
    end

    if self.DEBUG_COMMS then
        self:PrintInfo(
            "RX addon message from " ..
            tostring(sender) ..
            " via " ..
            tostring(channel) ..
            ": " ..
            tostring(message)
        )
    end

    local parsed = self:ParseChatAssignment("FUA: " .. tostring(message))
    if not parsed then
        self:PrintError("Addon message parse failed.")
        return
    end

    -- Checks for combat restriction - If lifted this feature will work
    if self:IsSecureEncounterCombat() then
        if self.DEBUG_COMMS then
            self:PrintInfo("Ignoring addon import during protected combat.")
        end
        return
    end

    self:ImportAssignment(parsed, 100)
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

    priority = priority or 0
    self.currentImportPriority = self.currentImportPriority or 0

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

-----------------------------------------------------------------------
-- Assignment Broadcast
-----------------------------------------------------------------------

function FUA:BroadcastAssignment()
    local text = self:GetPreparedMessageOrderString()

    if text == "" then
        self:PrintError(self.L.ERR_NO_ORDER)
        return
    end

    local channel
    local target

    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        channel = "INSTANCE_CHAT"
    elseif IsInRaid() then
        channel = "RAID"
    elseif IsInGroup() then
        channel = "PARTY"
    else
        channel = "WHISPER"
        target = UnitName("player")
    end

    if self.DEBUG_COMMS then
        self:PrintInfo(
            "TX addon message via " ..
            channel ..
            ": " ..
            text
        )
    end

    local result = C_ChatInfo.SendAddonMessage(
        "FUA",
        text,
        channel,
        target
    )

    if self.DEBUG_COMMS then
        self:PrintInfo(
            "SendAddonMessage result: " ..
            tostring(result)
        )
    end

    if result ~= 0 then
        self:PrintError("Addon message send failed: " .. tostring(result))
    end
end
