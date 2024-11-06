# Dotfiles

Personal configuration files for macOS and Linux, managed with Git for easy version control and syncing across systems.

## Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/jakmaz/dotfiles.git ~/git/dotfiles
   ```

2. **Create symlinks for configuration files:**

   ```bash
   ln -s ~/git/dotfiles/gitconfig ~/.gitconfig
   ln -s ~/git/dotfiles/zshrc ~/.zshrc
   ln -s ~/git/dotfiles/nvim ~/.config/nvim
   ```

## Contents

- **gitconfig**: Global Git configuration
- **zshrc**: Zsh shell configuration
- **nvim**: Neovim configuration files

## Usage

Make any changes directly in the `dotfiles` repository and commit them. Use symlinks to keep these configurations active on your system.
