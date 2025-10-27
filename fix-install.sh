#!/bin/bash

set -euo pipefail

echo "========================================"
echo "Dotfiles Installation Fix Script"
echo "========================================"
echo ""
echo "This script will:"
echo "1. Install Fisher and required plugins"
echo "2. Install Node.js via nvm.fish"
echo "3. Install gg (git aliases)"
echo "4. Install Claude Code tools"
echo ""

# Install Fisher and plugins
echo "Step 1: Installing Fisher and plugins..."
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fish -c "fisher install jorgebucaran/nvm.fish PatrickF1/fzf.fish"
fish -c "fisher list"
echo "✓ Fisher plugins installed"
echo ""

# Install Node.js
echo "Step 2: Installing Node.js via nvm.fish..."
if fish -c "type -q nvm"; then
    fish -c "nvm-setup"
    echo "✓ Node.js installed"
else
    echo "✗ nvm.fish not available. Please restart your shell and try again."
fi
echo ""

# Install gg
echo "Step 3: Installing gg..."
mkdir -p "$HOME/.local/bin"
if command -v gg >/dev/null 2>&1; then
    echo "✓ gg is already installed: $(gg --version 2>/dev/null || echo 'installed')"
else
    curl -fsSL https://github.com/csi-lk/gg/raw/master/install.sh | bash
    export PATH="$HOME/.local/bin:$PATH"
    if command -v gg >/dev/null 2>&1; then
        echo "✓ gg installed: $(which gg)"
    else
        echo "✗ gg installation failed"
    fi
fi
echo ""

# Install Claude Code
echo "Step 4: Installing Claude Code tools..."
if command -v npm >/dev/null 2>&1; then
    if ! command -v claude >/dev/null 2>&1; then
        npm install -g @anthropic-ai/claude-code
    fi
    if ! command -v claude-squad >/dev/null 2>&1; then
        npm install -g claude-squad
    fi
    echo "✓ Claude Code tools installed"
else
    echo "⚠ npm not found. Please restart your shell and run this script again."
fi
echo ""

echo "========================================"
echo "Installation complete!"
echo "========================================"
echo ""
echo "Please restart your terminal or run: exec fish"
echo ""
echo "To verify installations:"
echo "  - fish:   fisher list"
echo "  - node:   node --version"
echo "  - gg:     gg --version"
echo "  - claude: claude --version"
