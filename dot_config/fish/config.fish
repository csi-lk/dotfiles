# Fish configuration

# Disable greeting
set -g fish_greeting

# Set editor
set -gx EDITOR hx
set -gx VISUAL hx

# Homebrew settings
set -gx HOMEBREW_NO_AUTO_UPDATE 1

# Initialize starship prompt (lazy load to speed up startup)
if type -q starship
    # Use faster initialization method
    set -gx STARSHIP_CONFIG "$HOME/.config/starship.toml"
    function starship_prompt
        starship prompt --status=$status --cmd-duration=$CMD_DURATION --jobs=(jobs -p | wc -l)
    end
    
    # Set up the prompt functions
    function fish_prompt
        starship_prompt
    end
    
    function fish_right_prompt
        # Empty right prompt (starship handles everything)
    end
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
# alias cat="bat"
alias cd="z"
alias vim="hx"
alias vi="hx"

# Chezmoi aliases
alias cm="chezmoi"
alias cma="chezmoi apply"
alias cmaf="chezmoi apply --force"
alias cmd="chezmoi diff"
alias cme="chezmoi edit"
alias cmcd="cd (chezmoi source-path)"
alias cms="chezmoi status"
alias cmu="chezmoi update"

# Claude Code aliases
alias cc="claude"
alias ccc="claude --conversation"
alias ccn="claude --new"
alias ccp="claude --plan"

# claude-squad aliases
alias cs="claude-squad"
alias csa="claude-squad add"
alias csl="claude-squad list"
alias csr="claude-squad run"

# Homebrew aliases
alias brewup="env HOMEBREW_NO_AUTO_UPDATE=0 brew update && brew upgrade"
alias brewfast="env HOMEBREW_NO_AUTO_UPDATE=1 brew"

# Common PATH additions
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/bin

# OS-specific configurations
switch (uname)
    case Darwin
        # macOS specific settings
        
        # Homebrew paths are now handled by 00-brew-cache.fish for faster startup
        # Just add the paths in case the cache hasn't run yet
        if test -d /opt/homebrew
            fish_add_path /opt/homebrew/bin
            fish_add_path /opt/homebrew/sbin
        else if test -d /usr/local/Homebrew
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
set -gx nvm_default_version 20.19.4

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