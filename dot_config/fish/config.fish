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

# Common PATH additions
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/bin

# OS-specific configurations
switch (uname)
    case Darwin
        # macOS specific settings
        
        # Homebrew paths (Apple Silicon and Intel)
        if test -d /opt/homebrew
            # Apple Silicon
            eval (/opt/homebrew/bin/brew shellenv)
            fish_add_path /opt/homebrew/bin
            fish_add_path /opt/homebrew/sbin
        else if test -d /usr/local/Homebrew
            # Intel Mac
            eval (/usr/local/bin/brew shellenv)
            fish_add_path /usr/local/bin
            fish_add_path /usr/local/sbin
        end
        
        # macOS specific paths
        fish_add_path /usr/local/opt/coreutils/libexec/gnubin
        fish_add_path /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
        
        # Set up homebrew environment variables
        if type -q brew
            set -gx HOMEBREW_NO_ANALYTICS 1
        end
        
    case Linux
        # Linux specific settings
        
        # Linuxbrew if installed
        if test -d /home/linuxbrew/.linuxbrew
            eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
            fish_add_path /home/linuxbrew/.linuxbrew/bin
        end
        
        # Snap binaries
        if test -d /snap/bin
            fish_add_path /snap/bin
        end
        
        # Flatpak exports
        if test -d /var/lib/flatpak/exports/bin
            fish_add_path /var/lib/flatpak/exports/bin
        end
        
        if test -d $HOME/.local/share/flatpak/exports/bin
            fish_add_path $HOME/.local/share/flatpak/exports/bin
        end
end

# Language-specific paths
# Go
if test -d $HOME/go/bin
    fish_add_path $HOME/go/bin
    set -gx GOPATH $HOME/go
end

# Rust
if test -d $HOME/.cargo/bin
    fish_add_path $HOME/.cargo/bin
end

# Ruby (if using rbenv)
if test -d $HOME/.rbenv/bin
    fish_add_path $HOME/.rbenv/bin
    if type -q rbenv
        rbenv init - | source
    end
end

# Python (if using pyenv)
if test -d $HOME/.pyenv/bin
    fish_add_path $HOME/.pyenv/bin
    if type -q pyenv
        pyenv init - | source
    end
end

# Set up fzf
if type -q fzf
    # Set fzf default options
    set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --inline-info'
    
    # Use fd for fzf if available
    if type -q fd
        set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
        set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
        set -gx FZF_ALT_C_COMMAND 'fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
    end
end

# nvm.fish configuration
set -gx nvm_default_version lts

# GitHub Codespaces specific
if set -q CODESPACES
    # Codespaces specific settings
    set -gx BROWSER "gh cs ports forward 8080:8080 --app browser"
    
    # Add codespaces npm global path
    if test -d /usr/local/share/npm-global/bin
        fish_add_path /usr/local/share/npm-global/bin
    end
end

# Load local config if it exists
if test -f $HOME/.config/fish/local.fish
    source $HOME/.config/fish/local.fish
end