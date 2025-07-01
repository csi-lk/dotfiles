# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/) for macOS and Linux (including GitHub Codespaces).

## Features

- 🐟 **Fish shell** with useful plugins and aliases
- 📝 **Helix editor** with language-specific configurations
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

### CLI Tools
- **fzf** - Fuzzy finder
- **ripgrep** - Fast grep alternative
- **fd** - Fast find alternative
- **bat** - Better cat with syntax highlighting
- **eza** - Modern ls replacement
- **gh** - GitHub CLI
- **gg** - Smart git aliases ([csi-lk/gg](https://github.com/csi-lk/gg)) - installed via curl

### Terminal Multiplexer
- **tmux** - Highly customized for keyboard-only workflow:
  - Vim-style navigation and pane management
  - Smart session management with `tm` command
  - Project sessionizer with `Ctrl-f`
  - Auto-starts in Codespaces
  - Custom OneDark theme matching Helix
  - Session persistence and restoration

### macOS Enhancements
- **Sketchybar** - Minimal, customizable menu bar:
  - System monitoring widgets with Nerd Font icons
  - Window and space indicators
  - Battery, CPU, memory, and network status
- **Karabiner-Elements** - Advanced keyboard customization:
  - Caps Lock as Super/Hyper key
  - Application launcher shortcuts
  - Firefox tab switching shortcuts

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

## Keyboard Shortcuts Cheatsheet

### Global (macOS)
| Shortcut | Action |
|----------|--------|
| `Cmd+H/J/K/L` | Focus window (left/down/up/right) |
| `Cmd+Shift+H/J/K/L` | Move window |
| `Cmd+1-9` | Switch to workspace |
| `Cmd+Shift+1-9` | Move window to workspace |
| `Cmd+F` | Fullscreen toggle |
| `Cmd+T` | Cycle layouts |
| `Cmd+R` | Enter resize mode |

### Karabiner-Elements (Caps Lock as Super Key)
| Shortcut | Action |
|----------|--------|
| `Caps Lock + C` | Open/focus Calendar |
| `Caps Lock + F` | Open/focus Firefox |
| `Caps Lock + S` | Open/focus Slack |
| `Caps Lock + V` | Open/focus Visual Studio Code |
| `Caps Lock + O` | Open/focus Obsidian |
| `Caps Lock + M` | Firefox → Tab 1 |
| `Caps Lock + T` | Firefox → Tab 2 |

### Fish Shell
| Shortcut | Action |
|----------|--------|
| `Ctrl+W` | Window finder (ff) |
| `Alt+W` | Workspace switcher (fw) |
| `Ctrl+F` | Project sessionizer (tmux) |
| `Ctrl+T` | Fuzzy find directory |
| `Ctrl+R` | Search command history |
| `Ctrl+G` | Git log search |
| `Ctrl+S` | Git status search |

### Tmux (Prefix: `Ctrl+A`)
| Shortcut | Action |
|----------|--------|
| `Prefix + \|` | Split vertically |
| `Prefix + -` | Split horizontally |
| `Prefix + h/j/k/l` | Navigate panes |
| `Alt+h/j/k/l` | Navigate panes (no prefix) |
| `Prefix + H/J/K/L` | Resize panes |
| `Prefix + S` | Create new session |
| `Prefix + s` | Switch sessions |
| `Prefix + Enter` | Copy mode |
| `Prefix + r` | Reload config |
| `Prefix + I` | Install plugins |

### Helix Editor
| Shortcut | Action |
|----------|--------|
| `Ctrl+S` | Save file |
| `Ctrl+Q` | Quit |
| `Ctrl+C` | Center cursor |
| `Ctrl+Alt+L` | Format document |
| `Ctrl+E` | File explorer |
| `Space+q` | Close buffer |
| `Space+w` | Save |
| `Space+r` | Rename symbol |
| `Space+a` | Code actions |
| `Space+h` | Hover info |
| `Space+d` | Diagnostics picker |
| `g+d` | Go to definition |
| `g+r` | Go to references |
| `[d` / `]d` | Previous/next diagnostic |
| `Ctrl+Space` | Trigger completion (insert mode) |

### Chezmoi Aliases
| Command | Action |
|---------|--------|
| `cm` | chezmoi |
| `cma` | Apply changes |
| `cmaf` | Apply force |
| `cmd` | Show diff |
| `cme` | Edit file |
| `cmcd` | Go to dotfiles |
| `cms` | Show status |
| `cm-help` | Show all aliases |

## License

Unlicense
