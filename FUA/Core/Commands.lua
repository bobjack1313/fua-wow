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
--   /fua help
--   /fua version
-----------------------------------------------------------------------

local addonName, FUA = ...

function FUA:RegisterCommands()

    -------------------------------------------------------------------
    -- Main command
    -------------------------------------------------------------------

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
            print(self:ColorText(self.Colors.SUCCESS, self.L.HELP_TITLE))
            print("/fua - Toggle the window")
            print("/fua show - Show the window")
            print("/fua hide - Hide the window")
            print("/fua clear - Clear the current order")
            print("/fua version - Show version")
            print("/fua gamut - Test addon-message channels")

        elseif msg == "version" then
            print(self:GetPrefix() .. " " .. self.L.VERSION_LABEL .. " " .. self.VERSION)

        elseif msg == "gamut" then
            local payload = "GAMUT-" .. tostring(time())
            local name, realm = UnitFullName("player")
            local selfTarget = realm and (name .. "-" .. realm) or name

            print("FUA GAMUT combat=", InCombatLockdown() and "YES" or "NO")
            print(
                "FUA GAMUT group=",
                tostring(IsInGroup()),
                "raid=",
                tostring(IsInRaid()),
                "instance=",
                tostring(IsInGroup(LE_PARTY_CATEGORY_INSTANCE))
            )

            local function send(channel, target)
                local result = C_ChatInfo.SendAddonMessage(
                    "FUA",
                    payload .. "-" .. channel,
                    channel,
                    target
                )

                print(
                    "FUA GAMUT sent",
                    channel,
                    target or "",
                    "=>",
                    tostring(result)
                )
            end

            send("WHISPER", selfTarget)

            if IsInGroup() then
                send("PARTY")
            end

            if IsInRaid() then
                send("RAID")
            end

            if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
                send("INSTANCE_CHAT")
            end

        else
            self.frame:SetShown(not self.frame:IsShown())
        end
    end

    -------------------------------------------------------------------
    -- Short import command
    -------------------------------------------------------------------

    SLASH_FUAIMPORT1 = "/fi"

    SlashCmdList["FUAIMPORT"] = function(msg)
        msg = msg or ""

        if self.ImportAssignmentCode then
            local ok = self:ImportAssignmentCode(msg)

            if ok then
                self:PrintSuccess("Imported assignment code: " .. msg)
            else
                self:PrintError("Invalid assignment code: " .. msg)
            end
        else
            self:PrintError("Import code system is not loaded yet.")
        end
    end

    -------------------------------------------------------------------
    -- Debug command
    -------------------------------------------------------------------

    SLASH_FUADEBUG1 = "/fuadebug"

    SlashCmdList["FUADEBUG"] = function()
        local name, instanceType, difficultyID, difficultyName,
              maxPlayers, dynamicDifficulty, isDynamic,
              instanceID = GetInstanceInfo()

        print("Name:", name)
        print("Type:", instanceType)
        print("Difficulty:", difficultyID)
        print("Difficulty Name:", difficultyName)
        print("InstanceID:", instanceID)
        print("Combat:", InCombatLockdown() and "YES" or "NO")
        print("Group:", tostring(IsInGroup()))
        print("Raid:", tostring(IsInRaid()))
        print("Instance Group:", tostring(IsInGroup(LE_PARTY_CATEGORY_INSTANCE)))
        print("Combat:", InCombatLockdown() and "YES" or "NO")
        print("Special Combat:", self.IsSecureEncounterCombat() and "YES" or "NO")
        print("DEBUG_COMMS:", tostring(self.DEBUG_COMMS))
    end
end
