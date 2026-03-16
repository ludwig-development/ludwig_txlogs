local L = Language.locale or {}
local F = Language.fallback or {}

local function tableContains(table, value)
  for _, v in ipairs(table) do
    if v == value then
      return true
    end
  end
  return false
end

local function isCharacterAllowed(group, name)
  local lowerName = string.lower(name or "")

  if tableContains(Config.AllowedGroups, group) or string.find(lowerName, "event") ~= nil then
    return true
  end

  return false
end

local function DebugPrint(...)
  if Config.Debug then
    print(...)
  end
end

local function getLogPlayerName(src)
  if type(src) == 'number' then
    local name = string.sub(GetPlayerName(src) or (F.unknown or "Unknown"), 1, 75)
    return '[#' .. src .. '] ' .. name
  else
    return '[??] ' .. (src or (F.unknown or "Unknown"))
  end
end

local function stripColorCodes(text)
  return string.gsub(text or "", "%^%d", "")
end

local hostname = GetConvar("sv_hostname",
  (Language.fallback and Language.fallback.unknownServer) or "Unknown Server")
local cleanName = stripColorCodes(hostname):lower()

local function resolveServerType()
  local servers = Config.Servers or {}
  local dev = servers.dev or {}
  local live = servers.live or {}

  if Config.Debug then
    DebugPrint("cleanname: " .. cleanName .. " |  identifyBy: " .. dev.identifyBy)
  end

  if dev.identifyBy and string.find(cleanName, string.lower(dev.identifyBy), 1, true) then
    if not Config.Debug then
      return nil
    end
    return dev.name or "[DEV]"
  end

  return live.name or "[LIVE]"
end

local SERVER_NAME = resolveServerType()

local function getPingMentions(roleIds)
  local mentions = {}

  if type(roleIds) == "table" then
    for _, roleId in ipairs(roleIds) do
      mentions[#mentions + 1] = "<@&" .. tostring(roleId) .. ">"
    end
  end

  if #mentions == 0 then
    mentions[1] = (Language.fallback and Language.fallback.pingHere) or "@here"
  end

  local warning = (L and L.pingUnauthorizedCharacter) or ""

  return table.concat(mentions, " ") .. " " .. warning
end

local function generatePing(eventName)
  local pings = Config.Pings or {}
  local triggerEvents = pings.triggerEvents or {}
  if triggerEvents[eventName] ~= true then return nil end
  local override = (pings.roleOverrides or {})[eventName]
  local whoToPing = override or pings.whoToPing or Config.RolesToPing or {}
  return getPingMentions(whoToPing)
end

local function safeWebhook(payload)
  local webhook = Config.Webhook or {}
  local url = webhook.url
  if not url or url == "" then
    print("^1[LudwigLogging] ERROR: Webhook URL missing^0")
    return
  end

  payload.username = payload.username or webhook.username or "Server Logs"
  payload.avatar_url = payload.avatar_url or webhook.avatarUrl or
      'https://forum.cfx.re/user_avatar/forum.cfx.re/ludwig_iii/288/6313229_2.png'

  PerformHttpRequest(url, function(status, body)
    if status ~= 200 and status ~= 204 then
      print("^1[LudwigLogging] Discord Webhook Failed^0")
      print("Status:", status)
      print("Response:", json.encode(body) or "nil")
    end
  end, "POST", json.encode(payload), {
    ["Content-Type"] = "application/json"
  })
end

local function buildEmbed(title, color, fields)
  local embedFields = {}

  for _, field in ipairs(fields) do
    if field and field.name and field.value then
      local cleanValue = tostring(field.value)
      local cleanName = tostring(field.name)

      if cleanValue ~= "" and cleanName ~= "" then
        table.insert(embedFields, {
          name = cleanName,
          value = cleanValue,
          inline = field.inline or false
        })
      end
    end
  end

  return {
    {
      title = title or "Ludwig txAdmin logging",
      color = color or 16777215,
      fields = embedFields
    }
  }
end

local ActionMessages = {
  spectatePlayer = function(data)
    return string.format(
      Language.actionMessages and Language.actionMessages.spectatePlayer or "started spectating player %s",
      getLogPlayerName(data))
  end,
  freezePlayer = function(data)
    return string.format(
      Language.actionMessages and Language.actionMessages.freezePlayer or "toggled freeze on player %s",
      getLogPlayerName(data))
  end,
  healPlayer = function(data)
    return string.format(Language.actionMessages and Language.actionMessages.healPlayer or "healed player %s",
      getLogPlayerName(data))
  end,
  summonPlayer = function(data)
    return string.format(Language.actionMessages and Language.actionMessages.summonPlayer or "summoned player %s",
      getLogPlayerName(data))
  end,
  drunkEffect = function(data)
    return string.format(
      Language.actionMessages and Language.actionMessages.drunkEffect or "triggered drunk effect on %s",
      getLogPlayerName(data))
  end,
  setOnFire = function(data)
    return string.format(Language.actionMessages and Language.actionMessages.setOnFire or "set %s on fire",
      getLogPlayerName(data))
  end,
  wildAttack = function(data)
    return string.format(Language.actionMessages and Language.actionMessages.wildAttack or "triggered wild attack on %s",
      getLogPlayerName(data))
  end,
  teleportPlayer = function(data)
    if type(data) ~= "table" then return nil end
    local playerName = getLogPlayerName(data.target)
    local x, y, z = data.x or 0.0, data.y or 0.0, data.z or 0.0
    local template = Language.actionMessages and Language.actionMessages.teleportPlayer or
        "teleported to player %s (x=%.3f y=%.3f z=%.3f)"
    return (template):format(playerName, x, y, z)
  end
}

local function resolveActionMessage(action, data, defaultMessage)
  local fn = ActionMessages[action]
  if fn then
    return fn(data)
  end
  return defaultMessage
end

AddEventHandler('txsv:logger:menuEvent', function(source, action, allowed, data)
  if not SERVER_NAME then return end
  if not allowed then return end

  local menuEvents = Language.menuEvents or {}
  local menuCfg = menuEvents[action]
  if not menuCfg then return end

  local icon = menuCfg.icon or "❓ "
  local colorKey = menuCfg.color
  local colors = Config.Colors or {}
  local embedColor = (colorKey and colors[colorKey]) or colors.orange or 16777215

  local message

  if action == 'playerModeChanged' then
    local modeCfg = menuCfg[data] or menuCfg.default
    message = modeCfg and modeCfg.message
    icon = (modeCfg and modeCfg.icon) or icon
    colorKey = (modeCfg and modeCfg.color) or colorKey
    embedColor = (colorKey and Config.Colors and Config.Colors[colorKey]) or embedColor
  elseif menuCfg.format then
    message = menuCfg.format(data)
  else
    message = menuCfg.message
  end

  message = resolveActionMessage(action, data, message)
  if not message then return end

  LudwigLoggingSolo(source, icon, embedColor, action, data, message)
end)

function LudwigLoggingSolo(source, icon, color, action, data, message)
  if not SERVER_NAME then return end

  local char = Bridge.GetCharData(source)
  if not char then return end

  local charName = char.name
  local group = char.group
  local charId = char.charId

  local pedId = GetPlayerPed(source)
  local coordsVec = GetEntityCoords(pedId)
  local coords = { x = coordsVec.x, y = coordsVec.y, z = coordsVec.z }

  local colors = Config.Colors or {}
  local embedColor = color or colors.orange or 16777215
  local pingContent = nil

  if not isCharacterAllowed(group, charName) then
    embedColor = colors.red or embedColor
    pingContent = generatePing('unauthorizedCharacter')
  end

  local playerName = getLogPlayerName(source) or (F.unknown or "Unknown")

  local discord = GetPlayerIdentifierByType(source, "discord")
  local discordID = nil

  if discord then
    discordID = string.match(discord, "discord:(%d+)")
  else
    discordID = L.notFound or "Not Found"
  end


  local playerInfo = string.format(
    "%s **%s**: %s\n%s **%s**: %s\n\n\n ",
    L.icons.player, L.labels.playerName, playerName,
    L.icons.discord, L.labels.discord, discordID
  )

  local charInfo = string.format(
    "%s **%s**: %s\n%s **%s**: %s\n%s **%s**: %s\n ",
    L.icons.character, L.labels.characterName, charName,
    L.icons.charId, L.labels.charId, charId,
    L.icons.group, L.labels.group, group
  )

  local actionInfo = message or (L.fallback and L.fallback.noMessage) or "No message available"

  local fields = {
    { name = L.fields.playerInfo,    value = playerInfo, inline = false },
    { name = L.fields.characterInfo, value = charInfo,   inline = false },
    { name = L.fields.action,        value = actionInfo, inline = false }
  }

  if coords and Config.GrafanaPosition.enabled then
    local x, y, z = coords.x or 0, coords.y or 0, coords.z or 0
    local template = Config.GrafanaPosition.urlTemplate
    local generatedUrl = template and string.format(template, x, y, z) or nil
    local linkLabel = Config.GrafanaPosition.name or "Check Position"

    if generatedUrl then
      table.insert(fields, {
        name = (L.fields and L.fields.position) or "📍 Position",
        value = string.format("(%.2f | %.2f | %.2f)\n[%s](%s)", x, y, z, linkLabel, generatedUrl),
        inline = true
      })
    end
  end

  local title = icon .. " **" .. playerName .. " " ..
      (((Language.titlesByAction and Language.titlesByAction[action]) or (Language.fallback and Language.fallback.unknownAction) or
        "Unknown Action"))
      .. " " .. SERVER_NAME .. " Server**"

  local embed = buildEmbed(title, embedColor, fields)

  safeWebhook({
    content = pingContent,
    embeds = embed
  })
end

AddEventHandler('txAdmin:events:playerDirectMessage', function(eventData)
  LogDM(eventData.author, GetPlayerName(eventData.target), eventData.message)
end)

AddEventHandler('txAdmin:events:actionRevoked', function(eventData)
  local action = L.ban or "Ban"

  if eventData.actionType == 'ban' then
    action = L.Ban
  elseif eventData.actionType == 'warn' then
    action = L.Warn
  end

  LogRevoke(eventData.revokedBy, eventData.actionId, action)
end)

AddEventHandler('txAdmin:events:playerKicked', function(eventData)
  LogKick(eventData.author, GetPlayerName(eventData.target), eventData.reason)
end)

AddEventHandler('txAdmin:events:playerBanned', function(eventData)
  if eventData.expiration == false then
    LogBan(eventData.author, eventData.targetName, eventData.reason, L.permanent, eventData
      .actionId)
  else
    LogBan(eventData.author, eventData.targetName, eventData.reason, os.date('%d.%m.%Y %H:%M:%S', eventData.expiration),
      eventData.actionId)
  end
end)

AddEventHandler('txAdmin:events:playerWarned', function(eventData)
  local steamid = L.NotFound
  local license = L.notFound
  local discord = L.notFound

  for _, identifier in ipairs(eventData.targetIds) do
    if identifier:sub(1, 6) == "steam:" and steamid == L.notFound then
      steamid = identifier
    elseif identifier:sub(1, 8) == "license:" and license == L.notFound then
      license = identifier
    elseif identifier:sub(1, 8) == "discord:" and discord == L.notFound then
      discord = identifier
    end
  end

  LogWarning(eventData.author, GetPlayerName(eventData.targetNetId), eventData.reason,
    string.format("Steam ID: %s\nLicense: %s\nDiscord: %s\nBan ID: %s",
      steamid, license, tostring(eventData.actionId or (L.notFound or "Not Found"))))
end)

function LogKick(admin, player, reason)
  local embed = buildEmbed(
    "**" .. (L.kicked or "Player has been kicked") .. "**",
    (Config.Colors and Config.Colors.kick) or (Config.Colors and Config.Colors.red) or 16711680,
    {
      { name = L.adminName or "Admin Name", value = admin,  inline = true },
      { name = L.target or "Target Player", value = player, inline = true },
      { name = L.reason or "Reason",        value = reason, inline = true }
    }
  )

  safeWebhook({ embeds = embed })
end

function LogWarning(admin, player, reason, ids)
  local embed = buildEmbed(
    "**" .. (L.warned or "Player has been warned") .. "**",
    (Config.Colors and Config.Colors.warn) or Config.Colors.Red,
    {
      { name = L.adminName or "Admin Name",   value = admin,  inline = true },
      { name = L.target or "Target Player",   value = player, inline = true },
      { name = L.reason or "Reason",          value = reason, inline = true },
      { name = L.ids or "Target Identifiers", value = ids,    inline = true }
    }
  )

  safeWebhook({ embeds = embed })
end

function LogBan(admin, player, reason, expires, banid)
  local embed = buildEmbed(
    "**" .. (L.banned or "Player has been banned") .. "**",
    (Config.Colors and Config.Colors.ban) or (Config.Colors and Config.Colors.red) or 16711680,
    {
      { name = L.adminName or "Admin Name",      value = admin,   inline = true },
      { name = L.target or "Target Player",      value = player,  inline = true },
      { name = L.reason or "Reason",             value = reason,  inline = true },
      { name = L.expiration or "Ban Expiration", value = expires, inline = true },
      { name = L.banId or "Ban ID",              value = banid,   inline = true }
    }
  )

  safeWebhook({ embeds = embed })
end

function LogRevoke(admin, banId, type)
  local embed = buildEmbed(
    "**" .. (L.revoked or "Action Revoked") .. "**",
    (Config.Colors and Config.Colors.revoked) or (Config.Colors and Config.Colors.blue) or 255,
    {
      { name = L.revokedBy or "Revoked By", value = admin, inline = true },
      { name = L.banId or "Ban ID",         value = banId, inline = true },
      { name = L.type or "Action Type",     value = type,  inline = true }
    }
  )

  safeWebhook({ embeds = embed })
end

function LogDM(admin, player, message)
  local embed = buildEmbed(
    "**" .. (L.dm or "Direct Message") .. "**",
    (Config.Colors and Config.Colors.dm) or (Config.Colors and Config.Colors.blue) or 255,
    {
      { name = L.adminName or "Admin Name", value = admin,   inline = true },
      { name = L.target or "Target Player", value = player,  inline = true },
      { name = L.message or "Message",      value = message, inline = true }
    }
  )

  safeWebhook({ embeds = embed })
end
