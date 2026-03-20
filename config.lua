Config = Config or {}

Config.Debug = false

Config.Language = "en"    -- available: "en", "de"

Config.Framework = "vorp" -- available: "vorp", "rsg"

Config.AllowedGroups = { "admin" }

Config.Webhook = {
  url = '',
  username = '[txAdmin Logs]',
  avatarUrl = false, -- or string
}

Config.Colors = {
  warn = 16744192,
  kick = 65535,
  ban = 16711680,
  heal = 65280,
  announcement = 8421504,
  restart = 16776960,
  dm = 13938487,
  revoked = 255,
  whitelist = 255,
  red = 13369344,
  blue = 65535,
  yellow = 13434624,
  orange = 13395456,
}

Config.Pings = {
  whoToPing = { 1483053075592904706 },

  triggerEvents = {
    unauthorizedCharacter = true, -- TX-Usage on not Authorized Char
  },


  roleOverrides = { -- enables you to overwrite who to ping on certain events, if not found will use "whoToPing"
    -- unauthorizedCharacter = { '123', '456' },
  },
}

Config.Servers = {
  dev = {
    identifyBy = "development", -- a String in the Servername so Server can be identified
    name = "[DEV]"              -- how to name in logs, Dev Server only logs if Config.Debug = true
  },
  live = { name = "[LIVE]" }
}

Config.AllowedCharacterGroups = { "admin", "event" }

Config.GrafanaPosition = { -- if you host a Grafana and want to see where this was withough having to log in! If Ludwig Developement makes profit i will host one for you too see withouth hosting your own.
  enabled = true,
  name = "🔎 check Position",
  urlTemplate = function(x, y, z)
    return string.format(
      "https://sns-grafana.snsrp.de/d/positionssuche?orgId=1&from=now-6h&to=now&timezone=browser&var-coordinates=%.2f,%.2f,%.2f",
      x, y, z)
  end
}
