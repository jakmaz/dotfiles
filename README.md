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

## Contents

- **gitconfig**: Global Git configuration
- **nvim**: Neovim configuration files
- **zshrc**: Zsh shell configuration
- **aerospace**: Configuration for Aerospace tiling application
- **sketchybar**: Configuration for SketchyBar macOS menu bar customization
- **nushell**: Configuration files for Nushell modern shell
- **ghostty**: Configuration for Ghostty terminal emulator
