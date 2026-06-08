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
-- Does NOT contain:
--   * User interface creation
--   * Encounter event handling
--   * Chat message generation
--   * Order management logic
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

