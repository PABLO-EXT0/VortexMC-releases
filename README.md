# VortexMC

A modern, fast, secure Minecraft launcher for Windows and Linux, vibecoded for your needs ;)

> Want to build your own? Prompt for your AI of choice: *"Create VortexMC. Make no mistakes."*

> **VortexMC is an independent project. It is not affiliated with, endorsed by or connected to Mojang AB, Microsoft or Minecraft.** "Minecraft" is a trademark of Mojang. VortexMC never bundles Minecraft files: game files are downloaded from Mojang's official servers, and you must own Minecraft and accept the [Minecraft EULA](https://www.minecraft.net/eula) to play online.

## Highlights

- **One place for everything:** vanilla, Fabric, Quilt, Forge, NeoForge and Horizon instances side by side
- **Discover** mods, modpacks, shaders, resource packs and data packs from Modrinth and CurseForge in one search
- **It tells you what will break before you launch**, highlights it, and fixes it in one click
- **Horizon support** (the Rust rewrite of Minecraft Java), including native mod preparation without the official Horizon launcher
- **Beautiful and alive:** liquid glass themes, custom themes and presets, a 3D skin that follows your cursor
- **Secure by default:** hash-checked downloads, signed updates, no telemetry

## Features

### Launcher
- Desktop app with a Python backend and a fast HTML/CSS/JS interface
- Create instances for any Minecraft version, with live console output and one-click launch
- Automatic Java detection and download for each Minecraft version
- Parallel, resumable downloads with hash verification and a shared asset and library cache
- Downloads survive restarts, with taskbar progress
- Undo toasts and a trash folder in place of most confirmation dialogs
- Hover prefetch that restores your last page, scroll position and filters
- Splash screen, first-run setup, notifications, command palette, tray and self-updater

### Loaders and Horizon
- Vanilla, Fabric, Quilt, Forge and NeoForge instances, with switchable loader versions
- Horizon instances (the Rust rewrite of Minecraft Java 26.3), including native mod preparation without the official Horizon launcher
- Horizon screenshots tab and full mod support: registry browser, updates with rollback, mod sets, Safe mode and `.hpack` modpacks

### Content
- Discover: search Modrinth and CurseForge together for mods, modpacks, shaders, resource packs and data packs
- Filters for Minecraft version, loader, category, sort and source, with incompatible results hidden or clearly marked
- One-click installs with required dependencies
- Mod manager with enable and disable, update all with rollback, version switching, and duplicate and dependency warnings
- Resource pack and shader pack manager with drag-to-reorder and presets
- Modpack install, update and export (`.mrpack` and CurseForge zip)
- Import from other launchers: official `.minecraft`, Prism and MultiMC

### Health and reliability
- Repair instance re-verifies and re-downloads game files
- Pre-launch compatibility check that flags problems in red, amber or blue, with one-click fixes and launch gating
- Crash analyzer that names the likely culprit mod
- Health badge on every instance

### Performance
- Fast mode with one-click performance presets, JVM presets and RAM recommendations
- A light launcher: lazy-loaded pages, virtualized lists and cached API responses

### Look and feel
- Dark, light, AMOLED and liquid glass themes, with tints and a custom theme editor
- Appearance presets that switch the whole look in one click, per instance if you want
- Animated interface with reduced-motion and Lite modes
- 3D skin on the home page that follows your cursor, over a panorama background, with custom skin PNGs
- Accessibility: keyboard navigation, focus rings and high-contrast mode

### Accounts
- Multiple accounts with a switcher and skin viewer
- Microsoft sign-in [ just play offline bro ]

### Worlds and servers
- World list, backup and restore
- Screenshots gallery
- Server list with ping and MOTD

### Security
- Every download checked against its hash and an allowlist of trusted hosts
- Path and archive safety checks
- Tokens stored in the OS keyring, with logs and exports redacted
- Security center, import review screen and audit log

### Integrations
- Discord rich presence

## Install

Download the latest build for your system from the [Releases](../../releases) page.

| System | Download |
|---|---|
| Windows | The installer (`.exe`) |
| Linux | The AppImage or archive |

macOS is not officially supported yet.

**Requirements**
- You do not need to install Java. VortexMC downloads the right one for each Minecraft version.
- Windows: the Microsoft Edge WebView2 runtime (already present on current Windows 10 and 11).
- Linux: GTK and WebKitGTK for the app window. On Debian and Ubuntu that is usually `python3-gi` and `gir1.2-webkit2-4.1`; package names vary by distribution.

## Getting started

1. Open VortexMC and finish the first-run setup.
2. Sign in with Microsoft, or use an offline profile.
3. Create an instance (pick a Minecraft version and a loader, or Horizon).
4. Open **Discover** to add mods, shaders and packs, then press **Launch**.


### About Horizon
Horizon support is an unofficial, experimental integration with the independent [Horizon](https://github.com/horizon-rust/horizon) project. For now multiplayer is offline-only, Java mods do not run on Horizon, and native Horizon mods are compiled on your machine, so VortexMC asks you to confirm before it builds any. VortexMC is not affiliated with the Horizon project.

## Security

Everything that arrives from outside is treated as untrusted: downloads are HTTPS-only from a short list of sites and hash-checked before use, archives are checked before unpacking, updates must carry the maintainer's Ed25519 signature, and logs and exports are redacted. There is no telemetry. Details: [docs/SECURITY.md](docs/SECURITY.md). To report a vulnerability, see [SECURITY.md](SECURITY.md).

## Contributing

Issues and pull requests are welcome, Reach out in discord for more information.

## License

MIT, see [LICENSE](LICENSE). Third-party notices: [THIRD_PARTY_LICENSES](THIRD_PARTY_LICENSES/README.md).

## Credits

Thanks to Modrinth and CurseForge for their APIs, to the Horizon project, and to the authors of the open-source libraries, fonts and icons listed in the third-party notices. Minecraft is a trademark of Mojang AB.
