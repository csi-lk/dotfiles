# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/) for macOS and Linux (including GitHub Codespaces).

## Features

- 🐟 **Fish shell** with useful plugins and aliases
- 📝 **Helix editor** with language-specific configurations
- 🖥️ **Ghostty terminal** with custom theme
- 🚀 **Modern CLI tools**: starship, zoxide, fzf, ripgrep, bat, eza
- 🔧 **Automatic setup** for different operating systems
- 🌐 **GitHub Codespaces** ready

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
- **Helix** - Modern text editor with built-in LSP support
- Custom keybindings and theme
- Language-specific formatters

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
- **tmux** - Terminal multiplexer

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

This repository is configured to work seamlessly with GitHub Codespaces. When you create a new codespace, all tools and configurations will be automatically installed.

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
