<div align="center">

![ludwig_txlogs](https://forum-cfx-re.akamaized.net/original/5X/4/0/d/1/40d1226364dcf078fcdb8c7fd97a3be0b9360e53.jpeg)

# 📋 LUDWIG TXLOGS

### _The Professional txAdmin Audit Trail for RedM — Completely Free_

[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/KTbTMDw3ge)
[![License](https://img.shields.io/badge/Free-Open%20Source-brightgreen?style=for-the-badge)](https://github.com/ludwig-development/ludwig_txlogs)

</div>

Stop flying blind on your own server. **Ludwig txLogs** hooks into every txAdmin action and fires it straight to your Discord — formatted, colour-coded, and packed with player data — so nothing your admins do ever goes unrecorded.

---

## 🚀 Key Features

- **Full txAdmin Action Coverage** — Every kick, ban, warning, DM, revocation, teleport, spectate, heal, vehicle spawn, and more is captured the moment it happens. No action slips through.

- **Rich Discord Embeds** — Each log hits your webhook as a colour-coded embed — ban in red, kick in cyan, warn in orange — with player name, Discord ID, character name, character group, job, and full coordinate data all in one place.

- **Unauthorized Character Detection** — The moment an admin uses txAdmin on a non-whitelisted character, the log fires in red and pings your configured Discord roles immediately. Catch misuse before it becomes a problem.

- **Position Tracking & Grafana Integration** — Every logged action records the player's exact coordinates. Optionally link those coordinates to a Grafana dashboard so you can click straight from Discord to a map view of where the action took place.

- **Job & Group Restrictions** — Define exactly which character groups (`admin`, `event`, or your own) are authorised to use txAdmin. Everyone else gets flagged and your team gets pinged.

- **Dev / Live Server Separation** — Ludwig txLogs auto-detects whether it is running on your development or live server and prefixes every log accordingly. Dev noise never pollutes your live audit channel.

- **Multi-Language Support** — Full English and German localisation out of the box. Everything is open — translate every string to your liking.

---

## 👀 Preview

![Discord Logging Example](https://forum-cfx-re.akamaized.net/original/5X/0/7/2/f/072fc2bc7b0b7e0cf507832465ce7dd41610590e.png)

---

## 🛠 Technical Excellence

### 🔴 Native VORP & RSG Support

Ludwig txLogs ships with a **ready-made bridge for both VORP Core and RSG**. Character data, group checks, and session validation are handled through the bridge automatically — swap `Config.Framework` and you are done.

### 🌉 Bridge Architecture

If you run a custom framework, drop in your own adapter and the entire logging system works without touching a single line of core logic.

---

## 📝 How It Works

1. **An admin takes action** — Any txAdmin menu event fires — ban, kick, heal, teleport, spectate, you name it.
2. **Ludwig captures the context** — Player ID, character data, group, job, and coordinates are pulled instantly.
3. **Permission is validated** — If the character is not in an authorised group, the embed is flagged red and your Discord roles are pinged.
4. **The embed lands in Discord** — Colour-coded, fully detailed, timestamped — ready for your moderation team to review.
5. **Optionally, jump to the map** — Click the position link in the embed to open the Grafana position view directly.

---

<div align="center">

**Your server audit trail starts the moment you paste in the webhook URL.**
**Ludwig txLogs is free — no strings attached.**

[![Discord](https://img.shields.io/badge/Discord-Join%20Support%20Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/KTbTMDw3ge)

</div>
