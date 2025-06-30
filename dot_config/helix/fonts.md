# Helix Font Configuration

Helix uses the terminal's font settings, so font configuration depends on your terminal emulator.

## Recommended Font: FiraCode Nerd Font

### Terminal-Specific Settings:

**Ghostty** (Configured automatically):
- Font: FiraCode Nerd Font
- Size: 14
- Ligatures: Enabled

**VS Code Terminal** (for Codespaces):
Add to your VS Code settings:
```json
{
  "terminal.integrated.fontFamily": "'FiraCode Nerd Font', 'Fira Code', monospace",
  "terminal.integrated.fontSize": 14,
  "terminal.integrated.fontLigatures": true
}
```

**Other Terminals**:
- Alacritty: Set `font.family` to "FiraCode Nerd Font"
- iTerm2: Preferences → Profiles → Text → Font
- Windows Terminal: Settings → Profiles → Font face

## Fallback Fonts

If FiraCode Nerd Font is not available:
1. Fira Code (without Nerd Font icons)
2. JetBrains Mono
3. Cascadia Code
4. System monospace font

## Installing FiraCode Nerd Font Manually

**macOS**:
```bash
brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font
```

**Linux**:
```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip -o FiraCode.zip
unzip FiraCode.zip
rm FiraCode.zip
fc-cache -fv
```

**Windows**:
Download from https://www.nerdfonts.com/font-downloads and install via Windows Font Manager.