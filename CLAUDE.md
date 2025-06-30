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

## GitHub Codespaces Support

The repository automatically configures Codespaces through `.devcontainer/devcontainer.json`. Fish shell is set as the default terminal, and all tools are installed automatically.

## Package Management

- **macOS**: Uses Homebrew for all packages
- **Linux**: Uses apt (Debian/Ubuntu), with fallbacks to direct downloads for tools not in repos
- **Cross-platform tools**: Installed via curl scripts (starship, zoxide) or cargo when needed

## File Permissions

Chezmoi preserves file permissions. Executable scripts in `.chezmoiscripts/` will remain executable after applying.