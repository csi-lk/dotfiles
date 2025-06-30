# Fish configuration

# Disable greeting
set -g fish_greeting

# Set editor
set -gx EDITOR hx
set -gx VISUAL hx

# Initialize starship prompt
if type -q starship
    starship init fish | source
end

# Initialize zoxide
if type -q zoxide
    zoxide init fish | source
end

# Aliases
alias ls="eza --icons"
alias ll="eza -l --icons"
alias la="eza -la --icons"
alias tree="eza --tree --icons"
alias cat="bat"
alias cd="z"
alias vim="hx"
alias vi="hx"

# Git aliases
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"

# PATH additions
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin

# Set up fzf key bindings
if type -q fzf
    fzf --fish | source
end

# OS-specific configurations
switch (uname)
    case Darwin
        # macOS specific settings
        if test -d /opt/homebrew
            fish_add_path /opt/homebrew/bin
            fish_add_path /opt/homebrew/sbin
        end
    case Linux
        # Linux specific settings
        if test -d /home/linuxbrew/.linuxbrew
            fish_add_path /home/linuxbrew/.linuxbrew/bin
        end
end

# GitHub Codespaces specific
if set -q CODESPACES
    # Codespaces specific settings
    set -gx BROWSER "gh cs ports forward 8080:8080 --app browser"
end