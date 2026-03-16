if Config.Language ~= "de" then return end

Language = Language or {}

Language.titlesByAction = {
    playerModeChanged = 'Spielermodus geändert',
    teleportWaypoint = 'Zum Wegpunkt teleportiert',
    teleportCoords = 'Zu Koordinaten teleportiert',
    spawnVehicle = 'Fahrzeug gespawnt',
    deleteVehicle = 'Fahrzeug gelöscht',
    vehicleRepair = 'Fahrzeug repariert',
    vehicleBoost = 'Fahrzeug-Boost aktiviert',
    healSelf = 'Sich selbst geheilt',
    healAll = 'Alle Spieler geheilt',
    announcement = 'Serverweite Ankündigung',
    clearArea = 'Bereich bereinigt',

    spectatePlayer = 'Beobachtet Spieler',
    freezePlayer = 'Spieler eingefroren',
    teleportPlayer = 'Zum Spieler teleportiert',
    healPlayer = 'Spieler geheilt',
    summonPlayer = 'Spieler herbeigerufen',

    drunkEffect = 'Trunkenheits-Effekt ausgelöst',
    setOnFire = 'Spieler angezündet',
    wildAttack = 'Wildtier-Angriff ausgelöst',

    showPlayerIDs = 'Spieler-IDs umgeschaltet',
}

Language.locale = {
    restartingNow = 'Der Server startet JETZT neu!',
    restarting = '🔁 Der Server startet bald neu!',
    dm = '💬 Direktnachricht',
    revoked = '⏪ Aktion widerrufen',
    kicked = '🚫 Spieler wurde gekickt',
    warned = '❗ Spieler wurde verwarnt',
    banned = '❌ Spieler wurde gebannt',
    heal = '🏥 Admin-Heilung',
    announcement = '🔔 Neue Server-Ankündigung',
    whitelist = '📃 Whitelist aktualisiert',

    permanent = 'PERMANENT',
    minutesRemaining = 'Verbleibende Minuten',
    adminName = 'Admin Name',
    revokedBy = 'Widerrufen von',
    target = 'Ziel-Spieler',
    reason = 'Grund',
    ids = 'Identifikatoren',
    expiration = 'Ablauf des Banns',
    banId = 'Bann-ID',
    announcer = 'Anrufer/Sprecher',
    message = 'Nachricht',
    type = 'Aktionstyp',
    license = 'Spieler-Lizenz',

    notFound = 'Nicht gefunden',
    ban = 'Bann',
    warn = 'Warnung',

    icons = {
        player = "🤵",
        discord = "💻",
        character = "👤",
        charId = "🆔",
        group = "🛡️"
    },

    labels = {
        playerName = "Spielername",
        discord = "Discord",
        characterName = "Charaktername",
        charId = "Charakter-ID",
        group = "Gruppe"
    },

    fields = {
        playerInfo = "🧾 Spieler-Informationen",
        characterInfo = "📖 Charakter-Informationen",
        action = "🎯 Aktion",
        position = "📍 Position"
    },

    fallback = {
        noMessage = "Keine Nachricht verfügbar"
    },

    pingUnauthorizedCharacter = '⚠️ TX-Nutzung mit normalem Charakter',
}

Language.fallback = {
    unknownServer = 'Unbekannter Server',
    unknown = 'Unbekannt',
    unknownAction = 'Unbekannte Aktion',
    pingHere = '@here',
}

Language.actionMessages = {
    spectatePlayer = 'hat angefangen, Spieler %s zu beobachten',
    freezePlayer = 'hat das Einfrieren für Spieler %s umgeschaltet',
    healPlayer = 'hat Spieler %s geheilt',
    summonPlayer = 'hat Spieler %s zu sich gerufen',
    drunkEffect = 'hat Trunkenheits-Effekt bei %s ausgelöst',
    setOnFire = 'hat %s angezündet',
    wildAttack = 'hat einen Wildtier-Angriff auf %s gestartet',
    teleportPlayer = 'ist zu Spieler %s teleportiert (x=%.3f y=%.3f z=%.3f)',
}

Language.menuEvents = {
    playerModeChanged = {
        godmode = { message = 'hat Godmode aktiviert', icon = '🛡️ ', color = 'orange' },
        noclip = { message = 'hat Noclip aktiviert', icon = '🕊️ ', color = 'yellow' },
        superjump = { message = 'hat Super-Jump aktiviert', icon = '🚀 ', color = 'blue' },
        none = { message = 'ist zum normalen Spielermodus zurückgekehrt', icon = '⬇ ', color = 'blue' },
        default = { message = 'hat den Spielermodus zu "Unbekannt" geändert', icon = '❓ ' },
    },

    teleportWaypoint = { message = 'ist zu einem Wegpunkt teleportiert', icon = '📍 ', color = 'orange' },

    teleportCoords = {
        icon = '🧭 ',
        color = 'orange',
        format = function(data)
            if type(data) ~= 'table' then return nil end
            local x, y, z = data.x or 0.0, data.y or 0.0, data.z or 0.0
            return ('ist zu Koordinaten teleportiert (x=%.3f, y=%0.3f, z=%0.3f)'):format(x, y, z)
        end
    },

    spawnVehicle = {
        icon = '🚗 ',
        color = 'red',
        format = function(data)
            if type(data) ~= 'string' then return nil end
            return 'hat ein Fahrzeug gespawnt (Modell: ' .. data .. ')'
        end
    },

    deleteVehicle = { message = 'hat ein Fahrzeug gelöscht', icon = '🗑️ ', color = 'orange' },
    vehicleRepair = { message = 'hat sein Fahrzeug repariert', icon = '🔧 ', color = 'blue' },
    vehicleBoost = { message = 'hat sein Fahrzeug geboostet', icon = '⚡ ', color = 'blue' },
    healSelf = { message = 'hat sich selbst geheilt', icon = '💉 ', color = 'yellow' },
    healAll = { message = 'hat alle Spieler geheilt!', icon = '❤️ ', color = 'red' },

    announcement = {
        icon = '📢 ',
        color = 'orange',
        format = function(data)
            if type(data) ~= 'string' then return nil end
            return 'hat eine serverweite Ankündigung gemacht: ' .. data
        end
    },

    clearArea = {
        icon = '🧹 ',
        color = 'orange',
        format = function(data)
            if type(data) ~= 'number' then return nil end
            return 'hat einen Umkreis von ' .. data .. 'm bereinigt'
        end
    },

    spectatePlayer = { icon = '🎥 ', color = 'red' },
    freezePlayer = { icon = '❄️ ', color = 'red' },
    teleportPlayer = { icon = '👣 ', color = 'yellow' },
    healPlayer = { icon = '🩹 ', color = 'orange' },
    summonPlayer = { icon = '📨 ', color = 'orange' },

    drunkEffect = { message = 'hat Trunkenheits-Effekt bei %s ausgelöst', icon = '🍻 ', color = 'red' },
    setOnFire = { message = 'hat %s angezündet', icon = '🔥 ', color = 'red' },
    wildAttack = { message = 'hat einen Wildtier-Angriff auf %s ausgelöst', icon = '🐗 ', color = 'red' },

    showPlayerIDs = {
        icon = '🆔 ',
        color = 'orange',
        format = function(data)
            if type(data) ~= 'boolean' then return nil end
            if data then return 'hat die Anzeige der Spieler-IDs aktiviert' end
            return 'hat die Anzeige der Spieler-IDs deaktiviert'
        end
    },
}
