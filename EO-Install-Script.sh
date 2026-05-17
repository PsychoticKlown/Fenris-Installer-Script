#!/bin/bash
### Description: Fenris-Debian install
### Originally written for Debian by: Demonslayer Azaph - https://forums.eveonline.com/t/eve-with-just-wine-privacy-friendly/511392 on 2026-05-10 v1.0
### Version v0.0.1 2026-05-16 - PsychoticKlown (Made 3 more widely usable scripts for various deb distributions including Kali)

### Boilerplate Warning
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


scriptversion="1.1.0"
scriptdate="2026-05-14"

set -euo pipefail

# 1. Kali Safety Environment Guard
if [ "$EUID" -eq 0 ]; then
    echo "ERROR: Wine cannot run safely as root on Kali Linux."
    echo "Please switch to a standard user account (e.g., su - kali) and run the script again."
    exit 1
fi

# 2. Advanced Path Configuration & Safeguards (Numeric Input)
RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NC='\033[0m'

while true; do
    echo -n "Enter the absolute root path BEFORE the /EVE/ folder (e.g., /home/$USER/Desktop): "
    read -r INPUT_PATH

    if [ -z "$INPUT_PATH" ]; then
        INPUT_PATH="/opt"
        echo -e "${YELLOW}No path entered. Using default root: $INPUT_PATH${NC}"
    fi

    INPUT_PATH="${INPUT_PATH%/}"
    BASE_EVE_DIR="$INPUT_PATH/EVE"
    TARGET_EVE_DIR="$BASE_EVE_DIR/Online"

    echo "Validating path: $TARGET_EVE_DIR"

    if [ -d "$TARGET_EVE_DIR" ] && [ "$(ls -A "$TARGET_EVE_DIR" 2>/dev/null)" ]; then
        echo -e "${YELLOW}Warning: Target directory '$TARGET_EVE_DIR' already exists and is not empty!${NC}"
        echo "Do you want to overwrite it?"
        echo " 1) Yes, overwrite the directory"
        echo " 2) No, choose a different path"
        
        while true; do
            read -p "Please enter a number selection (1 or 2): " REPLY
            case $REPLY in
                1) break ;;
                2) echo "Overwrite declined. Restarting path selection..."; echo ""; continue 2 ;;
                *) echo "Invalid option. Please enter 1 or 2." ;;
            esac
        done

        echo -e "${RED}CRITICAL: This will overwrite files in the directory!${NC}"
        echo "Are you absolutely sure you want to proceed?"
        echo " 1) Yes, I am absolutely sure"
        echo " 2) No, abort and check path"
        
        while true; do
            read -p "Please enter a number selection (1 or 2): " REPLY
            case $REPLY in
                1) break ;;
                2) echo "Double confirmation declined. Restarting path selection..."; echo ""; continue 2 ;;
                *) echo "Invalid option. Please enter 1 or 2." ;;
            esac
        done

        echo -e "\n${RED}============================================================${NC}"
        echo -e "${RED}!! ATTENTION !!${NC}"
        echo -e "${YELLOW}Please BACKUP any character settings, profiles, or cache files${NC}"
        echo -e "${YELLOW}located inside the directory before continuing.${NC}"
        echo -e "${RED}============================================================${NC}\n"
        
        echo "Safety Check:"
        echo " 1) OK (Backups are safe, continue installation)"
        echo " 2) Cancel (Stop installation to make backups)"
        
        while true; do
            read -p "Please enter a number selection (1 or 2): " REPLY
            case $REPLY in
                1) echo -e "${GREEN}Backup acknowledged. Proceeding...${NC}"; break 2 ;;
                2) echo -e "${YELLOW}Installation aborted by user to perform backups.${NC}"; exit 0 ;;
                *) echo "Invalid option. Please enter 1 or 2." ;;
            esac
        done
    else
        echo -e "${GREEN}Target directory path validated successfully.${NC}"
        break
    fi
done

export EVE_DIR="$TARGET_EVE_DIR"
export WINEPREFIX="$EVE_DIR"
export WINEARCH=win64
export WINEDLLOVERRIDES="winemenubuilder.exe=d"

export DX11_CACHE="$EVE_DIR/cache/dxvk"
export DX12_CACHE="$EVE_DIR/cache/vkd3d"
export MESA_CACHE="$EVE_DIR/cache/mesa"

echo "Configuring prefix structures..."
mkdir -p "$EVE_DIR" "$DX11_CACHE" "$DX12_CACHE" "$MESA_CACHE" "$EVE_DIR/drive_c/users/Public/Downloads"

echo "Bootstrapping Wine engine via virtualized CPU runtime..."
if [ -n "${WAYLAND_DISPLAY:-}" ] && command -v weston &>/dev/null; then weston --no-config --backend=headless --socket=wl-env & VPID=$!; export WAYLAND_DISPLAY=wl-env; export DISPLAY=""; else sudo rm -f /tmp/.X103-lock /tmp/.X11-unix/X103; Xvfb :103 -screen 0 1280x720x24 -ac & VPID=$!; export DISPLAY=:103; fi; export LIBGL_ALWAYS_SOFTWARE=1; export GALLIUM_DRIVER="llvmpipe"; wineboot -u; kill $VPID

# 3. Handle External Prerequisites (With Active Progress Tracking)
echo "Injecting rendering targets via winetricks..."
echo "Installing prerequisites... (Tracking live log: /tmp/winetricks.log)"
winetricks corefonts d3dcompiler_47 dxvk > /tmp/winetricks.log 2>&1 & WPID=$!
while kill -0 $WPID 2>/dev/null; do echo -n "."; sleep 2; done
echo -e "\nPrerequisites installation complete!"

# 4. Pull Online Remote Binary Payload
DOWNLOAD_DIR="$EVE_DIR/drive_c/users/Public/Downloads"
cd "$DOWNLOAD_DIR"

echo "Fetching target distribution package..."
wget -q --show-progress -U "Mozilla/5.0" -O eve-setup.exe "https://launcher.ccpgames.com/eve-online/release/win32/x64/eve-online-latest+Setup.exe"

# 5. Extract Package Assets (Robust Deep-Unpack Engine)
LAUNCHER_DIR="$EVE_DIR/drive_c/EVE_Launcher"
echo "Extracting parent container layers..."
mkdir -p "$LAUNCHER_DIR"
7z x -y eve-setup.exe -o"$LAUNCHER_DIR" > /dev/null

echo "Scanning for nested payload dependencies..."
cd "$LAUNCHER_DIR"
find . -type f -name "*.nupkg" -exec 7z x -y {} -o"$LAUNCHER_DIR" \; > /dev/null

if [ ! -f "$LAUNCHER_DIR/lib/net45/eve-online.exe" ]; then
    echo -e "${RED}ERROR: File integrity check failed! 'eve-online.exe' missing.${NC}"
    exit 1
fi
chmod +x "$LAUNCHER_DIR/lib/net45/eve-online.exe"

# 6. Isolate Artwork Resources
echo "Isolating high-res emblem layout elements..."
ICON_DIR="$EVE_DIR/icons"
mkdir -p "$ICON_DIR"

7z x -y "$DOWNLOAD_DIR/eve-setup.exe" -o"$ICON_DIR" "\$PLUGINSDIR/installer_icon.ico" > /dev/null 2>&1 || true

if [ ! -f "$ICON_DIR/\$PLUGINSDIR/installer_icon.ico" ]; then
    7z x -y "$LAUNCHER_DIR/lib/net45/eve-online.exe" -o"$ICON_DIR" "app.ico" > /dev/null 2>&1 || true
    FINAL_ICON="$ICON_DIR/app.ico"
else
    FINAL_ICON="$ICON_DIR/\$PLUGINSDIR/installer_icon.ico"
fi

# 7. Write Custom X11 Native Application Entry
SHORTCUT_PATH="$HOME/Desktop/EVE-Online.desktop"
echo "Creating application shortcut entry: $SHORTCUT_PATH"

cat << EOF > "$SHORTCUT_PATH"
[Desktop Entry]
Name=EVE Online
Comment=Launch EVE Online via Extracted Wine Runtime
Exec=env WINEPREFIX="$EVE_DIR" DXVK_STATE_CACHE_DIR="$DX11_CACHE" VKD3D_SHADER_CACHE_DIR="$DX12_CACHE" MESA_GL_CACHE_DIR="$MESA_CACHE" wine "$LAUNCHER_DIR/lib/net45/eve-online.exe" --disable-gpu-sandbox --no-sandbox
Terminal=false
Type=Application
Categories=Game;
Icon=03C3_eve-online.0
EOF

chmod +x "$SHORTCUT_PATH"
echo "Done! Eve Online is installed, and The shortcut is ready on your desktop."
