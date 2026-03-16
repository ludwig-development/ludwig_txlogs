if Config.Framework ~= "vorp" then return end

local Core = exports.vorp_core:GetCore()
local userCache = {}

Bridge = Bridge or {}

Bridge.isInSession = function(source)
    if not source then return LocalPlayer.state.IsInSession end

    local ply = Player(source)
    return ply and ply.state and ply.state.IsInSession
end

Bridge.GetCharData = function(source)
    if not source then return false end

    if userCache[source] then
        return userCache[source]
    end

    if not Bridge.isInSession(source) then
        return false
    end

    local user = Core.getUser(source)
    if not user then
        DebugPrint("User could not be found for source: " .. tostring(source))
        return false
    end

    local char = user.getUsedCharacter
    if not char then
        DebugPrint("Character data not fully loaded for source: " .. tostring(source))
        return false
    end

    local cfxname = GetPlayerName(source) or 'Unknown Player'
    local firstName = char.firstname or ''
    local lastName = char.lastname or ''

    local fullName = (firstName .. ' ' .. lastName):match("^%s*(.-)%s*$")
    if fullName == "" then fullName = "Unknown Character" end

    local data = {
        name    = fullName,
        job     = char.job or "unemployed",
        charId  = char.charIdentifier,
        group   = char.group or "user",
        steamId = char.identifier,
        cfxname = cfxname or "unknown User"
    }

    userCache[source] = data
    return data
end
