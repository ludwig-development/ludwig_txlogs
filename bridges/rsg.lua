if Config.Framework ~= "rsg" then return end

local RSGCore = exports['rsg-core']:GetCoreObject()
local userCache = {}

Bridge = Bridge or {}

Bridge.GetCharData = function(source)
    if not source then return false end

    if userCache[source] then
        return userCache[source]
    end

    local Player = RSGCore.Functions.GetPlayer(source)
    if not Player then
        return false
    end

    local pd = Player.PlayerData
    local charInfo = pd.charinfo
    local firstName = charInfo and charInfo.firstname or ''
    local lastName = charInfo and charInfo.lastname or ''
    local fullName = (firstName .. ' ' .. lastName):match("^%s*(.-)%s*$")
    if fullName == "" then fullName = "Unknown Character" end

    local data = {
        name       = fullName,
        job        = pd.job and pd.job.name or "unemployed",
        charid     = pd.cid,
        citizenid  = pd.citizenid,
        group      = pd.gang and pd.gang.name or (pd.job and pd.job.name or "user"),
        identifier = pd.license,
        steamId    = pd.license,
        money      = pd.money and pd.money.cash or 0,
        cfxname    = GetPlayerName(source) or "Unknown Player"
    }

    userCache[source] = data
    return data
end

AddEventHandler('RSGCore:Server:OnPlayerUnload', function(source)
    userCache[source] = nil
end)
