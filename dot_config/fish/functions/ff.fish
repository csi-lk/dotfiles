function ff --description "Focus finder - fuzzy search and switch to any window using aerospace"
    # Check if we're on macOS
    if test (uname) != "Darwin"
        echo "ff: This function is only available on macOS" >&2
        return 1
    end
    
    # Check if aerospace is installed
    if not type -q aerospace
        echo "ff: aerospace is not installed. Install with: brew install --cask nikitabobko/tap/aerospace" >&2
        return 1
    end
    
    # Check if fzf is installed
    if not type -q fzf
        echo "ff: fzf is not installed. Install with: brew install fzf" >&2
        return 1
    end
    
    # List all windows and pipe to fzf
    # Format: window-id | app-name | window-title
    set -l selected (aerospace list-windows --all | \
        fzf --height=40% \
            --layout=reverse \
            --border \
            --prompt="Focus window: " \
            --preview-window=hidden \
            --bind='enter:execute(aerospace focus --window-id {1})+abort' \
            --bind='ctrl-y:execute-silent(echo -n {2} | pbcopy)' \
            --bind='ctrl-o:execute(open -a {2})' \
            --header='Enter: Focus | Ctrl-Y: Copy app name | Ctrl-O: Open new instance' \
            --ansi)
    
    # Return status based on fzf exit code
    return $status
end