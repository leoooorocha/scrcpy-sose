# scrcpy-sose (scrcpy - SteamOS Edition)

A lightweight, independent automation utility to easily install, auto-update, and run **scrcpy** on SteamOS (fully compatible with both Desktop Mode and Game Mode).

---

### Disclaimer

This script is an independent automation utility created for personal and community convenience. It has no official affiliation, endorsement, or connection with the original `scrcpy` project or its developers. Any credits go to them.
- **Official scrcpy Repository:** [Genymobile/scrcpy](https://github.com/Genymobile/scrcpy)

---

### Features

- Checks for and downloads the latest official release from their official GitHub.
- Creates a native `.desktop` shortcut that integrates seamlessly with the SteamOS and Gamescope environment.
- Keeps all binaries neatly organized inside a dedicated folder on your Desktop within:
  `~/Desktop/scrcpy-sose`
- If there is no internet connection, it safely launches the locally cached version.

---

### Prerequisites

Before launching the mirroring tool, make sure your Android device is properly configured:
1. Enable **Developer Options** on your phone.
2. Enable **USB Debugging** inside Developer Options.
3. Connect your phone to your SteamOS device via a USB cable.

---

### How to install

1. Switch to **Desktop Mode** and open the **Konsole** terminal.
2. Copy, paste, and run the following command:
```bash
curl -sSL https://raw.githubusercontent.com/leoooorocha/scrcpy-sose/main/scrcpy-sose-install.sh | bash
```
3. Open **Steam** while still in **Desktop Mode**.
4. In the bottom-left corner of the Steam window, click on **Add a Game** and select **Add a Non-Steam Game...**.
5. Search for **scrcpy-sose** and check its box, then click **Add Selected Programs**.
6. Switch back to **Game Mode**, open your Steam Library under the **Non-Steam** tab, and you can now launch your phone mirroring directly from there.

---

### How to uninstall

1. Switch to **Desktop Mode** and open the folder `~/Desktop/scrcpy-sose`.
2. Double-click `uninstall.sh` and Execute.
3. Open **Steam** while still in **Desktop Mode**.
4. Right-click on **scrcopy-sose**
5. Click on **Manage**, then click **Remove non-Steam game from your library**.

---

### Controls & Shortcuts

- **Left-click:** Tap / Click on the phone screen.
- **Middle-click (Scroll):** Home button (returns to the home screen).
- **Right-click:** Back button (returns to the previous screen).
