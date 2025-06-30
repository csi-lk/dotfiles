# Auto-start tmux in interactive sessions

# Only auto-start if:
# - We're in an interactive session
# - We're not already in tmux
# - We're in SSH or Codespaces
# - Tmux is installed
if status is-interactive
    and not set -q TMUX
    and type -q tmux
    # Auto-start in Codespaces
    if set -q CODESPACES
        # Check if main session exists
        if tmux has-session -t main 2>/dev/null
            exec tmux attach-session -t main
        else
            exec tmux new-session -s main
        end
    # Auto-start in SSH sessions (optional - uncomment if desired)
    # else if set -q SSH_CLIENT
    #     if tmux has-session -t ssh 2>/dev/null
    #         exec tmux attach-session -t ssh
    #     else
    #         exec tmux new-session -s ssh
    #     end
    end
end

# Tmux aliases
if type -q tmux
    alias ta="tmux attach"
    alias tl="tmux list-sessions"
    alias tk="tmux kill-session"
    alias tka="tmux kill-server"
    alias tn="tmux new-session -s"
end