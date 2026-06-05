# 🛸 Fenris-Debian: Automated EVE Online Linux & EVE Frontier Linux Clean Installers

<!-- Google SEO Signals -->
<!-- Keywords: EVE Online Linux, EVE Frontier Linux, Linux Gaming, Debian EVE Online, Kali Linux EVE Frontier -->

<a href="https://gnu.org"><img src="https://img.shields.io/badge/Shell_Script-GNU-blue?logo=gnu" alt="Shell Script"></a> <a href="https://debian.org"><img src="https://img.shields.io/badge/Platform-Debian-red?logo=debian" alt="Platform"></a> <a href="https://winehq.org"><img src="https://img.shields.io/badge/Wine_Staging-Wine-purple?logo=wine" alt="Wine Staging"></a>

An open-source collection of bulletproof, headless deployment scripts built to cleanly install **EVE Online on Linux** and **EVE Frontier on Linux** (specifically Debian-based distributions, including Kali Linux and Ubuntu). 

This utility simplifies **Linux gaming setup** by bypassing heavy third-party managers (like Steam or Lutris) while keeping your proprietary NVIDIA or AMD graphics drivers completely untouched during installation.

---
**SPECIAL NOTE:** This script only bypasses your GPU during the installation phase. Once installation completes and your desktop shortcut is generated, the game client runs normally using your native graphics hardware acceleration!
---

## 🔍 Why use Fenris for EVE Online & EVE Frontier on Linux?

Many Linux players struggle with launcher crashes or broken graphics configurations when running **EVE Online** or the new **EVE Frontier** on Debian-based distributions. Traditional Linux gaming runners often alter systemic system paths. 

The **Fenris Installer Script** isolates the entire setup engine inside a temporary, software-driven sandbox, ensuring a perfect installation every time without interfering with your system's desktop display drivers.

## ⏳ A Note on Patience During Installation

When running these installation scripts, the terminal will appear to sit or pause at several stages—most notably during **Section 3: Injecting rendering targets via winetricks**. 

**Do not close your terminal or interrupt the process.** Because the installation is forced to run inside an isolated, virtualized CPU framebuffer to protect your operating system's native graphics configuration, certain background translation routines take time to complete. 

---

## 🛠️ What the Script is Doing Behind the Scenes

While the terminal displays tracking updates and progress markers, it is actively processing a complex architecture in background memory that you cannot see:

* **Generating a Virtual Monitor in System RAM:** The script creates an isolated, headless display workspace (`Xvfb :103` or a virtualized headless Wayland compositor) directly inside your system memory. This tricks the setup engines into drawing their configuration interfaces without ever interacting with your host desktop's active display server.
* **Enforcing a Strict CPU Sandbox Layer:** By utilizing `GALLIUM_DRIVER="llvmpipe"` and `LIBGL_ALWAYS_SOFTWARE=1`, the script forces every library instruction to process purely through your CPU cores. This keeps your physical **NVIDIA proprietary graphics drivers completely invisible, isolated, and safe** from accidental modification.
* **Building a Sanitized Wine Prefix Environment:** It silently provisions a clean, independent 64-bit virtual Windows registry structure, explicitly disabling noisy background components like `winemenubuilder.exe` to prevent cluttered shortcut generation across your Linux host system.
* **Carving and Unpacking Hidden Binary Payloads:** Instead of launching an unstable graphical installer window, the script silently fetches the official installer package, uses `7z` to slice directly into the underlying corporate archive blocks, and deeply scans for nested, hidden `.nupkg` runtime components to unpack the actual native game engine.

> **Notice:** The script will explicitly output on-screen notifications to express the rest of what it handles—including structural package integrity checks, custom caching routing, and native Linux desktop environment icon link generation—the moment the background translation blocks finish processing.

---

## 📋 Prerequisites

Before running the installation scripts, your host system must have the required system compatibility layers and extraction utilities installed. Run the following command in your terminal to pull the mandatory packages for **Linux EVE Online** setups:

```bash
sudo apt update && sudo apt install -y wine-staging winetricks p7zip-full
```

* **`wine-staging`**: Provides the advanced Windows API translation layer required to run the game client environments.
* **`winetricks`**: Automates configuration steps and injects mandatory runtime libraries directly into your Wine prefix.
* **`7z` (`p7zip-full`)**: Extractor engine used by the script to dissect setup files and pull out hidden game files seamlessly.

---

## 🚀 How to Run

### For EVE Online Linux Installation:
1. Clone or download `EO-Install-Script.sh`.
2. Give the file execution permissions:
   ```bash
   chmod +x EO-Install-Script.sh
   ```
3. Execute the script as a standard user (**do not run as root**):
   ```bash
   ./EO-Install-Script.sh
   ```

---

### For EVE Frontier Linux Installation:
1. Clone or download `EF-Install-Script.sh`.
2. Give the file execution permissions:
   ```bash
   chmod +x EF-Install-Script.sh
   ```
3. Execute the script as a standard user (**do not run as root**):
   ```bash
   ./EF-Install-Script.sh
   ```
---

## ⚙️ Post-Installation Game Engine Optimization

**DO NOT FORGET:** For the best performance under Wine on Linux, open your launcher settings and:
1. Disable **"Launcher Hardware Acceleration"**.
2. Navigate to your specific game profile settings (*EVE Online Settings* or *EVE Frontier Settings*).
3. Enable **"Download the Full EVE Game Client"**.
4. Under **Select DirectX Version**, ensure **DirectX 11** is selected.

---

### Migrating Profiles & Settings
Want to migrate your existing settings from Steam or Lutris configurations? Check out this guide: [Eve Online - Copy User Interface & Settings Across Multiple Accounts](https://www.youtube.com/watch?v=COzZeYtUUIM&t=18s). Once you understand the folder architecture under Wine, doing the same for this custom prefix or Lutris is highly straightforward.

---

## 📝 Credits & Boilerplate

* **Originally written for Debian by:** Demonslayer Azaph - [eveonline.com forums](https://forums.eveonline.com/t/eve-with-just-wine-privacy-friendly/511392) on 2026-05-10 v1.0
* **Modified for wide Debian/Kali Linux compatibility by:** PsychoticKlown (2026-05-16)

### Boilerplate Warning
```text
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE.
```
