#!/usr/bin/env bash
# VortexMC installer for Linux. Installs the system libraries the AppImage uses, downloads the latest release and adds
# it to the app menu. Everything goes in your home folder; sudo is used only for the distribution packages.
#
#   curl -fsSL https://raw.githubusercontent.com/PABLO-EXT0/VortexMC/main/install.sh | bash
#   ... | bash -s -- --uninstall        remove VortexMC (your instances and worlds in ~/.local/share/vortexmc stay)
#
# VORTEXMC_APPIMAGE=/path/to/file.AppImage installs a local file instead of downloading (for testing a build).
set -euo pipefail

REPO="PABLO-EXT0/VortexMC"
BIN_DIR="$HOME/.local/bin"
APPIMAGE="$BIN_DIR/VortexMC.AppImage"
DESKTOP="$HOME/.local/share/applications/vortexmc.desktop"
ICON="$HOME/.local/share/icons/hicolor/256x256/apps/vortexmc.png"

say()  { printf '\033[1;35m==>\033[0m %s\n' "$*"; }
fail() { printf '\033[1;31merror:\033[0m %s\n' "$*" >&2; exit 1; }

if [ "${1:-}" = "--uninstall" ]; then
    rm -f "$APPIMAGE" "$BIN_DIR/vortexmc" "$DESKTOP" "$ICON"
    say "VortexMC removed. Your data is still in ~/.local/share/vortexmc (delete it yourself if you want)."
    exit 0
fi

[ "$(uname -m)" = "x86_64" ] || fail "VortexMC is built for x86_64 only (this machine is $(uname -m))."
command -v curl >/dev/null || fail "curl is required."
SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"

# GTK 3 + WebKitGTK 4.1 with their GObject introspection data (the window), FUSE 2 (to run an AppImage), libsecret
# (to keep sign-in tokens in the system keyring).
. /etc/os-release 2>/dev/null || true
ids=" ${ID:-} ${ID_LIKE:-} "
say "Installing system libraries (WebKitGTK, GTK, FUSE)..."
if command -v pacman >/dev/null && [[ $ids == *" arch "* || $ids == *" archlinux "* || -f /etc/arch-release ]]; then
    $SUDO pacman -S --needed --noconfirm webkit2gtk-4.1 gtk3 fuse2 libsecret
elif command -v apt-get >/dev/null; then
    $SUDO apt-get update -q
    fuse=libfuse2t64; apt-cache show libfuse2t64 >/dev/null 2>&1 || fuse=libfuse2
    $SUDO apt-get install -y -q gir1.2-webkit2-4.1 gir1.2-gtk-3.0 "$fuse" gir1.2-secret-1
elif command -v dnf >/dev/null; then
    $SUDO dnf install -y webkit2gtk4.1 gtk3 fuse-libs libsecret
elif command -v zypper >/dev/null; then
    $SUDO zypper --non-interactive install typelib-1_0-WebKit2-4_1 typelib-1_0-Gtk-3_0 libfuse2 typelib-1_0-Secret-1
else
    say "Unknown package manager. Install these yourself: WebKitGTK 4.1 and GTK 3 with their GObject introspection"
    say "typelibs, FUSE 2, and libsecret. Continuing."
fi

mkdir -p "$BIN_DIR" "$(dirname "$DESKTOP")" "$(dirname "$ICON")"
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
if [ -n "${VORTEXMC_APPIMAGE:-}" ]; then
    cp "$VORTEXMC_APPIMAGE" "$tmp/VortexMC.AppImage"
else
    say "Finding the latest release..."
    url="$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
           | grep -o '"browser_download_url": *"[^"]*x86_64\.AppImage"' | head -n1 | sed 's/.*"\(https[^"]*\)"/\1/')"
    [ -n "$url" ] || fail "No AppImage found in the latest release of $REPO."
    say "Downloading $(basename "$url")..."
    curl -fL --progress-bar -o "$tmp/VortexMC.AppImage" "$url"
fi
chmod +x "$tmp/VortexMC.AppImage"
mv -f "$tmp/VortexMC.AppImage" "$APPIMAGE"          # one file the launcher's updater can replace in place
ln -sf "$APPIMAGE" "$BIN_DIR/vortexmc"

# Icon from inside the AppImage (no FUSE needed for this).
(cd "$tmp" && "$APPIMAGE" --appimage-extract vortexmc.png >/dev/null 2>&1 && cp squashfs-root/vortexmc.png "$ICON") || true
cat > "$DESKTOP" <<EOF
[Desktop Entry]
Type=Application
Name=VortexMC
Comment=A modern Minecraft launcher
Exec="$APPIMAGE" %u
Icon=vortexmc
Categories=Game;
Terminal=false
StartupWMClass=VortexMC
EOF
command -v update-desktop-database >/dev/null && update-desktop-database "$(dirname "$DESKTOP")" >/dev/null 2>&1 || true

say "VortexMC is installed. Open it from your app menu, or run: vortexmc"
case ":$PATH:" in *":$BIN_DIR:"*) ;; *) say "(Add $BIN_DIR to your PATH to use the 'vortexmc' command.)";; esac
