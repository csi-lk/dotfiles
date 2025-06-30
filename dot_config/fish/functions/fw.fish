function fw --description "Focus workspace - fuzzy search and switch workspaces"
    # Check if we're on macOS
    if test (uname) != "Darwin"
        echo "fw: This function is only available on macOS" >&2
        return 1
    end
    
    # Check if aerospace is installed
    if not type -q aerospace
        echo "fw: aerospace is not installed" >&2
        return 1
    end
    
    # Get list of workspaces with window count
    set -l workspaces (aerospace list-workspaces)
    
    # Create workspace info with window counts
    set -l workspace_info
    for ws in $workspaces
        set -l window_count (aerospace list-windows --workspace $ws | wc -l | tr -d ' ')
        set -a workspace_info "$ws ($window_count windows)"
    end
    
    # Use fzf to select workspace
    set -l selected (printf '%s\n' $workspace_info | \
        fzf --height=20% \
            --layout=reverse \
            --border=rounded \
            --prompt="🚀 Focus workspace: " \
            --preview-window=hidden \
            --ansi)
    
    # Extract workspace name and focus
    if test -n "$selected"
        set -l workspace (echo $selected | cut -d' ' -f1)
        aerospace workspace $workspace
    end
end