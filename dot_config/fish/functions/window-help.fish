function window-help --description "Show help for window management commands"
    echo "Window Management Commands (macOS only)"
    echo "======================================"
    echo ""
    echo "Fish Functions:"
    echo "  ff          - Focus Finder: Fuzzy search all windows"
    echo "  ffw         - Focus Finder Workspace: Search with workspace info"
    echo "  fw          - Focus Workspace: Quick workspace switcher"
    echo ""
    echo "Keyboard Shortcuts in Fish:"
    echo "  Ctrl+W      - Launch focus finder (ff)"
    echo "  Alt+W       - Launch workspace switcher (fw)"
    echo ""
    echo "FZF Bindings (in ff/ffw):"
    echo "  Enter       - Focus selected window"
    echo "  Ctrl+W      - Move window to current workspace"
    echo "  Ctrl+Y      - Copy app name to clipboard"
    echo "  Ctrl+O      - Open new instance of app"
    echo "  Ctrl+X      - Close window (in ffw)"
    echo ""
    echo "Aerospace Shortcuts (global):"
    echo "  Cmd+H/J/K/L        - Focus window (left/down/up/right)"
    echo "  Cmd+Shift+H/J/K/L  - Move window"
    echo "  Cmd+1-9            - Switch to workspace"
    echo "  Cmd+Shift+1-9      - Move window to workspace"
    echo "  Cmd+F              - Fullscreen toggle"
    echo "  Cmd+R              - Enter resize mode"
    echo "  Cmd+T              - Cycle layouts"
    echo "  Cmd+Shift+Space    - Float/tile window"
    echo ""
    echo "Requirements:"
    echo "  - aerospace (brew install --cask nikitabobko/tap/aerospace)"
    echo "  - fzf (brew install fzf)"
    echo ""
    
    # Check installation status
    if type -q aerospace
        echo "✓ aerospace is installed"
    else
        echo "✗ aerospace is NOT installed"
    end
    
    if type -q fzf
        echo "✓ fzf is installed"
    else
        echo "✗ fzf is NOT installed"
    end
end