#!/bin/bash

set -euo pipefail

CHEZMOI_VERSION="2.47.1"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "darwin"
    else
        echo "unknown"
    fi
}

# Install chezmoi
install_chezmoi() {
    if command -v chezmoi >/dev/null 2>&1; then
        info "chezmoi is already installed"
        return
    fi
    
    info "Installing chezmoi..."
    
    OS=$(detect_os)
    ARCH=$(uname -m)
    
    if [ "$OS" = "darwin" ] && command -v brew >/dev/null 2>&1; then
        brew install chezmoi
    else
        # Install using the official script
        sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
        export PATH="$HOME/.local/bin:$PATH"
    fi
    
    if ! command -v chezmoi >/dev/null 2>&1; then
        error "Failed to install chezmoi"
    fi
    
    info "chezmoi installed successfully"
}

# Main installation
main() {
    info "Starting dotfiles installation..."
    
    # Check if we're in the dotfiles repo
    if [ ! -f ".chezmoi.toml.tmpl" ]; then
        error "Please run this script from the dotfiles repository root"
    fi
    
    # Install chezmoi
    install_chezmoi
    
    # Initialize chezmoi with this repository
    info "Initializing chezmoi..."
    if [ -n "${CODESPACES:-}" ]; then
        # GitHub Codespaces
        chezmoi init --apply --source="$PWD"
    else
        # Regular installation
        chezmoi init --apply --source="$PWD"
    fi
    
    info "Installation complete!"
    info ""
    info "Next steps:"
    info "1. Restart your terminal or run: exec fish"
    info "2. All your tools should be configured and ready to use"
    info ""
    info "To update your dotfiles later, run: chezmoi update"
}

# Run main function
main "$@"