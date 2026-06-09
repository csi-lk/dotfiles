# Helix Font Configuration

Helix uses the terminal's font settings, so font configuration depends on your terminal emulator.

## Recommended Font: FiraCode Nerd Font

### Terminal-Specific Settings:

**Ghostty** (Configured automatically):
- Font: FiraCode Nerd Font
- Size: 14
- Ligatures: Enabled

**iTerm2**:
- Preferences → Profiles → Text → Font → FiraCode Nerd Font

## Fallback Fonts

If FiraCode Nerd Font is not available:
1. Fira Code (without Nerd Font icons)
2. JetBrains Mono
3. Cascadia Code
4. System monospace font

## Installing FiraCode Nerd Font Manually

```bash
mkdir -p ~/Library/Fonts
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip -o /tmp/FiraCode.zip
unzip -o /tmp/FiraCode.zip -d ~/Library/Fonts/
rm /tmp/FiraCode.zip
```
