-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Chat.lua
--
-- Chat message generation and channel selection.
--
-- Responsible for:
--   * Building raid assignment messages
--   * Selecting the appropriate chat channel
--   * Loading messages into the chat edit box
--   * Message formatting for group communication
-----------------------------------------------------------------------

local addonName, FUA = ...

-----------------------------------------------------------------------
-- Message Formatting
-----------------------------------------------------------------------

function FUA:GetChatPrefix()
    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        return "/instance FUA:  "
    elseif IsInRaid() and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) then
        return "/rw FUA:  "
    elseif IsInRaid() then
        return "/raid FUA:  "
    elseif IsInGroup() then
        return "/party FUA:  "
    end

    return "/say FUA:  "
end

-----------------------------------------------------------------------
-- Chat Integration
-----------------------------------------------------------------------

function FUA:OpenRaidChat()
    local text = self:GetPreparedMessageOrderString()

    if text == "" then
        print("|cffff5555FUA:|r No order built yet.")
        return
    end

    ChatFrame_OpenChat(self:GetChatPrefix() .. text)
end
