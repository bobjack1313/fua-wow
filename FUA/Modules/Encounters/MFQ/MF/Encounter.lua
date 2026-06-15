-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Modules/Encounters/MFQ/MF/Encounter.lua
--
-- Encounter and difficulty management.
--
-- Responsible for:
--   * Raid difficulty detection
--   * Symbol count adjustment by difficulty
--   * Encounter event registration
--   * Automatic order reset on pull
--   * Encounter-specific addon behavior
-----------------------------------------------------------------------

local addonName, FUA = ...

FUA.isEncounterActive = false
FUA.currentImportPriority = 0

-----------------------------------------------------------------------
-- Difficulty Management
-----------------------------------------------------------------------

-- Midnight Falls only requires three rune assignments in
-- LFR/Normal difficulty and five assignments in Heroic/Mythic.
function FUA:UpdateDifficulty()

    local _, _, difficultyID = GetInstanceInfo()
    difficultyID = FUA_DEBUG_DIFFICULTY or difficultyID

    local difficultyName = self.L.DIFFICULTY_UNKNOWN

    if difficultyID == 17 then
        self.symbolCount = 3
        difficultyName = self.L.DIFFICULTY_LFR

    elseif difficultyID == 14 then
        self.symbolCount = 3
        difficultyName = self.L.DIFFICULTY_NORMAL

    elseif difficultyID == 15 then
        self.symbolCount = 5
        difficultyName = self.L.DIFFICULTY_HEROIC

    elseif difficultyID == 16 then
        self.symbolCount = 5
        difficultyName = self.L.DIFFICULTY_MYTHIC

    else
        self.symbolCount = 3
        difficultyName = self.L.DIFFICULTY_OUTSIDE_RAID
    end

    self.difficultyName = difficultyName

    if self.difficultyText then
        self.difficultyText:SetText(
            self.L.DIFFICULTY_LABEL .. ": " .. difficultyName
        )
    end
end

-----------------------------------------------------------------------
-- Encounter Events
-----------------------------------------------------------------------

function FUA:RegisterEncounterEvents()
    local encounterFrame = CreateFrame("Frame")
    self.encounterFrame = encounterFrame

    encounterFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    encounterFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
    encounterFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    encounterFrame:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
    encounterFrame:RegisterEvent("ENCOUNTER_START")
    encounterFrame:RegisterEvent("ENCOUNTER_END")

    encounterFrame:SetScript("OnEvent", function(_, event, encounterID)
        if event == "PLAYER_ENTERING_WORLD" then
            self.isEncounterActive = false
            self.currentImportPriority = 0

            self:UpdateDifficulty()
            self:UpdateDisplay()
            self:ShowInstanceReminder()
            return
        end

        if event == "ENCOUNTER_START" then
            if encounterID == self.MIDNIGHT_FALLS_ENCOUNTER_ID then
                if self.DebugLog then
                    self:DebugLog("ENCOUNTER_START", tostring(encounterID))
                end

                self.isEncounterActive = true
                self.currentImportPriority = 0

                self:UpdateDifficulty()
                self:ClearOrder()
                self:UpdateChatButtonText()

                if self.frame and not self.frame:IsShown() then
                    self.frame:Show()
                end
            end

            return
        end

        if event == "ENCOUNTER_END" then
            if encounterID == self.MIDNIGHT_FALLS_ENCOUNTER_ID then
                if self.DebugLog then
                    self:DebugLog("ENCOUNTER_END", tostring(encounterID))
                end

                self.isEncounterActive = false
                self.currentImportPriority = 0
            end

            return
        end

        self:UpdateDifficulty()
        self:UpdateDisplay()
    end)
end

function FUA:ShowInstanceReminder()
    local _, instanceType, _, _, _, _, _, instanceID = GetInstanceInfo()

    if instanceType ~= "raid" then
        return
    end

    if instanceID ~= self.MARCH_OF_QUELDANAS_INSTANCE_ID then
        return
    end

    if self.reminderShown then
        return
    end

    self.reminderShown = true

    self:PrintSuccess(self.L.MF_MSG_READY)
end

function FUA:IsSecureEncounterCombat()
    return InCombatLockdown
        and InCombatLockdown()
        and self.isEncounterActive == true
end
