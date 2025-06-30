# GitHub Codespaces Dotfiles Setup

To enable automatic dotfiles installation in all your GitHub Codespaces:

1. Go to https://github.com/settings/codespaces
2. In the "Dotfiles" section, enable "Automatically install dotfiles"
3. Select this repository from the dropdown
4. Save your settings

Once configured, every new Codespace you create will automatically:
- Clone this dotfiles repository
- Run the `install.sh` script
- Set up your complete development environment

## What Gets Installed

- Fish shell as default terminal
- All CLI tools (gg, fzf, ripgrep, etc.)
- Helix editor with LSP servers
- Node.js via nvm.fish
- VS Code extensions for frontend development
- Custom key bindings and settings

## Testing

To test the setup:
1. Create a new Codespace on any repository
2. Wait for the container to build
3. Open a new terminal - it should be using Fish
4. Run `helix-lsp-status` to verify language servers

## Troubleshooting

If the dotfiles don't install automatically:
- Check the Codespace creation logs
- Manually run: `cd /workspaces/.codespaces/.persistedshare/dotfiles && ./install.sh`
- Verify your GitHub settings at https://github.com/settings/codespaces