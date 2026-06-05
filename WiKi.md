# 🛸 Multi-Account Profile Management & Settings Migration

Because the Fenris Installer Script provisions completely isolated environments based on your choices, your EVE Online and EVE Frontier user profiles remain separate from global system managers. This guide breaks down your installation layout, shows you exactly where your cache files live, and explains how to copy or back up your user interfaces.

---

## 📂 The Fenris Custom Folder Architecture

During initialization, the installer prompts you for a main destination directory (`$YourChoice`). Whether you type a directory path with or without a trailing slash (such as `/opt/EVE/` or `/opt/EVE`), the script correctly parses the input and constructs clean, dedicated directory paths.

### 1. Root Application and Wine Prefix Locations
Your game client payloads and custom virtual Windows drives are cleanly separated inside your custom selection:
* **EVE Online Main Root:** `/$YourChoice/EVE/Online/`
* **EVE Frontier Main Root:** `/$YourChoice/EVE/Frontier/`

### 2. Deep Settings & Cache Database Mapping
Your character window setups, hotkeys, overview filters, and client cache tables are tucked deep inside the virtual Windows environment profiles. To locate them, replace `klown` with your own local Linux system username if you are modifying paths via terminal scripts:

* **🌌 EVE Frontier Cache Directory:**
  `/$YourChoice/EVE/Frontier/dosdevices/c:/users/klown/AppData/Local/CCP/EVE/c_ccp_eve_frontier_stillness_stillness.servers.evefrontier.com/`

* **🚀 EVE Online Cache Directory:**
  `/$YourChoice/EVE/Online/dosdevices/c:/users/klown/AppData/Local/CCP/EVE/c_ccp_eve_tq_tranquility/`

---

## 🧪 Identifying Your Core Profile Files

Inside the specific configuration folders mapped above, look for two distinct binary file types that store your configurations. If you use multiple accounts, you will see a unique set of these files for each login ID:

1. `core_char_*.dat` -> Stores your **character-bound configurations** (e.g., overview layouts, chat channel configurations, drone group settings, and screen window layouts).
2. `core_user_*.dat` -> Stores your **account-bound settings** (e.g., graphics performance toggles, screen resolution, audio preferences, and saved login preferences).

*Note: The `*` represents a randomized numerical ID assigned uniquely to your accounts and characters by the remote server engines.*
---

## 🔄 Part 3: Step-by-Step Settings Migration

### How to Clone Settings Across Multiple Accounts
If you run multiple game accounts and want them all to instantly share the exact same UI window placements, hotkeys, and overview filters without setting them up individually:

1. Launch your game client through your Fenris desktop shortcut and log into your primary account.
2. Arrange your windows, set up your overview, configure your preferences, and then log completely out of the client.
3. Open your file manager or terminal and navigate into the target Settings directory outlined in Part 1.
4. Sort the folder by **Date Modified** to locate the `core_user_*.dat` and `core_char_*.dat` files with the most recent timestamp (these represent your primary profile).
5. Copy these files, paste them back into the same folder, and rename the copies to match the unique numerical ID string of your secondary accounts or characters.

### How to Migrate Settings From Steam or Lutris
If you are moving over to Fenris from an existing Steam or Lutris prefix and want to carry over your customized layouts:

1. Locate your old runner profile directory (for example, Steam's default EVE path is usually inside `~/.steam/steam/steamapps/compatdata/8500/pfx/drive_c/users/steamuser/AppData/Local/CCP/EVE/`).
2. Copy all your existing `core_char_*.dat` and `core_user_*.dat` configuration files from that directory.
3. Paste those files directly into your new custom Fenris cache folders (`/$YourChoice/EVE/Online/...` or `/$YourChoice/EVE/Frontier/...`).
4. Relaunch your client through your Fenris shortcut to continue using your fully migrated profile configurations.

---

## 🖥️ Part 4: Managing Desktop Shortcuts

The installer generates clean, universal `.desktop` shortcuts that adhere strictly to FreeDesktop specifications. This guarantees they will launch smoothly across all verified Debian derivatives, whether you use GNOME, KDE Plasma, XFCE, or MATE.

If you ever need to manually back up, copy, or verify your shortcut configuration files, you can find them stored here:

* **EVE Online Launchers:** 
  * Replicated across both your physical desktop layout pathway at `~/Desktop/` and your local applications menu folder at `~/.local/share/applications/`.
* **EVE Frontier Launcher:** 
  * Deposited exclusively onto your desktop layout pathway at `~/Desktop/`.

If a launcher icon fails to load or respond after a system update, simply open your terminal and verify its file execution attributes using:
```bash
chmod +x ~/Desktop/*.desktop
```
