# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/) for macOS and Linux (including GitHub Codespaces).

## Features

- 🐟 **Fish shell** with useful plugins and aliases
- 📝 **Helix editor** with language-specific configurations
- 🖥️ **Ghostty terminal** with custom theme
- 🚀 **Modern CLI tools**: starship, zoxide, fzf, ripgrep, bat, eza
- 🔧 **Automatic setup** for different operating systems
- 🌐 **GitHub Codespaces** ready
- 🎨 **Nerd Fonts** with automatic installation and fallbacks

## Installation

### Quick Install

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git
cd dotfiles
./install.sh
```

### Manual Install

1. Install chezmoi:
   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)"
   ```

2. Initialize with this repository:
   ```bash
   chezmoi init --apply https://github.com/YOUR_USERNAME/dotfiles.git
   ```

## What's Included

### Shell
- **Fish** - User-friendly command line shell with minimal plugins:
  - **Fisher** - Plugin manager
  - **nvm.fish** - Node.js version management
  - **fzf.fish** - Fuzzy finder integration
- **Starship** - Minimal, fast prompt
- **Zoxide** - Smarter cd command

### Editor
- **Helix** - Modern text editor optimized for frontend development:
  - Full TypeScript/JavaScript LSP support with auto-imports
  - React, Vue, Svelte, and Astro framework support
  - Tailwind CSS intellisense
  - ESLint integration
  - Prettier formatting on save
  - Emmet completions
  - Custom keybindings for productivity

### Terminal
- **Ghostty** - Fast, feature-rich terminal (macOS only)
- Custom One Dark theme
- Optimized settings

### CLI Tools
- **fzf** - Fuzzy finder
- **ripgrep** - Fast grep alternative
- **fd** - Fast find alternative
- **bat** - Better cat with syntax highlighting
- **eza** - Modern ls replacement
- **gh** - GitHub CLI
- **gg** - Smart git aliases ([csi-lk/gg](https://github.com/csi-lk/gg))

### Terminal Multiplexer
- **tmux** - Highly customized for keyboard-only workflow:
  - Vim-style navigation and pane management
  - Smart session management with `tm` command
  - Project sessionizer with `Ctrl-f`
  - Auto-starts in Codespaces
  - Custom OneDark theme matching Helix
  - Session persistence and restoration

### macOS Enhancements
- **Aerospace** - Tiling window manager with keyboard focus:
  - `ff` command - Fuzzy find and focus any window
  - `fw` command - Quick workspace switcher
  - Vim-style window navigation (Cmd+H/J/K/L)
  - Automatic window organization by app
  - Keyboard shortcuts: Ctrl+W (find windows), Alt+W (workspaces)
- **Sketchybar** - Minimal, customizable menu bar:
  - System monitoring widgets with Nerd Font icons
  - Window and space indicators
  - Battery, CPU, memory, and network status

## Customization

### Adding New Configurations

1. Add files to the appropriate directory:
   - `dot_config/` for `~/.config/` files
   - Root directory for home directory files

2. Update package lists in `.chezmoiscripts/run_once_before_01-install-packages.sh.tmpl`

3. Run `chezmoi apply` to apply changes

### OS-Specific Configurations

Use chezmoi's templating for OS-specific settings:

```bash
{{ if eq .chezmoi.os "darwin" -}}
# macOS specific config
{{ else if eq .chezmoi.os "linux" -}}
# Linux specific config
{{ end -}}
```

## GitHub Codespaces

This repository is configured to work seamlessly with GitHub Codespaces. 

### Automatic Setup

1. Go to [GitHub Codespaces Settings](https://github.com/settings/codespaces)
2. Enable "Automatically install dotfiles"
3. Select this repository
4. All new Codespaces will automatically have your environment

### Manual Setup (for existing Codespaces)

```bash
cd /workspaces/.codespaces/.persistedshare/dotfiles
./install.sh --codespaces
```

### What's Included in Codespaces

- Fish shell as default terminal
- All CLI tools pre-installed
- VS Code extensions for frontend development
- Helix editor with full LSP support
- Auto-forwarding for common dev ports (3000, 5173, 8080, etc.)
- Optimized for 2+ CPU cores and 4GB+ RAM

## Updates

To update your dotfiles:

```bash
chezmoi update
```

To see what changes would be applied:

```bash
chezmoi diff
```

## Troubleshooting

### Fish not found after installation
Restart your terminal or run:
```bash
exec fish
```

### Permission denied errors
Make sure scripts are executable:
```bash
chmod +x ~/.local/share/chezmoi/.chezmoiscripts/*
```

## License

Unlicense
