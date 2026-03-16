if Config.Language ~= "en" then return end

Language = Language or {}

Language.titlesByAction = {
  playerModeChanged = 'Player mode changed',
  teleportWaypoint = 'Teleported to waypoint',
  teleportCoords = 'Teleported to coordinates',
  spawnVehicle = 'Vehicle spawned',
  deleteVehicle = 'Vehicle deleted',
  vehicleRepair = 'Vehicle repaired',
  vehicleBoost = 'Vehicle boosted',
  healSelf = 'Healed themselves',
  healAll = 'Healed all players',
  announcement = 'Server-wide announcement',
  clearArea = 'Area cleared',

  spectatePlayer = 'Spectating player',
  freezePlayer = 'Player frozen',
  teleportPlayer = 'Teleported to player',
  healPlayer = 'Player healed',
  summonPlayer = 'Player summoned',

  drunkEffect = 'Drunk effect triggered',
  setOnFire = 'Player set on fire',
  wildAttack = 'Wild attack triggered',

  showPlayerIDs = 'Player IDs toggled',
}

Language.locale = {
  restartingNow = 'Server is restarting NOW!',
  restarting = '🔁 Server is restarting soon!',
  dm = '💬 Direct Message',
  revoked = '⏪ Action Revoked',
  kicked = '🚫 Player has been kicked',
  warned = '❗ Player has been warned',
  banned = '❌ Player has been banned',
  heal = '🏥 Admin Heal',
  announcement = '🔔 New server announcement',
  whitelist = '📃 Whitelist Updated',

  permanent = 'PERMANENT',
  minutesRemaining = 'Minutes Remaining',
  adminName = 'Admin Name',
  revokedBy = 'Revoked By',
  target = 'Target Player',
  reason = 'Reason',
  ids = 'Target Identifiers',
  expiration = 'Ban Expiration',
  banId = 'Ban ID',
  announcer = 'Announcer',
  message = 'Message',
  type = 'Action Type',
  license = 'Player License',

  notFound = 'Not Found',
  ban = 'Ban',
  warn = 'Warning',

  icons = {
    player = "🤵",
    discord = "💻",
    character = "👤",
    charId = "🆔",
    group = "🛡️"
  },

  labels = {
    playerName = "Player Name",
    discord = "Discord",
    characterName = "Character Name",
    charId = "Character ID",
    group = "Group"
  },

  fields = {
    playerInfo = "🧾 Player Information",
    characterInfo = "📖 Character Information",
    action = "🎯 Action",
    position = "📍 Position"
  },

  fallback = {
    noMessage = "No message available"
  },

  pingUnauthorizedCharacter = '⚠️ TX-Usage on normal Character',
}

Language.fallback = {
  unknownServer = 'Unknown Server',
  unknown = 'Unknown',
  unknownAction = 'Unknown Action',
  pingHere = '@here',
}

Language.actionMessages = {
  spectatePlayer = 'started spectating player %s',
  freezePlayer = 'toggled freeze on player %s',
  healPlayer = 'healed player %s',
  summonPlayer = 'summoned player %s',
  drunkEffect = 'triggered drunk effect on %s',
  setOnFire = 'set %s on fire',
  wildAttack = 'triggered wild attack on %s',
  teleportPlayer = 'teleported to player %s (x=%.3f y=%.3f z=%.3f)',
}

Language.menuEvents = {
  playerModeChanged = {
    godmode = { message = 'enabled god mode', icon = '🛡️ ', color = 'orange' },
    noclip = { message = 'enabled noclip', icon = '🕊️ ', color = 'yellow' },
    superjump = { message = 'enabled super jump', icon = '🚀 ', color = 'blue' },
    none = { message = 'returned to normal player mode', icon = '⬇ ', color = 'blue' },
    default = { message = 'changed player mode to unknown', icon = '❓ ' },
  },

  teleportWaypoint = { message = 'teleported to a waypoint', icon = '📍 ', color = 'orange' },

  teleportCoords = {
    icon = '🧭 ',
    color = 'orange',
    format = function(data)
      if type(data) ~= 'table' then return nil end
      local x, y, z = data.x or 0.0, data.y or 0.0, data.z or 0.0
      return ('teleported to coordinates (x=%.3f, y=%0.3f, z=%0.3f)'):format(x, y, z)
    end
  },

  spawnVehicle = {
    icon = '🚗 ',
    color = 'red',
    format = function(data)
      if type(data) ~= 'string' then return nil end
      return 'spawned a vehicle (model: ' .. data .. ')'
    end
  },

  deleteVehicle = { message = 'deleted a vehicle', icon = '🗑️ ', color = 'orange' },
  vehicleRepair = { message = 'repaired their vehicle', icon = '🔧 ', color = 'blue' },
  vehicleBoost = { message = 'boosted their vehicle', icon = '⚡ ', color = 'blue' },
  healSelf = { message = 'healed themselves', icon = '💉 ', color = 'yellow' },
  healAll = { message = 'healed all players!', icon = '❤️ ', color = 'red' },

  announcement = {
    icon = '📢 ',
    color = 'orange',
    format = function(data)
      if type(data) ~= 'string' then return nil end
      return 'made a server-wide announcement: ' .. data
    end
  },

  clearArea = {
    icon = '🧹 ',
    color = 'orange',
    format = function(data)
      if type(data) ~= 'number' then return nil end
      return 'cleared an area with ' .. data .. 'm radius'
    end
  },

  spectatePlayer = { icon = '🎥 ', color = 'red' },
  freezePlayer = { icon = '❄️ ', color = 'red' },
  teleportPlayer = { icon = '👣 ', color = 'yellow' },
  healPlayer = { icon = '🩹 ', color = 'orange' },
  summonPlayer = { icon = '📨 ', color = 'orange' },

  drunkEffect = { message = 'triggered drunk effect on %s', icon = '🍻 ', color = 'red' },
  setOnFire = { message = 'set %s on fire', icon = '🔥 ', color = 'red' },
  wildAttack = { message = 'triggered wild attack on %s', icon = '🐗 ', color = 'red' },

  showPlayerIDs = {
    icon = '🆔 ',
    color = 'orange',
    format = function(data)
      if type(data) ~= 'boolean' then return nil end
      if data then return 'turned show player IDs on' end
      return 'turned show player IDs off'
    end
  },
}
