-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Commands.lua
--
-- Slash command registration and command handling.
--
-- Responsible for:
--   * Registering addon slash commands
--   * Showing and hiding the addon window
--   * Clearing the current rune order
--   * Command routing and user interaction
--
-- Supported Commands:
--   /fua
--   /fua show
--   /fua hide
--   /fua clear
--
-- Test Commands:
--   /fua importtest
--   /fua rwtest
-----------------------------------------------------------------------

local addonName, FUA = ...

-----------------------------------------------------------------------
-- Slash Command Registration
-----------------------------------------------------------------------

function FUA:RegisterCommands()

    SLASH_FUA1 = "/fua"

    SlashCmdList["FUA"] = function(msg)

        msg = string.lower(msg or "")

        if msg == "show" then
            self.frame:Show()

        elseif msg == "hide" then
            self.frame:Hide()

        elseif msg == "clear" then
            self:ClearOrder()

        elseif msg == "help" then
            print("|cff00ff88FUA Help|r")
            print("/fua - Toggle the window")
            print("/fua show - Show the window")
            print("/fua hide - Hide the window")
            print("/fua clear - Clear the current order")
            print("Build the rune order, review the diagram, then click Prepare Message. Next, manually send to raid to pass along rune configuration.")

        elseif msg == "version" then
            print("|cff00ff88FUA:|r Version 0.3.0")

        elseif msg == "importtest" then
            self.isEncounterActive = true
            self.currentImportPriority = 0

            self:HandleChatAssignment(
                "CHAT_MSG_RAID",
                "FUA: [ <> ] [ V ] [ X ]",
                "FUA_Test"
            )

        elseif msg == "rwtest" then
            self.isEncounterActive = true

            self:HandleChatAssignment(
                "CHAT_MSG_RAID_WARNING",
                "FUA: [ X ] [ V ] [ <> ]",
                "FUA_Test"
            )

        else
            self.frame:SetShown(not self.frame:IsShown())
        end
    end

    SLASH_FUADEBUG1 = "/fuadebug"

        SlashCmdList["FUADEBUG"] = function()
        local name, instanceType, difficultyID, difficultyName,
              maxPlayers, dynamicDifficulty, isDynamic,
              instanceID = GetInstanceInfo()

        print("Name:", name)
        print("Type:", instanceType)
        print("Difficulty:", difficultyID)
        print("InstanceID:", instanceID)
    end

end

