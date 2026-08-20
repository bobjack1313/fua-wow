-----------------------------------------------------------------------
-- FUA
-- File: Modules/Auras/AuraContainer.lua
--
-- AuraContainer proof of concept.
--
-- Goal:
--   Verify that FUA can create a Blizzard AuraContainer,
--   attach it to a known unit, and display harmful dispellable auras.
-----------------------------------------------------------------------

local addonName, FUA = ...

local Auras = FUA.Auras

-----------------------------------------------------------------------
-- Proof of Concept Aura Container
-----------------------------------------------------------------------

function Auras:CreateTestAuraContainer()

    if self.testAuraContainer then
        return
    end

    local container = CreateFrame(
        "AuraContainer",
        "FUATestAuraContainer",
        UIParent,
        "CustomAuraContainerTemplate"
    )

    -- container:SetSize(200, 50)
    -- container:SetPoint("CENTER", UIParent, "CENTER", 0, 200)

    container:SetSize(400, 120)
    container:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    -- container:SetPoint("CENTER", UIParent, "CENTER", 0, 200)
    container:SetFrameStrata("TOOLTIP")
    container:Show()

    -- local background = container:CreateTexture(nil, "BACKGROUND")
    -- background:SetAllPoints()
    -- background:SetColorTexture(1, 0, 0, 0.9)

    -- local debugFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    -- debugFrame:SetSize(400, 120)
    -- debugFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    -- debugFrame:SetFrameStrata("TOOLTIP")

    -- debugFrame:SetBackdrop({
    --     bgFile = "Interface\\Buttons\\WHITE8x8",
    -- })

    -- debugFrame:SetBackdropColor(1, 0, 0, 0.9)
    -- debugFrame:Show()

    -- self.debugFrame = debugFrame

    print(
        "FUA AuraContainer:",
        container:IsShown(),
        container:GetWidth(),
        container:GetHeight()
    )

    local auraFrameOptions = {
        maxFrameCount = 5,
    }

    container:AddAuraGroup(
        "dispellable",
        "HARMFUL|DISPELLABLE",
        {
            maxFrameCount = 5,
            initializeFrame = function(auraButton)
                auraButton:SetSize(48, 48)

                local bg = auraButton:CreateTexture(nil, "BACKGROUND")
                bg:SetAllPoints()
                bg:SetColorTexture(0, 1, 0, 0.8)

                print(
                    "FUA AuraButton created:",
                    auraButton:GetName() or "unnamed",
                    auraButton:GetObjectType()
                )

                print(
                    "mouse enabled:",
                    auraButton:IsMouseEnabled()
                )

                auraButton:SetAttribute("unit", "player")
                auraButton:SetAttribute("type1", "spell")
                auraButton:SetAttribute("spell1", "Poison Cleansing Totem")
                -- auraButton:HookScript("OnShow", function(self)
                --     print("FUA AuraButton SHOW:", self:GetName() or "unnamed")
                -- end)

                -- auraButton:HookScript("OnHide", function(self)
                --     print("FUA AuraButton HIDE:", self:GetName() or "unnamed")
                -- end)
            end,
            -- initializeFrame = function(auraButton)
            --     auraButton:SetSize(48, 48)

            --     local bg = auraButton:CreateTexture(nil, "BACKGROUND")
            --     bg:SetAllPoints()
            --     bg:SetColorTexture(0, 1, 0, 0.8)
            -- end,
        }
    )
    -- container:AddAuraGroup(
    --     "dispellable",
    --     "HARMFUL|DISPELLABLE",
    --     auraFrameOptions
    -- )

    container:SetUnit("player")
    container:SetEnabled(true)

    print(
        "FUA AuraContainer state:",
        "shown=", container:IsShown(),
        "visible=", container:IsVisible(),
        "alpha=", container:GetAlpha(),
        "enabled=", container.IsEnabled and container:IsEnabled() or "unknown"
    )

    self.testAuraContainer = container
end
