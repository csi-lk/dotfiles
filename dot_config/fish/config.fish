# Fish configuration

# Disable greeting
set -g fish_greeting

# Set editor
set -gx EDITOR nano
set -gx VISUAL nano

# Homebrew settings
set -gx HOMEBREW_NO_AUTO_UPDATE 1

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
alias cd="z"

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
alias ccc="claude --continue"
alias ccp="claude --permission-mode plan"

# claude-squad aliases
alias cs="claude-squad"
alias csa="claude-squad add"
alias csl="claude-squad list"
alias csr="claude-squad run"

# Homebrew aliases
alias brewup="env HOMEBREW_NO_AUTO_UPDATE=0 brew update && brew upgrade"
alias brewfast="env HOMEBREW_NO_AUTO_UPDATE=1 brew"

# PATH additions
fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin

# Homebrew paths (fallback if 00-brew-cache.fish hasn't run yet)
if test -d /opt/homebrew
    fish_add_path /opt/homebrew/bin
    fish_add_path /opt/homebrew/sbin
else if test -d /usr/local/Homebrew
    fish_add_path /usr/local/bin
    fish_add_path /usr/local/sbin
end

fish_add_path /usr/local/opt/coreutils/libexec/gnubin
fish_add_path /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin

if type -q brew
    set -gx HOMEBREW_NO_ANALYTICS 1
end

# Language-specific paths
if test -d $HOME/go/bin
    fish_add_path $HOME/go/bin
    set -gx GOPATH $HOME/go
end

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

# pnpm
if test -d $HOME/.local/share/pnpm
    set -gx PNPM_HOME $HOME/.local/share/pnpm
    fish_add_path $PNPM_HOME
end

# bun
if test -d $HOME/.bun/bin
    set -gx BUN_INSTALL $HOME/.bun
    fish_add_path $HOME/.bun/bin
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

# Load local config if it exists
if test -f $HOME/.config/fish/local.fish
    source $HOME/.config/fish/local.fish
end