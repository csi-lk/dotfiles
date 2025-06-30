function ffw --description "Focus finder workspace - fuzzy search windows with workspace info"
    # Check if we're on macOS
    if test (uname) != "Darwin"
        echo "ffw: This function is only available on macOS" >&2
        return 1
    end
    
    # Check dependencies
    if not type -q aerospace
        echo "ffw: aerospace is not installed. Install with: brew install --cask nikitabobko/tap/aerospace" >&2
        return 1
    end
    
    if not type -q fzf
        echo "ffw: fzf is not installed. Install with: brew install fzf" >&2
        return 1
    end
    
    # Get current workspace for reference
    set -l current_workspace (aerospace list-workspaces --focused)
    
    # List windows with enhanced formatting
    # Note: aerospace list-windows doesn't support custom format, so we'll parse the default output
    # Default format is: <window-id> | <app-name> | <window-title>
    set -l window_list (aerospace list-windows --all)
    
    # Use fzf with enhanced display
    echo $window_list | tr ' ' '\n' | \
        fzf --height=60% \
            --layout=reverse \
            --border=rounded \
            --prompt="🔍 Focus window: " \
            --header="Current workspace: $current_workspace | Enter: Focus | Ctrl-W: Move to current workspace" \
            --preview-window=hidden \
            --delimiter='|' \
            --with-nth=2,3,4 \
            --bind='enter:execute(aerospace focus --window-id {1})+abort' \
            --bind='ctrl-w:execute(aerospace move-node-to-workspace --window-id {1} $current_workspace && aerospace focus --window-id {1})+abort' \
            --bind='ctrl-y:execute-silent(echo -n {2} | pbcopy)' \
            --bind='ctrl-o:execute(open -a {2})' \
            --bind='ctrl-x:execute(aerospace close --window-id {1})+abort' \
            --ansi \
            --color=bg+:#3e4452,bg:#282c34,spinner:#e06c75,hl:#61afef \
            --color=fg:#abb2bf,header:#61afef,info:#98c379,pointer:#e06c75 \
            --color=marker:#e06c75,fg+:#ffffff,prompt:#61afef,hl+:#61afef
end