# Dotfiles

A collection of dotfiles for shell and editor configuration, managed by [Dotbot](https://github.com/anishathalye/dotbot).

## Overview

This repository provides a streamlined environment for macOS/Linux:
- **Shells**: Zsh (via Oh-My-Zsh & Powerlevel10k) and Bash.
- **Editors**: Neovim (modern Lua-based configuration with `lazy.nvim`) and legacy Vim support.
- **Environment**: Shared configurations, custom shell extensions, and cross-platform path management.

## Installation

### Prerequisites
- Git
- Python (required for Dotbot)
- **Neovim** (optional but recommended for the full editor experience)

### Fresh Install
To bootstrap on a new machine, run:

```bash
git clone https://github.com/u932b/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

*Note: The `install` script automatically initializes the Dotbot submodule and sets up symlinks.*

## Repository Structure

- **`install.conf.yaml`**: Dotbot configuration defining symlinks and bootstrap commands.
- **`zshrc`**: Zsh configuration with OMZ and P10k.
- **`bashrc`**: Bash configuration with support for custom extensions.
- **`commonrc`**: Shared configuration sourced by both Bash and Zsh.
- **`bashrc_extensions/`**: Directory for custom shell scripts (automatically loaded by Bash).
- **`nvim/`**: Modern Neovim configuration using Lua and `lazy.nvim`.
- **`vimrc`**: Legacy Vim configuration managed by `vim-plug`.
- **`p10k.zsh`**: Powerlevel10k theme configuration.

## Features & Configuration

### 💻 Editor (Neovim)
The Neovim setup has been migrated to a modern Lua-based configuration:
- **Entry Point**: `nvim/init.lua`
- **Plugin Manager**: [`lazy.nvim`](https://github.com/folke/lazy.nvim)
- **Organization**: Modular config located in `nvim/lua/config/`.

### 🐚 Shell Setup
- **Shared Config**: `commonrc` contains aliases and exports used by both Bash and Zsh, ensuring a consistent experience across shells.
- **Bash Extensions**: Any script placed in `bashrc_extensions/` is automatically sourced by `bashrc`, allowing for modularized local configuration.
- **Zsh Theme**: Powerlevel10k is pre-configured for a rich terminal experience. Run `p10k configure` to customize.

### 🛠️ Automation
- **Dotbot**: Handles symlinking files to your home directory.
- **Auto-Installation**: The `install` script ensures `oh-my-zsh`, `powerlevel10k`, and essential plugins (Vim and Neovim) are installed during the first run.
