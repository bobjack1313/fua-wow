-----------------------------------------------------------------------
-- FUA - Midnight Falls Assignment Helper
-- File: Encounter.lua
--
-- Encounter and difficulty management.
--
-- Responsible for:
--   * Raid difficulty detection
--   * Symbol count adjustment by difficulty
--   * Encounter event registration
--   * Automatic order reset on pull
--   * Encounter-specific addon behavior
--
-- Does NOT contain:
--   * User interface code
--   * Chat message generation
--   * Order construction logic
-----------------------------------------------------------------------

local addonName, FUA = ...

-----------------------------------------------------------------------
-- Difficulty Management
-----------------------------------------------------------------------

-- Midnight Falls only requires three rune assignments in
-- LFR/Normal difficulty and five assignments in Heroic/Mythic.
function FUA:UpdateDifficulty()

    local _, _, difficultyID = GetInstanceInfo()
    difficultyID = FUA_DEBUG_DIFFICULTY or difficultyID

    local difficultyName = "Unknown"

    if difficultyID == 17 then
        self.symbolCount = 3
        difficultyName = "LFR"
    elseif difficultyID == 14 then
        self.symbolCount = 3
        difficultyName = "Normal"
    elseif difficultyID == 15 then
        self.symbolCount = 5
        difficultyName = "Heroic"
    elseif difficultyID == 16 then
        self.symbolCount = 5
        difficultyName = "Mythic"
    else
        self.symbolCount = 3
        difficultyName = "Outside Raid"
    end

    self.difficultyName = difficultyName

    if self.difficultyText then
        self.difficultyText:SetText("Difficulty: " .. difficultyName)
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

    encounterFrame:SetScript("OnEvent", function(_, event, encounterID)
        if event == "PLAYER_ENTERING_WORLD" then
            self:UpdateDifficulty()
            self:UpdateDisplay()
            self:ShowInstanceReminder()
            return
        end

        if event == "ENCOUNTER_START" then
            if encounterID == self.MIDNIGHT_FALLS_ENCOUNTER_ID then
                self:UpdateDifficulty()
                self:ClearOrder()

                if self.frame and not self.frame:IsShown() then
                    self.frame:Show()
                end
            end

            return
        end

        self:UpdateDifficulty()
        self:UpdateDisplay()
    end)
end

function FUA:ShowInstanceReminder()
    local _, instanceType, _, _, _, _, _, instanceID = GetInstanceInfo()

    -- print("FUA reminder debug:", name, instanceType, difficultyID, instanceID)

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

    print("|cff00ff88FUA:|r Midnight Falls helper ready. Use |cffffff00/fua|r to prepare rune callouts.")
end
