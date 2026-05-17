# 🛸 Fenris-Debian: Automated EVE Online & EVE Frontier Clean Installers

[![Shell Script](https://shields.io)](https://gnu.org)
[![Platform](https://shields.io)](https://debian.org)
[![Wine Staging](https://shields.io)](https://winehq.org)

A collection of bulletproof, headless deployment scripts built to cleanly install **EVE Online** and **EVE Frontier** on Debian-based distributions (including Kali Linux and Ubuntu) without breaking, downgrading, or touching your proprietary graphics drivers.

---

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

## 🚀 How to Run

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

or

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


## 📝 Credits & Boilerplate

* **Originally written for Debian by:** Demonslayer Azaph - eveonline.com on 2026-05-10 v1.0
* **Modified for wide Debian/Kali compatibility by:** PsychoticKlown (2026-05-16)

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
