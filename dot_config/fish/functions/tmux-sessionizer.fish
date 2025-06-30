function tmux-sessionizer --description "Quick project session creator"
    # Find all git repositories under common project directories
    set -l search_dirs ~/dev ~/projects ~/work ~/code ~/.config
    set -l existing_dirs
    
    for dir in $search_dirs
        if test -d $dir
            set existing_dirs $existing_dirs $dir
        end
    end
    
    if test (count $existing_dirs) -eq 0
        echo "No project directories found"
        return 1
    end
    
    # Use fd if available, otherwise use find
    if type -q fd
        set -l selected (fd -H -t d -d 2 '^\.git$' $existing_dirs | xargs dirname | sort -u | fzf --prompt="Select project: ")
    else
        set -l selected (find $existing_dirs -maxdepth 3 -name .git -type d 2>/dev/null | xargs dirname | sort -u | fzf --prompt="Select project: ")
    end
    
    if test -z "$selected"
        return 0
    end
    
    set -l session_name (basename $selected | tr . _)
    
    if not tmux has-session -t $session_name 2>/dev/null
        tmux new-session -d -s $session_name -c $selected
    end
    
    if test -z "$TMUX"
        tmux attach-session -t $session_name
    else
        tmux switch-client -t $session_name
    end
end

# Bind to Ctrl-f for quick access
bind \cf tmux-sessionizer