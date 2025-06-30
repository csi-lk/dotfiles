;;; init.el --- Modern Emacs Configuration with VSCode-like Features
;;; Commentary:
;; This configuration provides a modern, VSCode-like editing experience
;; with familiar keybindings, TypeScript/JavaScript support, and AI completion.
;;
;; First-time setup:
;; 1. Start Emacs - packages will auto-install
;; 2. Run: M-x all-the-icons-install-fonts (for file explorer icons)
;; 3. For Copilot: M-x copilot-login and follow instructions
;; 4. Restart Emacs

;;; Code:

;; ============================================================================
;; PERFORMANCE OPTIMIZATIONS
;; ============================================================================

;; Increase garbage collection threshold during startup
(setq gc-cons-threshold (* 50 1000 1000))

;; Restore normal GC threshold after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1000 1000))))

;; ============================================================================
;; PACKAGE MANAGEMENT
;; ============================================================================

;; Initialize package system
(require 'package)

;; Add package archives
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(package-initialize)

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (condition-case err
      (progn
        (package-refresh-contents)
        (package-install 'use-package))
    (error
     (message "Failed to install use-package: %s" err))))

;; Configure use-package
(when (package-installed-p 'use-package)
  (require 'use-package)
  (setq use-package-always-ensure t
        use-package-verbose t))

;; ============================================================================
;; BASIC SETTINGS
;; ============================================================================

;; UI Improvements
(setq inhibit-startup-message t)     ; Disable startup screen
(global-hl-line-mode 1)              ; Highlight current line
(column-number-mode 1)               ; Show column numbers
(global-display-line-numbers-mode 1) ; Show line numbers
(setq display-line-numbers-type 'relative) ; Relative line numbers

;; GUI-specific settings (only available in graphical Emacs)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))                ; Disable toolbar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))              ; Disable scrollbar
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))                ; Disable menu bar

;; Editor behavior
(setq-default indent-tabs-mode nil)  ; Use spaces instead of tabs
(setq-default tab-width 2)           ; 2-space indentation
(setq make-backup-files nil)         ; Don't create backup files
(setq auto-save-default nil)         ; Don't auto-save
(global-auto-revert-mode 1)          ; Auto-reload files changed on disk
(delete-selection-mode 1)            ; Replace selected text when typing
(electric-pair-mode 1)               ; Auto-close brackets/quotes
(show-paren-mode 1)                  ; Highlight matching parentheses

;; Better defaults
(setq ring-bell-function 'ignore)    ; Disable bell
(setq scroll-conservatively 100000)  ; Smooth scrolling
(setq scroll-margin 3)               ; Keep 3 lines visible when scrolling

;; Suppress warnings about evil-mode functions (we're not using evil)
(setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local))

;; ============================================================================
;; VSCODE-STYLE KEYBINDINGS
;; ============================================================================

;; CUA mode for familiar copy/paste/undo
(cua-mode 1)

;; Global keybindings (VSCode style)
(global-set-key (kbd "C-s") 'save-buffer)                    ; Save
(global-set-key (kbd "C-h") 'query-replace)                  ; Replace (Ctrl+H)
(global-set-key (kbd "C-S-h") 'query-replace-regexp)         ; Replace with regex
(global-set-key (kbd "C-g") 'goto-line)                      ; Go to line
(global-set-key (kbd "C-/") 'comment-line)                   ; Toggle comment
(global-set-key (kbd "C-S-/") 'comment-or-uncomment-region)  ; Block comment
(global-set-key (kbd "S-C-d") 'duplicate-line)               ; Duplicate line (Shift+Ctrl+D)
(global-set-key (kbd "C-w") 'kill-current-buffer)            ; Close buffer
(global-set-key (kbd "C-n") 'find-file)                      ; New file
(global-set-key (kbd "C-o") 'find-file)                      ; Open file
(global-set-key (kbd "C-`") 'other-window)                   ; Switch window
(global-set-key (kbd "C-S-p") 'consult-find)                 ; Command palette style
(global-set-key (kbd "C-S-o") 'consult-buffer)               ; Quick open files
(global-set-key (kbd "C-S-f") 'swiper-all)                   ; Find in all files
(global-set-key (kbd "C-,") 'customize-group)                ; Settings (like Ctrl+,)

;; Define duplicate-line function
(defun duplicate-line ()
  "Duplicate the current line."
  (interactive)
  (save-excursion
    (let ((line-text (thing-at-point 'line)))
      (end-of-line)
      (newline)
      (insert line-text))))

;; ============================================================================
;; THEME AND APPEARANCE
;; ============================================================================

;; Modern dark theme
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

;; Better modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 25
        doom-modeline-bar-width 3
        doom-modeline-project-detection 'auto
        doom-modeline-buffer-file-name-style 'truncate-upto-project))

;; Icons for file explorer (GUI only)
(use-package all-the-icons
  :if (and (display-graphic-p) (not (eq system-type 'windows-nt))))

;; ============================================================================
;; COMPLETION AND FUZZY FINDING
;; ============================================================================

;; Vertico for better minibuffer completion
(use-package vertico
  :init
  (vertico-mode))

;; Marginalia for richer annotations
(use-package marginalia
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

;; Orderless for flexible matching
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Consult for enhanced search commands
(use-package consult
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ; Enhanced eval-expression
         ("C-x b" . consult-buffer)                ; Enhanced switch-buffer
         ("C-x 4 b" . consult-buffer-other-window) ; Buffer in other window
         ("C-x 5 b" . consult-buffer-other-frame)  ; Buffer in other frame
         ("C-x r b" . consult-bookmark)            ; Bookmarks
         ("C-x p b" . consult-project-buffer)      ; Project buffers
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ; Store to register
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ; yank-pop replacement
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ; Enhanced goto-line
         ("M-g M-g" . consult-goto-line)           ; Enhanced goto-line
         ("M-g o" . consult-outline)               ; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ; Enhanced isearch-edit-string
         ("M-s e" . consult-isearch-history)       ; Enhanced isearch-edit-string
         ("M-s l" . consult-line)                  ; Needed by consult-line
         ("M-s L" . consult-line-multi)            ; Needed by consult-line
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ; Enhanced next-matching-history-element
         ("M-r" . consult-history))                ; Enhanced previous-matching-history-element
  :config
  ;; Use Consult to select xref locations
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))

;; Fuzzy file finding (Ctrl+P equivalent)
(global-set-key (kbd "C-p") 'consult-find)

;; ============================================================================
;; FILE EXPLORER
;; ============================================================================

;; Treemacs for file explorer
(use-package treemacs
  :defer t
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag))
  :config
  (setq treemacs-width 30
        treemacs-show-cursor t
        treemacs-show-hidden-files t))

(use-package treemacs-all-the-icons
  :if (and (display-graphic-p) (not (eq system-type 'windows-nt)))
  :after (treemacs all-the-icons))

;; Toggle treemacs with F8 (VSCode style)
(global-set-key (kbd "<f8>") 'treemacs)

;; ============================================================================
;; LSP AND LANGUAGE SUPPORT
;; ============================================================================

;; LSP Mode
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((typescript-mode . lsp)
         (js-mode . lsp)
         (web-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config
  (setq lsp-completion-provider :none) ; Use company-capf instead
  (setq lsp-headerline-breadcrumb-enable t)
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-doc-enable t))

;; LSP UI enhancements
(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-position 'bottom
        lsp-ui-doc-max-height 20
        lsp-ui-doc-max-width 80
        lsp-ui-sideline-show-hover t))

;; TypeScript support
(use-package typescript-mode
  :mode "\\.ts\\'"
  :config
  (setq typescript-indent-level 2))

;; Web mode for JSX/TSX
(use-package web-mode
  :mode (("\\.jsx\\'" . web-mode)
         ("\\.tsx\\'" . web-mode))
  :config
  (setq web-mode-content-types-alist
        '(("jsx" . "\\.jsx?\\'")
          ("tsx" . "\\.tsx?\\'")))
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2))

;; ============================================================================
;; COMPLETION AND SNIPPETS
;; ============================================================================

;; Company for auto-completion
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0
        company-tooltip-align-annotations t
        company-tooltip-limit 10)
  :bind
  (:map company-active-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
        ("<tab>" . company-complete-selection)))

;; Yasnippet for code snippets
(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :after yasnippet)

;; ============================================================================
;; AI COMPLETION (COPILOT)
;; ============================================================================

;; Note: GitHub Copilot requires manual installation
;; To install Copilot:
;; 1. Clone the repository: git clone https://github.com/zerolfx/copilot.el.git ~/.emacs.d/copilot
;; 2. Add to your init.el: (add-to-list 'load-path "~/.emacs.d/copilot")
;; 3. Uncomment the configuration below and restart Emacs
;; 4. Run M-x copilot-login

;; (add-to-list 'load-path "~/.emacs.d/copilot")
;; (require 'copilot)
;; (add-hook 'prog-mode-hook 'copilot-mode)
;; (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
;; (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)

;; ============================================================================
;; GIT INTEGRATION
;; ============================================================================

;; Magit for Git
(use-package magit
  :bind ("C-x g" . magit-status))

;; Git gutter for line-by-line changes
(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.05))

;; ============================================================================
;; TERMINAL INTEGRATION
;; ============================================================================

;; Better terminal (if available)
(use-package vterm
  :if (and (not (eq system-type 'windows-nt)) (executable-find "cmake"))
  :config
  (setq vterm-max-scrollback 10000))

;; Terminal toggle - fallback to shell if vterm not available
(if (and (not (eq system-type 'windows-nt)) (executable-find "cmake"))
    (global-set-key (kbd "C-`") 'vterm)
  (global-set-key (kbd "C-`") 'shell))

;; ============================================================================
;; PROJECT MANAGEMENT
;; ============================================================================

;; Projectile for project management
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'default))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/dev")
    (setq projectile-project-search-path '("~/dev")))
  (setq projectile-switch-project-action #'projectile-dired))

;; ============================================================================
;; ADDITIONAL UI ENHANCEMENTS
;; ============================================================================

;; Rainbow delimiters for bracket matching
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Highlight indent guides (VSCode-style indentation lines)
(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-character ?\|
        highlight-indent-guides-responsive 'top))

;; Smooth scrolling (like VSCode)
(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1)
  (setq smooth-scroll-margin 5))

;; Auto-save like VSCode (save on focus loss)
(use-package super-save
  :config
  (super-save-mode +1)
  (setq super-save-auto-save-when-idle t
        super-save-idle-duration 5
        super-save-delete-trailing-whitespace 'except-current-line))

;; Expand region (select expanding regions like VSCode)
(use-package expand-region
  :bind ("C-=" . er/expand-region))

;; Which-key for keybinding help
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

;; Multiple cursors (like VSCode)
(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)
         ("C-d" . mc/mark-next-like-this)      ; VSCode-style Ctrl+D
         ("C-S-l" . mc/edit-lines)))           ; VSCode-style Ctrl+Shift+L

;; Move lines up/down (VSCode-style Alt+Up/Down)
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

;; Better search (like VSCode search)
(use-package swiper
  :config
  (global-set-key (kbd "C-f") 'swiper))  ; VSCode-style find in current file

;; ============================================================================
;; STARTUP MESSAGE
;; ============================================================================

(defun display-startup-message ()
  "Display a helpful startup message."
  (message "🚀 VSCode-like Emacs ready! F8=files, C-p=fuzzy find, C-f=search, C-d=multi-cursor, C-x g=git"))

(add-hook 'emacs-startup-hook #'display-startup-message)

;;; init.el ends here