# Claude Code Instructions for Dotfiles Repository

This repository contains personal dotfiles managed with [chezmoi](https://www.chezmoi.io/), a cross-platform dotfile manager that handles OS-specific configurations through templating.

## Repository Structure

```
.
├── .chezmoi.toml.tmpl      # Chezmoi configuration template
├── .chezmoiignore          # Files to ignore when applying
├── .chezmoiscripts/        # Scripts run before/after applying
│   ├── run_once_before_01-install-packages.sh.tmpl
│   └── run_once_after_02-configure-fish.sh.tmpl
├── dot_config/             # Maps to ~/.config/
│   ├── fish/               # Fish shell configuration
│   ├── helix/              # Helix editor settings
│   ├── ghostty/            # Ghostty terminal config
│   └── starship.toml       # Starship prompt
├── .devcontainer/          # GitHub Codespaces configuration
├── .github/workflows/      # CI/CD workflows
└── install.sh              # Main installation script
```

## Key Concepts

### Chezmoi Naming Convention
- `dot_` prefix becomes `.` (e.g., `dot_config` → `~/.config`)
- `.tmpl` suffix indicates template files with OS-specific logic
- `run_once_` scripts execute only once (tracked by chezmoi)
- `conf.d/` files in fish are loaded automatically in alphabetical order

### OS Detection
The repository uses chezmoi templating to handle differences between macOS and Linux:
```bash
{{ if eq .chezmoi.os "darwin" -}}
# macOS specific code
{{ else if eq .chezmoi.os "linux" -}}
# Linux specific code
{{ end -}}
```

## Common Tasks

### Adding a New Configuration File
1. Place the file in the appropriate location (e.g., `dot_config/toolname/config`)
2. If OS-specific, add `.tmpl` extension and use templating
3. Run `chezmoi apply` to test

### Adding a New Package
1. Edit `.chezmoiscripts/run_once_before_01-install-packages.sh.tmpl`
2. Add to the `$packages` list for general packages
3. Add OS-specific installation logic if needed

### Special Package Installations
- **gg (git aliases)**: Installed via curl script in `run_once_after_05-install-gg.sh.tmpl`
- **Node.js**: Installed via nvm.fish in the fish configuration script
- **LSP servers**: Installed in `run_once_after_03-install-lsp-servers.sh.tmpl`

### Testing Changes
```bash
# See what would change
chezmoi diff

# Apply changes
chezmoi apply

# Apply a specific file
chezmoi apply ~/.config/fish/config.fish
```

## Important Commands

### Linting and Testing
Currently no specific linting setup, but when making changes:
- Ensure shell scripts are executable: `chmod +x *.sh`
- Test installation in a fresh environment if possible
- GitHub Actions will test on both macOS and Ubuntu

### Debugging
```bash
# See what chezmoi would do
chezmoi apply --dry-run --verbose

# Check chezmoi's view of a file
chezmoi cat ~/.config/fish/config.fish

# See template variables
chezmoi data
```

## Design Decisions

1. **Fish as default shell**: Modern, user-friendly shell with good defaults
2. **Helix over Vim/Neovim**: Built-in LSP support, no plugin management needed
3. **Chezmoi over symlinks**: Better handling of OS differences, secrets management
4. **Minimal approach**: Only essential tools, avoid bloat

## Helix Frontend Development Setup

The Helix configuration is optimized for frontend development with:

### Language Servers
- **TypeScript/JavaScript**: Full IntelliSense, auto-imports, refactoring
- **ESLint**: Real-time linting in the editor
- **Prettier**: Format on save for consistent code style
- **Tailwind CSS**: Class name completions and hover docs
- **Emmet**: HTML/JSX expansions

### Supported Frameworks
- React (TSX/JSX)
- Vue 3
- Svelte
- Astro
- Vanilla JS/TS

### Key Bindings
- `Space + r`: Rename symbol
- `Space + a`: Code actions (auto-import, fix errors)
- `g + d`: Go to definition
- `Space + d`: Diagnostics picker
- `Ctrl + Space`: Trigger completion (insert mode)
- `Ctrl + Alt + l`: Format document

### Checking LSP Status
Run `helix-lsp-status` to see which language servers are installed.

## Tmux Configuration

The tmux setup is optimized for a pure keyboard workflow:

### Key Concepts
- **Prefix**: `Ctrl-a` (instead of default `Ctrl-b`)
- **Vim-style navigation**: h/j/k/l for pane movement
- **No-prefix shortcuts**: Alt+h/j/k/l for quick pane switching
- **Smart splits**: | for vertical, - for horizontal (keeps current directory)

### Session Management
- `tm` - Interactive session manager with fzf
- `tm <name>` - Create or attach to named session
- `tm <name> <path>` - Create session in specific directory
- `Ctrl-f` (in fish) - Project sessionizer to quickly jump to git repos

### Important Keybindings
- `Prefix + r` - Reload configuration
- `Prefix + |` - Split vertically
- `Prefix + -` - Split horizontally
- `Prefix + h/j/k/l` - Navigate panes
- `Alt + h/j/k/l` - Navigate panes (no prefix)
- `Prefix + H/J/K/L` - Resize panes (5 cells)
- `Prefix + S` - Create new session
- `Prefix + s` - Switch sessions
- `Prefix + w` - Switch windows
- `Prefix + Enter` - Copy mode
- `Prefix + Tab` - Cycle panes

### Auto-start in Codespaces
Tmux automatically starts in Codespaces with a "main" session. This provides:
- Persistent terminal sessions
- Multiple panes/windows in the web interface
- Session restoration on reconnect

### Plugins Included
- TPM (Tmux Plugin Manager)
- tmux-resurrect (save/restore sessions)
- tmux-continuum (automatic save/restore)
- tmux-yank (better copy/paste)
- tmux-prefix-highlight (visual prefix indicator)

Run `tmux-cheatsheet` for a complete list of custom keybindings.

## GitHub Codespaces Support

The repository automatically configures Codespaces through `.devcontainer/devcontainer.json`. Fish shell is set as the default terminal, and all tools are installed automatically.

## Package Management

- **macOS**: Uses Homebrew for all packages
- **Linux**: Uses apt (Debian/Ubuntu), with fallbacks to direct downloads for tools not in repos
- **Cross-platform tools**: Installed via curl scripts (starship, zoxide) or cargo when needed

## Nerd Fonts Setup

FiraCode Nerd Font is automatically installed and configured:

### Installation
- **macOS**: Downloads from GitHub releases to `~/Library/Fonts`
- **Linux**: Downloads from GitHub releases to `~/.local/share/fonts`
- **Codespaces**: Falls back to standard Unicode icons
- **Version**: v3.4.0 (latest stable release)

### Configuration
- **Ghostty**: Configured with `FiraCode Nerd Font` and ligatures
- **VS Code**: Set in devcontainer with fallbacks
- **Tmux**: Auto-detects Nerd Fonts and adjusts icons
- **Starship**: Uses Nerd Font icons with full glyph support

### Detection
- Environment variable `NERD_FONT_AVAILABLE` set by fish
- `check-nerd-fonts` command to verify installation
- `nf_icon` fish function for icon fallbacks
- Tmux theme adapts based on font availability

### Fallback Strategy
1. Try FiraCode Nerd Font
2. Fall back to Fira Code (without icons)
3. Fall back to Cascadia Code
4. Use system monospace font
5. Replace icons with ASCII alternatives

## Window Management (macOS)

The dotfiles include aerospace window manager integration with custom fish functions:

### Focus Finder Functions
- `ff` - Basic window finder with fzf
- `ffw` - Enhanced finder with workspace info
- `fw` - Workspace switcher

### Key Bindings
- `Ctrl+W` in fish shell - Launch window finder
- `Alt+W` in fish shell - Launch workspace switcher
- Global aerospace shortcuts configured in `~/.config/aerospace/aerospace.toml`

### Installation
Aerospace is automatically installed via Homebrew on macOS. The configuration includes:
- Vim-style navigation (Cmd+H/J/K/L)
- 9 workspaces with quick switching
- Automatic app placement rules
- Tiling layouts with gaps

### Usage Examples
```bash
# Find and focus any window
ff

# Switch workspaces
fw

# Get help
window-help
```

## File Permissions

Chezmoi preserves file permissions. Executable scripts in `.chezmoiscripts/` will remain executable after applying.