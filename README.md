# dotfiles

Personal configuration files for macOS

![Setup Image](images/nvim.png)

## Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/jakmaz/dotfiles.git ~/git/dotfiles
   ```

2. **Use GNU Stow to create symlinks:**

   ```bash
   cd ~/git/dotfiles
   stow .
   ```

   This command will automatically symlink all configuration files into their correct locations based on the `.stowrc` settings.

3. **Configure Hammerspoon (if using):**

   After stowing the dotfiles, you need to tell Hammerspoon to use the configuration file from the `.config` directory:

   ```bash
   defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
   ```

## Contents

| Tool | Description | Status |
|------|-------------|--------|
| **aerospace** | Tiling window manager | Not used |
| **atuin** | Shell history sync | Active |
| **ghostty** | Terminal emulator with custom shaders | Active |
| **gitconfig** | Global Git configuration | Active |
| **hammerspoon** | macOS automation | Not used |
| **kanata** | Keyboard remapping with Colemak and hyper layers | Active |
| **karabiner** | Key remapping | Not used |
| **nushell** | Modern shell | Active |
| **nvim** | Neovim with lazy.nvim | Active |
| **opencode** | AI assistant | Active |
| **sesh** | Session manager | Active |
| **sketchybar** | Menu bar customization | Active |
| **tmux** | Terminal multiplexer | Active |
| **yabai** | Tiling window manager | Not used |
| **yazi** | File manager | Active |
| **zellij** | Terminal workspace manager | Not used |

## Workflow

This is a minimalist developer setup focused on simplicity and efficiency. I use Neovim as my primary editor with a Colemak keyboard layout on a custom mechanical keyboard for optimal typing comfort and reduced finger movement.

### Keyboard Layout and Input Management

The keyboard setup uses **Kanata** for key mapping with a hyper layer system. When holding the hyper key, I enter sublayer selection mode where pressing specific keys activates different function groups:

- **Apps layer** - Quick launch for frequently used applications
- **Window management** - Controls for window positioning and switching
- **Capture layer** - Screenshot and screen recording tools using Shottr
- **System layer** - Volume, brightness, and system controls
- **Browse layer** - Direct links to websites and web tools
- **Music layer** - Media playback controls
- **Movement layer** - Advanced text navigation shortcuts
- **Raycast layer** - Quick access to Raycast extensions

This hyper layer approach eliminates the need for complex key combinations while keeping everything accessible from the home position.

### Window Management

After experimenting with various tiling window managers including yabai and aerospace, I've settled on a simple single-screen workflow. Most tasks are handled with full-screen applications launched via keyboard shortcuts. For the rare occasions when multiple apps are needed simultaneously, I use Rectangle for basic window positioning.
