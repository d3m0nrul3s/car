![arch2](https://github.com/user-attachments/assets/793925bf-f2b8-4a17-8089-680a60b23029)
![arch](https://github.com/user-attachments/assets/abfb4d79-7648-4863-aa81-6727fc650cbd)


# Author: WARP

This file provides guidance to WARP when working with code in this repository.

## Repository Overview

This is a Linux desktop environment configuration repository (dotfiles) focused on i3 window manager with integrated penetration testing/security research utilities. The repo is designed for both Arch and Debian-based systems.

## Architecture

### Configuration Structure

The repository follows a modular structure with three main components:

1. **config/** - Application dotfiles for window manager and terminal tools
   - i3: Window manager configuration with keybindings and workspace management
   - polybar: Status bar configuration and launch scripts
   - Terminal emulators: alacritty, kitty
   - File managers: ranger (with devicons plugin)
   - Other tools: rofi, picom, neofetch, btop, zathura, fish shell

2. **bin/** - User-level utility scripts for desktop operations
   - System control: brightness, volume, powermenu, screen-lock
   - Visuals: wallpaper management (random_wallpaper, wallpaper_filter.py)
   - Media: ytd (YouTube downloader scripts for audio/video)
   - Utilities: wifimenu, xcolor-pick, weather, battery-alert
   - Language/keyboard: change_language.sh
   - Privacy: clear_images_meta, do_not_disturb.sh

3. **scripts/** - Security/penetration testing workflow utilities
   - htb: HackTheBox CLI client (by S4vitar) - requires API token configuration
   - ports: Extract and parse open ports from scan output, auto-copy to clipboard
   - mkt: Create CTF/pentest directory structure (content, exploit, scan folders)
   - target: Set target IP/hostname to persistent config file
   - sr: Start Python HTTP server on port 80 with banner
   - copy: Clipboard integration wrapper

### Installation Flow

The installation scripts are distribution-aware:

1. **install.sh** - Main installer
   - Prompts for distro (Arch or Debian)
   - Installs base packages via pacman/apt
   - Downloads and installs Nerd Fonts (Iosevka, RobotoMono, Hack)
   - Copies configs to ~/.config and binaries to ~/bin
   - Sets up wallpapers in ~/.images
   - Makes scripts executable
   - Calls additional_files.sh for post-install

2. **additional_files.sh** - Security tools installer
   - Replaces standard `cat` with `bat` (aliasing via /usr/bin/cat -> /usr/bin/bat)
   - Arch: Installs BlackArch repo, security tools (nmap, metasploit, burpsuite, hydra, etc.)
   - Debian: Installs pentesting utilities and copies scripts/ to /usr/bin/

3. **test_file.sh** - Additional Arch packages list for extended setup

### Key Design Patterns

**i3 Window Manager Setup:**
- Mod key: ALT (Mod1)
- Auto-starts: polybar, picom compositor, keyboard layout switcher (US/RU)
- Key window manager keybindings:
  - Mod+Return: Launch kitty terminal
  - Mod+d: Rofi launcher
  - Mod+Shift+h: Firefox browser
  - Mod+Shift+d: i3lock-fancy screen lock
  - Mod+Escape: System shutdown
  - Mod+P: Flameshot screenshot
  - Mod+i: Random wallpaper
- i3-gaps enabled with 5px inner/outer gaps
- Border pixel: 2px

**Security Workflow Scripts:**
The scripts/ utilities follow a penetration testing workflow:
1. Use `mkt` to create directory structure for a target
2. Use `target <ip>` to set persistent target (stored in ~/.config/bin/target)
3. Run scans and use `ports <scan_file>` to extract/copy ports
4. Use `sr` to quickly start HTTP server for file transfers
5. Use `htb` for HackTheBox machine management (requires API token in script)

**Utility Script Patterns:**
- Desktop utilities use pamixer for audio, xbacklight/light for brightness
- Notifications via dunstify with icon paths to Papirus theme
- Clipboard operations use xclip

## Common Commands

### Installation
```bash
# Initial setup (choose 1 for Arch, 2 for Debian when prompted)
bash install.sh

# Post-install security tools (same prompts)
bash additional_files.sh
```

### i3 Window Manager
```bash
# Reload i3 config
Mod+Shift+c

# Restart i3 in-place
Mod+Shift+r

# Start polybar manually
~/.config/polybar/launch.sh
```

### Security Scripts
```bash
# Create CTF directory structure
mkt

# Set target IP for persistent reference
target 10.10.10.100

# Extract ports from nmap output and copy to clipboard
ports nmap_scan.txt

# Start HTTP server on port 80
sr

# HackTheBox CLI (requires API_TOKEN in scripts/htb)
htb -h
```

### System Utilities
```bash
# Volume control
~/bin/volume --up
~/bin/volume --down
~/bin/volume --toggle

# Brightness control
~/bin/brightness --up
~/bin/brightness --down

# Power menu (rofi-based)
~/bin/powermenu

# Lock screen
~/bin/screen-lock
```

## Important Notes

### Before Installation
- The install.sh script downloads and modifies system binaries (replaces /usr/bin/cat with bat)
- Requires sudo access for package installation and system modifications
- Font installation requires ~/.local/share/fonts/ and ~/.fonts/ directories

### HackTheBox Script Configuration
The scripts/htb file requires API token configuration:
- Line 28: Set `API_TOKEN=""` with your HTB API token
- Script will not run without valid token

### Clipboard Dependencies
Many scripts rely on xclip for clipboard operations - ensure it's installed.

### Distribution-Specific Considerations
- Arch: Uses pacman, includes BlackArch repo setup for security tools
- Debian: Builds i3-gaps from source, uses apt for packages
- test_file.sh contains Arch-only package list for extended installation

