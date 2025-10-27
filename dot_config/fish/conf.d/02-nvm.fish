# nvm.fish configuration
# Node Version Manager integration for Fish shell

# Set default Node.js version
# This is used by nvm.fish to automatically switch to this version
set -gx nvm_default_version 20.19.4

# Set nvm data directory (optional, defaults to ~/.local/share/nvm)
# Uncomment to customize:
# set -gx nvm_data $HOME/.local/share/nvm

# nvm.fish plugin settings
# These optimize nvm behavior and performance

# Automatically use .nvmrc files when changing directories
# nvm.fish handles this via its CD hook automatically

# Helper function to install and set default Node version
function nvm-setup --description "Install and configure default Node.js version"
    if not type -q nvm
        echo "Error: nvm.fish is not installed. Run 'fisher install jorgebucaran/nvm.fish'"
        return 1
    end

    echo "Installing Node.js $nvm_default_version..."
    nvm install $nvm_default_version

    if test $status -eq 0
        echo "Setting $nvm_default_version as default..."
        nvm use $nvm_default_version

        # Verify installation
        if type -q node
            echo "Node.js version: $(node --version)"
            echo "npm version: $(npm --version)"
            echo ""
            echo "Default Node.js version set successfully!"
        else
            echo "Warning: Node.js installed but not in PATH"
        end
    else
        echo "Error: Failed to install Node.js $nvm_default_version"
        return 1
    end
end

# Helper function to update to latest LTS and set as default
function nvm-update-lts --description "Update to latest LTS version and set as default"
    if not type -q nvm
        echo "Error: nvm.fish is not installed"
        return 1
    end

    echo "Installing latest LTS version..."
    nvm install lts

    if test $status -eq 0
        set -l lts_version (nvm list | grep lts | head -1 | awk '{print $1}')
        echo "Setting $lts_version as default..."

        # Update the default version in config
        echo "Note: Update nvm_default_version in ~/.config/fish/conf.d/02-nvm.fish to: $lts_version"
        nvm use lts
    else
        echo "Error: Failed to install LTS version"
        return 1
    end
end

# Helper function to list installed versions
function nvm-versions --description "List all installed Node.js versions"
    if type -q nvm
        nvm list
    else
        echo "Error: nvm.fish is not installed"
        return 1
    end
end

# Auto-use default version if Node.js is not in PATH
# This ensures we always have Node available after shell startup
if type -q nvm; and not type -q node
    # Silently use default version
    nvm use $nvm_default_version >/dev/null 2>&1
end
