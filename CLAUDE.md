# Claude Code Instructions for Dotfiles Repository

This repository contains personal macOS dotfiles managed with [chezmoi](https://www.chezmoi.io/).

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
├── .github/workflows/      # CI/CD workflows (macOS runners)
└── install.sh              # Main installation script
```

## Important: Two-Location Setup

This repo (`~/dev/dotfiles`) is **not** the chezmoi source directory. Chezmoi reads from `~/.local/share/chezmoi/`. They are separate copies.

When editing dotfiles:
1. Edit files in `~/dev/dotfiles/` (the git repo)
2. Copy to chezmoi source: `cp ~/dev/dotfiles/dot_config/foo ~/.local/share/chezmoi/dot_config/foo`
3. Apply: `chezmoi apply --force ~/.config/foo`

`chezmoi diff` shows no changes if you only edited `~/dev/dotfiles` — always copy to `~/.local/share/chezmoi/` first.

## Key Concepts

### Chezmoi Naming Convention
- `dot_` prefix becomes `.` (e.g., `dot_config` → `~/.config`)
- `.tmpl` suffix indicates template files
- `run_once_` scripts execute only once (tracked by chezmoi)
- `conf.d/` files in fish are loaded automatically in alphabetical order

## Common Tasks

### Adding a New Configuration File
1. Place the file in the appropriate location (e.g., `dot_config/toolname/config`)
2. Run `chezmoi apply` to test

### Adding a New Package
1. Edit `.chezmoiscripts/run_once_before_01-install-packages.sh.tmpl`
2. Add to the `$packages` list (Homebrew) or `$macPackages` for macOS-only packages

### Special Package Installations
- **gg (git aliases)**: Installed via curl script in `run_once_after_05-install-gg.sh.tmpl` with fish completions in `dot_config/fish/completions/gg.fish`
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
- Ensure shell scripts are executable: `chmod +x *.sh`
- GitHub Actions runs on macOS runners

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
2. **Multiple editor options**: Helix for simplicity, Emacs for full IDE experience
3. **Chezmoi over symlinks**: Better handling of secrets management
4. **Minimal approach**: Only essential tools, avoid bloat
5. **macOS only**: No Linux or Codespaces support

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

## Modern Emacs Configuration

The dotfiles include a comprehensive Emacs setup designed for developers coming from VSCode:

### Key Features
- **VSCode-style keybindings** - Familiar shortcuts (Ctrl+S, Ctrl+C/V, Ctrl+P, etc.)
- **Non-modal editing** - Direct typing, no vim modes
- **TypeScript/JavaScript LSP** - Full IntelliSense with language servers
- **GitHub Copilot** - AI-powered code completion
- **File explorer** - Treemacs with icons (F8 to toggle)
- **Fuzzy finding** - Quick file navigation with Ctrl+P
- **Git integration** - Magit for version control
- **Terminal integration** - Built-in terminal support
- **Modern UI** - Doom themes with clean interface

### First-Time Setup
1. Start Emacs - packages auto-install (takes a few minutes)
2. Run `M-x all-the-icons-install-fonts` for file explorer icons
3. Run `M-x copilot-login` to enable AI completion
4. Install TypeScript support: `npm install -g typescript-language-server typescript`

### Essential Keybindings
- `Ctrl+P` - Fuzzy file finder
- `F8` - Toggle file explorer
- `Ctrl+S` - Save file
- `Ctrl+/` - Toggle comment
- `Ctrl+D` - Duplicate line
- `Ctrl+X G` - Git status
- `Ctrl+\`` - Terminal

### Configuration Location
- Main config: `~/.emacs.d/init.el`
- Documentation: `~/.emacs.d/README.md`
- Packages auto-install to `~/.emacs.d/elpa/`

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

### Plugins Included
- TPM (Tmux Plugin Manager)
- tmux-resurrect (save/restore sessions)
- tmux-continuum (automatic save/restore)
- tmux-yank (better copy/paste)
- tmux-prefix-highlight (visual prefix indicator)

Run `tmux-cheatsheet` for a complete list of custom keybindings.

## Package Management

All packages are installed via Homebrew on macOS.

## JavaScript Package Managers

### Installed Package Managers
- **pnpm** - Fast, disk space efficient package manager (installed via Homebrew)
- **bun** - All-in-one JavaScript runtime & toolkit (installed via Homebrew)

### Usage Examples
```bash
# pnpm - Fast package manager
pnpm install
pnpm add react
pnpm run dev

# bun - All-in-one toolkit
bun install           # Install dependencies (faster than npm)
bun add react         # Add packages
bun run dev           # Run scripts
bun test              # Run tests
bun build ./index.ts  # Bundle for production
```

## Claude Code Support

Claude Code and claude-squad are automatically installed and configured with convenient aliases:

### Claude Code Aliases
- `cc` - Run claude (shorthand)
- `ccc` - Start claude with conversation mode
- `ccn` - Start claude with a new conversation
- `ccp` - Start claude in plan mode

### claude-squad Aliases
- `cs` - Run claude-squad
- `csa` - Add agents to squad (claude-squad add)
- `csl` - List current squad (claude-squad list)
- `csr` - Run squad on task (claude-squad run)

## Git Goodies (gg)

gg is a fast git alias utility that provides convenient shortcuts for common git operations.

### Installation
- Installed via curl script from https://github.com/csi-lk/gg
- Installation script: `run_once_after_05-install-gg.sh.tmpl`
- Fish shell completions: `dot_config/fish/completions/gg.fish`

### Common Commands
**Basic operations:**
- `gg s` - Status
- `gg a` - Add all changes
- `gg c` - Conventional commit (interactive)
- `gg p` - Push
- `gg pl` - Pull

**Branch management:**
- `gg b <name>` - Create/checkout branch
- `gg cm` - Checkout main/master
- `gg bd <name>` - Delete branch
- `gg clean` - Remove merged branches

**History:**
- `gg l` - View commit log
- `gg lc` - Show latest commit
- `gg r <n>` - Interactive rebase last n commits

**Advanced:**
- `gg z a c p` - Chain commands (add, commit, push)
- `gg cf` - Create fixup commit
- `gg pr` - Open pull request
- `gg o` - Open repository in browser

For a complete list of commands, run `gg help` or `gg -h`.

## Nerd Fonts Setup

FiraCode Nerd Font is automatically installed to `~/Library/Fonts`:

### Configuration
- **Ghostty**: Configured with `FiraCode Nerd Font` and ligatures
- **Tmux**: Detects Nerd Fonts via cache
- **Starship**: Uses Nerd Font icons

### Detection
- Environment variable `NERD_FONT_AVAILABLE` set by fish
- `check-nerd-fonts` command to verify installation
- `nf_icon` fish function for icon fallbacks

## Warpd - Keyboard-Driven Mouse Control

Warpd is installed for keyboard-driven mouse control.

### Default Keybindings
**Mode Activation:**
- `CMD+Alt+C` - Normal cursor movement mode
- `CMD+Alt+X` - Hint mode (shows labels on clickable elements)
- `CMD+Alt+G` - Grid mode (divide screen into quadrants)
- `CMD+Alt+S` - Screen selection mode

**Navigation (in normal mode):**
- `h/j/k/l` - Move cursor (vim-style)
- `H/M/L` - Jump to top/middle/bottom of screen
- `a` - Hold to accelerate
- `d` - Hold to decelerate

**Mouse Actions:**
- `m` or `,` - Left click
- `.` - Right click
- `v` - Toggle drag mode
- `Esc` - Exit warpd

To customize, create `~/.config/warpd/config`.

## File Permissions

Chezmoi preserves file permissions. Executable scripts in `.chezmoiscripts/` will remain executable after applying.
