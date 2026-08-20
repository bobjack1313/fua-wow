-----------------------------------------------------------------------
-- FUA
-- File: Modules/Auras/SecureUnitButton.lua
--
-- Secure unit button proof of concept.
--
-- Goal:
--   Overlay a transparent secure action button on top of the
--   Blizzard-managed AuraContainer test area.
-----------------------------------------------------------------------

local addonName, FUA = ...

local Auras = FUA.Auras

function Auras:CreateTestSecureButton()

    if self.testSecureButton then
        return
    end

    local button = CreateFrame(
        "Button",
        "FUATestSecureButton",
        UIParent,
        "SecureActionButtonTemplate"
    )

    button:SetSize(48, 48)
    button:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    button:SetFrameStrata("TOOLTIP")
    button:SetFrameLevel(100)

    button:RegisterForClicks("AnyDown", "AnyUp")
    button:SetAttribute("unit", "player")
    button:SetAttribute("type", "spell")
    button:SetAttribute("spell", "Healing Wave")

    -- Transparent overlay.
    -- button:SetAlpha(0.01)
    button:SetAlpha(1)

    -- button:SetScript("PostClick", function(_, mouseButton)
    --     print("FUA secure button clicked:", mouseButton)
    -- end)

    local bg = button:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(1, 0, 0, 0.35)
    button:Show()

    self.testSecureButton = button

    print("FUA secure test button created")
end
