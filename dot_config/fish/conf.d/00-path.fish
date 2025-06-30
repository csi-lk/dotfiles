# Early PATH setup to ensure consistent environment

# Ensure ~/.local/bin is in PATH early
if not contains $HOME/.local/bin $PATH
    set -gx PATH $HOME/.local/bin $PATH
end

# Ensure ~/bin is in PATH early
if not contains $HOME/bin $PATH
    set -gx PATH $HOME/bin $PATH
end