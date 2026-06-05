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

    encounterFrame:RegisterEvent("ENCOUNTER_START")

    encounterFrame:SetScript("OnEvent", function(_, _, encounterID)
        if encounterID == self.MIDNIGHT_FALLS_ENCOUNTER_ID then
            FUA:ClearOrder()

            if self.frame and not self.frame:IsShown() then
                self.frame:Show()
            end
        end
    end)
end
