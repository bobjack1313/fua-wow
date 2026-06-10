-----------------------------------------------------------------------
-- FUA Tests
-- File: wow_stubs.lua
--
-- Minimal World of Warcraft API stubs for running addon logic tests
-- outside the game client.
-----------------------------------------------------------------------

function wipe(tbl)
    for key in pairs(tbl) do
        tbl[key] = nil
    end
end

function strtrim(value)
    return string.match(value or "", "^%s*(.-)%s*$")
end

function CreateFrame()
    return {
        RegisterEvent = function() end,
        SetScript = function() end,
    }
end

C_ChatInfo = {
    RegisterAddonMessagePrefix = function() end,
    SendAddonMessage = function() end,
}

function GetInstanceInfo()
    return nil, "none", 0, nil, nil, nil, nil, 0
end

function loadAddonFile(path, addonName, addonTable)
    local chunk, err = loadfile(path)

    if not chunk then
        error(err)
    end

    return chunk(addonName or "FUA", addonTable or FUA)
end

function UnitName()
    return "Player"
end
