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
2. Add to `$packages` (formula) or `$casks` (cask) or `$macPackages` (macOS-only formula)

### Special Package Installations
- **gg (git aliases)**: Installed via curl script in `run_once_after_05-install-gg.sh.tmpl` with fish completions in `dot_config/fish/completions/gg.fish`
- **Node.js**: Installed via nvm.fish in the fish configuration script
- **pnpm/bun**: Installed via Homebrew in `run_once_after_07-install-package-managers.sh.tmpl`

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
2. **Chezmoi over symlinks**: Better handling of secrets management
3. **Minimal approach**: Only essential tools, avoid bloat
4. **macOS only**: No Linux or Codespaces support

## Package Management

All packages are installed via Homebrew on macOS.

## JavaScript Package Managers

### Installed Package Managers
- **pnpm** - Fast, disk space efficient package manager (installed via Homebrew)
- **bun** - All-in-one JavaScript runtime & toolkit (installed via Homebrew)

### Usage Examples
```bash
pnpm install / pnpm add react / pnpm run dev
bun install / bun add react / bun run dev / bun test
```

## Claude Code Support

### Claude Code Aliases
- `cc` - Run claude (shorthand)
- `ccc` - Start claude with conversation mode
- `ccn` - Start claude with a new conversation
- `ccp` - Start claude in plan mode

### claude-squad Aliases
- `cs` - Run claude-squad
- `csa` - Add agents to squad
- `csl` - List current squad
- `csr` - Run squad on task

## Git Goodies (gg)

gg is a fast git alias utility: https://github.com/csi-lk/gg

### Common Commands
- `gg s` / `gg a` / `gg c` / `gg p` / `gg pl` - Status, add, commit, push, pull
- `gg b <name>` / `gg cm` / `gg bd <name>` - Branch management
- `gg l` / `gg r <n>` - Log, rebase
- `gg z a c p` - Chain: add, commit, push

## Nerd Fonts Setup

FiraCode Nerd Font is automatically installed to `~/Library/Fonts`.
- `check-nerd-fonts` command to verify installation
- `nf_icon` fish function for icon fallbacks

## Warpd - Keyboard-Driven Mouse Control

### Keybindings
- `CMD+Alt+C` - Normal mode, `CMD+Alt+X` - Hint mode, `CMD+Alt+G` - Grid mode
- `h/j/k/l` - Move cursor, `m`/`,` - Left click, `.` - Right click, `Esc` - Exit

To customize, create `~/.config/warpd/config`.

## Karabiner-Elements

Caps Lock mapped as Super key for app launcher shortcuts.

## File Permissions

Chezmoi preserves file permissions. Executable scripts in `.chezmoiscripts/` will remain executable after applying.
