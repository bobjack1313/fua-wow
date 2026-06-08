local addonName, FUA = ...

local commFrame = CreateFrame("Frame")

commFrame:RegisterEvent("CHAT_MSG_ADDON")

commFrame:SetScript("OnEvent", function(_, _, prefix, message, channel, sender)

    if prefix ~= "FUA" then
        return
    end

    print("|cff00ff00FUA COMM|r:", message, "from", sender)
end)

function FUA:TestBroadcast()

    C_ChatInfo.SendAddonMessage(
        "FUA",
        "HELLO",
        "RAID"
    )

    print("FUA: Sent test message.")
end
