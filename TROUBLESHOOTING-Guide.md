# 🛠️ Fenris-Installer-Script: Troubleshooting Guide

This guide provides solutions for common issues across all supported Debian-based desktop distributions (including Ubuntu, MX Linux, Kali Linux, Pop!_OS, and Linux Mint). Because this installer operates natively in user-space without `sudo` privileges, most fixes involve ensuring your system tools and local file permissions are correct.

---

## 1. Script Crashes or Hangs at Section 3 (Winetricks Injection)

*   **Symptom:** The terminal freezes indefinitely or prints translation errors during the `winetricks` execution step.
*   **Cause 1: Network Timeouts.** `winetricks` downloads auxiliary Microsoft runtime binaries (like `cabextract` targets). If a remote archive mirror is slow or unresponsive, the download script stalls in the background.
*   **Cause 2: Corrupted or Interrupted Prefix.** If a previous installation run was force-closed or lost power midway, the virtual Windows registry files (`system.reg`, `user.reg`) become locked or malformed.
*   **Fix:** Check your network connection. Wipe out the broken or partial setup directory completely, and restart the installer as a normal user to let it rebuild a fresh, clean prefix.

---

## 2. Virtual Framebuffer Errors (`Xvfb` / Headless Display Allocations)

*   **Symptom:** The terminal outputs errors referencing `Fatal server error: Server is already active for display 103` or `Could not open default font 'fixed'`.
*   **Cause 1: Display Port Collision.** A lingering background setup process or another system utility is actively occupying display port `:103`.
*   **Cause 2: Missing Core X11 Fonts.** Minimalistic or specialized distributions (such as bare-bones Kali Linux, Parrot OS, or Bodhi Linux) strip out default graphical assets to minimize footprint, leaving `Xvfb` unable to initialize an invisible display workspace.
*   **Fix:** 
    1. Check for abandoned virtual display processes by running `ps aux | grep Xvfb` in your terminal, and terminate them.
    2. If your distribution lacks basic font structures, install the standard X11 font utilities manually using your package manager:
       ```bash
       sudo apt install xfonts-base xfonts-100dpi xfonts-75dpi
       ```

---

## 3. Game Launcher Starts But Is Pitch Black (No Text or UI)

*   **Symptom:** Clicking your generated desktop shortcut opens a launcher window, but the panel remains totally blank, black, or refuses to render interactive login elements.
*   **Cause:** The installer successfully finished using the software-driven `llvmpipe` CPU translation layer, but your host desktop user session lacks the native 32-bit graphical runtime components required to pass the execution context back to your hardware.
*   **Fix:** Ensure your system has multiarch library support enabled and proper 32-bit graphics wrappers installed for your physical graphics card. For standard NVIDIA setups on Debian architectures, run:
    ```bash
    sudo dpkg --add-architecture i386 && sudo apt update
    sudo apt install libgl1-nvidia-glx:i386
    ```

---

## 4. File Permission Denied Errors (`~/.wine` / Local Write Faults)

*   **Symptom:** The installation script immediately exits with file system write permission faults.
*   **Cause:** A runner script or an external tool was previously executed using `sudo` within your user profile directory. This forces root ownership onto hidden configuration folders, locking out normal user accounts.
*   **Fix:** Reclaim ownership of your user profile directory paths by matching them back to your active system account:
    ```bash
    sudo chown -R USER:USER ~/.wine
    ```
    *Reminder: Never execute the Fenris installer scripts with sudo or as root.*
