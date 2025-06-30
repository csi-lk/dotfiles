# Modern Emacs Configuration

A modern, VSCode-like Emacs configuration optimized for web development with TypeScript/JavaScript support, AI completion, and familiar keybindings.

## 🚀 Features

### Core Features
- **VSCode-style keybindings** - Familiar shortcuts (Ctrl+S, Ctrl+C/V, Ctrl+F, etc.)
- **Non-modal editing** - No vim modes, direct typing experience
- **Modern package management** - Automatic package installation with use-package
- **TypeScript/JavaScript LSP** - Full IntelliSense with typescript-language-server
- **AI Completion** - GitHub Copilot integration
- **Syntax highlighting** - Support for all major languages
- **File explorer** - Treemacs with icons (F8 to toggle)
- **Fuzzy file finding** - Ctrl+P for quick file navigation

### Nice-to-Have Features
- **Git integration** - Magit for Git operations (Ctrl+X G)
- **Terminal integration** - Built-in terminal (Ctrl+`)
- **Project management** - Projectile for project-wide operations
- **Auto-completion** - Company mode with snippets
- **Rainbow parentheses** - Visual bracket matching
- **Modern UI** - Doom themes with clean modeline
- **Multiple cursors** - VSCode-style multi-selection

## 🎯 **VSCode-like Features Included**

✅ **All the plugins you mentioned are already included:**
- **treemacs** - File tree sidebar (F8)
- **company** - Auto-completion 
- **multiple-cursors** - Multi-cursor editing (Ctrl+D)
- **typescript-mode** - TypeScript support
- **doom-modeline** - Clean status bar
- **highlight-indent-guides** - Indentation guides ✨ *newly added*

✅ **Plus these additional VSCode-like enhancements:**
- **Smooth scrolling** - Like VSCode scrolling behavior
- **Auto-save** - Saves automatically when you switch apps
- **Move lines** - Alt+Up/Down to move lines around
- **Expand selection** - Ctrl+= to intelligently expand selection
- **Enhanced search** - Better find/replace with live preview
- **Command palette** - Ctrl+Shift+P for command discovery

## 📋 Quick Start

### 1. Choose Your Emacs Version
The dotfiles install terminal Emacs by default. For the full GUI experience with icons and better theming:

```bash
# Install GUI Emacs (recommended for full features)
brew install --cask emacs

# Or stick with terminal Emacs (already installed)
emacs
```

### 2. First Launch
```bash
# Start Emacs - packages will auto-install (takes a few minutes)
emacs
# Or for GUI version:
open -a Emacs
```

### 3. Install Icons (GUI Only)
```
M-x all-the-icons-install-fonts
```
Then restart your terminal/system to refresh fonts.

### 4. Setup Copilot (Optional)
```
M-x copilot-login
```
Follow the browser instructions to authenticate.

### 5. Install Language Servers
For TypeScript/JavaScript support:
```bash
# Install TypeScript language server
npm install -g typescript-language-server typescript
```

## ⌨️ Key Bindings

### File Operations
| Key | Function |
|-----|----------|
| `Ctrl+N` | New file |
| `Ctrl+O` | Open file |
| `Ctrl+S` | Save file |
| `Ctrl+W` | Close buffer |
| `Ctrl+P` | Fuzzy file finder |
| `Ctrl+Shift+P` | Command palette |
| `Ctrl+Shift+O` | Quick open buffers |
| `F8` | Toggle file explorer |
| `Ctrl+,` | Settings |

### Editing
| Key | Function |
|-----|----------|
| `Ctrl+C` | Copy |
| `Ctrl+V` | Paste |
| `Ctrl+X` | Cut |
| `Ctrl+Z` | Undo |
| `Ctrl+Y` | Redo |
| `Shift+Ctrl+D` | Duplicate line |
| `Ctrl+/` | Toggle comment |
| `Ctrl+Shift+/` | Block comment/uncomment |
| `Ctrl+F` | Find in file (enhanced) |
| `Ctrl+H` | Replace |
| `Ctrl+Shift+H` | Replace with regex |
| `Ctrl+G` | Go to line |
| `Alt+Up/Down` | Move line up/down |

### Advanced Editing
| Key | Function |
|-----|----------|
| `Ctrl+D` | Mark next like this (VSCode style) |
| `Ctrl+Shift+L` | Edit multiple lines |
| `Ctrl+>` | Mark next like this |
| `Ctrl+<` | Mark previous like this |
| `Ctrl+C Ctrl+<` | Mark all like this |
| `Ctrl+=` | Expand selection |

### Code Navigation
| Key | Function |
|-----|----------|
| `Ctrl+C L G D` | Go to definition |
| `Ctrl+C L G R` | Find references |
| `Ctrl+C L R` | Rename symbol |
| `Ctrl+C L A` | Code actions |

### Git
| Key | Function |
|-----|----------|
| `Ctrl+X G` | Git status (Magit) |

### Project
| Key | Function |
|-----|----------|
| `Ctrl+C P F` | Find file in project |
| `Ctrl+C P P` | Switch project |
| `Ctrl+C P S G` | Search in project |

### Terminal
| Key | Function |
|-----|----------|
| `Ctrl+\`` | Toggle terminal |

## 🛠️ Configuration Structure

```
.emacs.d/
├── init.el          # Main configuration file
├── README.md        # This file
└── elpa/            # Package directory (auto-created)
```

## 📦 Included Packages

### Core Packages
- **use-package** - Modern package management
- **straight** - Alternative package manager for Copilot
- **doom-themes** - Modern theme collection
- **doom-modeline** - Clean status line

### Completion & Navigation
- **vertico** - Enhanced minibuffer completion
- **marginalia** - Rich completion annotations
- **orderless** - Flexible completion matching
- **consult** - Enhanced search commands
- **company** - Auto-completion framework

### Language Support
- **lsp-mode** - Language Server Protocol client
- **lsp-ui** - UI enhancements for LSP
- **typescript-mode** - TypeScript support
- **web-mode** - JSX/TSX support

### File Management
- **treemacs** - File explorer
- **projectile** - Project management
- **all-the-icons** - File icons

### Git & Terminal
- **magit** - Git interface
- **git-gutter** - Git line indicators
- **vterm** - Terminal emulator

### AI & Snippets
- **copilot** - GitHub Copilot integration
- **yasnippet** - Code snippets

### UI Enhancements
- **rainbow-delimiters** - Colored parentheses
- **highlight-indent-guides** - VSCode-style indentation guides
- **which-key** - Keybinding help
- **multiple-cursors** - Multi-selection editing
- **smooth-scrolling** - Smooth scrolling like VSCode
- **super-save** - Auto-save on focus loss
- **expand-region** - Smart selection expansion
- **drag-stuff** - Move lines/regions up/down
- **swiper** - Enhanced search interface

## 🔧 Customization

### Adding New Languages
To add support for a new language, add to your init.el:
```elisp
(use-package your-language-mode
  :hook (your-language-mode . lsp))
```

### Changing Theme
Replace the theme in init.el:
```elisp
(load-theme 'doom-dracula t)  ; or any other doom theme
```

### Custom Keybindings
Add custom keybindings:
```elisp
(global-set-key (kbd "C-custom") 'your-function)
```

## 🐛 Troubleshooting

### Common Issues

**Packages not installing**
- Check internet connection
- Run `M-x package-refresh-contents`
- Restart Emacs

**LSP not working**
- Install language servers: `npm install -g typescript-language-server`
- Run `M-x lsp-doctor` to diagnose issues

**Icons not showing**
- Run `M-x all-the-icons-install-fonts`
- Restart terminal/system

**Copilot not working**
- Run `M-x copilot-login`
- Check GitHub Copilot subscription

### Performance Issues
If Emacs feels slow:
- Increase `gc-cons-threshold` in init.el
- Disable `lsp-ui-doc` if too intrusive
- Use `M-x profiler-start` to identify bottlenecks

## 📚 Learning Resources

### Emacs Basics
- `C-h t` - Built-in Emacs tutorial
- `C-h k` - Describe key binding
- `C-h f` - Describe function
- `C-h v` - Describe variable

### Package Documentation
- `M-x describe-package` - Package information
- Each package's GitHub repository for detailed docs

### Useful Commands
- `M-x package-list-packages` - Browse available packages
- `M-x customize-group` - GUI configuration options
- `M-x eval-buffer` - Reload configuration

## 🔄 Updates

To update packages:
```
M-x package-list-packages
U x
```

To update this configuration:
```bash
cd ~/dev/dotfiles
git pull
chezmoi apply
```

---

Happy coding! 🎉