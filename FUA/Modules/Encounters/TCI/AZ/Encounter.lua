-----------------------------------------------------------------------
-- FUA - Azta'rec Intermission Tracker
-- File: Modules/Encounters/TCI/AZ/Encounter.lua
--
-- Responsible for:
--   * Encounter event registration
--   * Automatic memory reset on pull
--   * Encounter-specific window behavior
-----------------------------------------------------------------------

local addonName, FUA = ...

local AZ = FUA.AZ

AZ.isEncounterActive = false

-----------------------------------------------------------------------
-- Encounter Events
-----------------------------------------------------------------------

function AZ:RegisterEncounterEvents()
    local encounterFrame = CreateFrame("Frame")
    self.encounterFrame = encounterFrame

    encounterFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    encounterFrame:RegisterEvent("ENCOUNTER_START")
    encounterFrame:RegisterEvent("ENCOUNTER_END")

    encounterFrame:SetScript("OnEvent", function(_, event, encounterID)
        if event == "PLAYER_ENTERING_WORLD" then
            self.isEncounterActive = false
            self.symbolCount = self.DEFAULT_SYMBOL_COUNT

            self:UpdateDisplay()
            return
        end

        if event == "ENCOUNTER_START" then
            if FUA.DebugLog then
                FUA:DebugLog(
                    "ENCOUNTER_START",
                    tostring(encounterID)
                )
            end

            print("FUA Encounter ID:", encounterID)
            if encounterID ~= self.AZTAREC_ENCOUNTER_ID then
                return
            end

            if FUA.DebugLog then
                FUA:DebugLog(
                    "ENCOUNTER_START",
                    tostring(encounterID)
                )
            end

            self.isEncounterActive = true
            self.symbolCount = self.DEFAULT_SYMBOL_COUNT

            self:ClearOrder()

            if self.frame and not self.frame:IsShown() then
                self.frame:Show()
            end

            return
        end
    end)
end
