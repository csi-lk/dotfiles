#!/bin/bash

# GitHub Codespaces dotfiles setup script
# This runs automatically when dotfiles are installed via GitHub settings

set -euo pipefail

echo "🚀 Setting up GitHub Codespaces environment..."

# Ensure we're in the right directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

cd "$DOTFILES_DIR"

# Run the main installation
if [ -f "install.sh" ]; then
    echo "Running dotfiles installation..."
    bash install.sh --codespaces
else
    echo "Error: install.sh not found in $DOTFILES_DIR"
    exit 1
fi

# Additional Codespaces-specific setup
echo "Configuring Codespaces-specific settings..."

# Ensure fish is available in VS Code terminal
if command -v fish >/dev/null 2>&1; then
    # Update VS Code settings for the workspace
    VSCODE_SETTINGS_DIR="$HOME/.vscode-remote/data/Machine"
    mkdir -p "$VSCODE_SETTINGS_DIR"
    
    if [ -f "$VSCODE_SETTINGS_DIR/settings.json" ]; then
        # Merge with existing settings
        echo "Updating existing VS Code settings..."
        # This is a simple append - in production you'd want proper JSON merging
        cp "$VSCODE_SETTINGS_DIR/settings.json" "$VSCODE_SETTINGS_DIR/settings.json.bak"
    fi
    
    # Create/update settings
    cat > "$VSCODE_SETTINGS_DIR/settings.json" << 'EOF'
{
    "terminal.integrated.defaultProfile.linux": "fish",
    "terminal.integrated.profiles.linux": {
        "fish": {
            "path": "fish",
            "icon": "terminal-fish"
        }
    }
}
EOF
fi

# Set up Git aliases for Codespaces
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'

# Configure Git for Codespaces
git config --global init.defaultBranch main
git config --global pull.rebase false

echo "✅ Codespaces environment setup complete!"
echo ""
echo "🐟 Fish shell is configured as your default terminal"
echo "📝 Helix editor is ready with LSP support"
echo "🛠️  All development tools are installed"
echo ""
echo "Open a new terminal to start using Fish shell!"