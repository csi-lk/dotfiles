# Auto-start tmux in interactive sessions

# Tmux aliases
if type -q tmux
    alias ta="tmux attach"
    alias tl="tmux list-sessions"
    alias tk="tmux kill-session"
    alias tka="tmux kill-server"
    alias tn="tmux new-session -s"
end