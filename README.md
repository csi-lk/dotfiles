# Dotfiles

Personal macOS dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Features

- 🐟 **Fish shell** with useful plugins and aliases
- 🚀 **Modern CLI tools**: starship, zoxide, fzf, ripgrep, bat, eza
- 🎨 **Nerd Fonts** with automatic installation
- ⌨️ **Karabiner-Elements** with Caps Lock as Super key

## Installation

```bash
git clone https://github.com/csi-lk/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
./install.sh
```

## What's Included

### Shell
- **Fish** with Fisher plugin manager, nvm.fish, fzf.fish
- **Starship** - minimal fast prompt
- **Zoxide** - smarter `cd`

### CLI Tools
- **fzf** / **fd** / **ripgrep** / **bat** / **eza** / **gh** / **jq**
- **gg** - smart git aliases ([csi-lk/gg](https://github.com/csi-lk/gg))
- **uv** + **python@3.11** - Python toolchain
- **pnpm** + **bun** - JS package managers
- **claude** + **hermes** - AI agents

### Apps (casks)
- **iTerm2** - terminal
- **Firefox** - browser (set as default via `defaultbrowser`)
- **VSCode** - editor
- **Karabiner-Elements** - keyboard customisation
- **Music Decoy** - intercepts media keys → Spotify
- **warpd** - keyboard-driven mouse control

### macOS Defaults
- Fastest keyboard repeat rate, no press-and-hold
- Dock: auto-hide, instant show/hide, no animations
- Finder: show hidden files, list view, no .DS_Store on network/USB
- Disable autocorrect, smart quotes, smart dashes

## Customisation

Add packages to `.chezmoiscripts/run_once_before_01-install-packages.sh.tmpl`.
Add fish config to `dot_config/fish/conf.d/`.
Add local/machine-specific overrides to `~/.config/fish/local.fish` (not tracked).

## Updates

```bash
chezmoi update   # pull latest and apply
chezmoi diff     # preview changes
```

## Keyboard Shortcuts (Caps Lock = Super Key)

| Shortcut | Action |
|----------|--------|
| `Caps Lock + Space` | iTerm |
| `Caps Lock + F` | Firefox |
| `Caps Lock + V` | VSCode |
| `Caps Lock + O` | Obsidian |
| `Caps Lock + S` | Screens 5 |
| `Caps Lock + M` | Outlook Mail |
| `Caps Lock + N` | Outlook Calendar |
| `Caps Lock + T` | Teams Activity |
| `Caps Lock + C` | Teams Calendar |
| `Caps Lock + 1` | 1Password |
| `Caps Lock + P` | Privileges |
| `Caps Lock + W` | Warpd normal mode |
| `Caps Lock + G` | Warpd grid mode |
| `Caps Lock + X` | Warpd hint mode |
| `Caps Lock + /` | Super key cheat sheet |

## License

Unlicense
