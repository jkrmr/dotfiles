;;; setup.el --- Emacs configuration customizations.

;;; Commentary:

;;; Code:
(require 'funcs)
(require 'editorconfig)

;; macOS frames
(when window-system
  (add-to-list 'default-frame-alist '(ns-appearance . dark))
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))

(setq-default projectile-completion-system 'helm
              projectile-enable-caching t
              projectile-find-dir-includes-top-level t
              projectile-project-search-path '("~/Projects" "~/Work" "~/Resources" "~/Exercism"))

;;; Setup

(config/compilation-buffers)
(config/copy-as-format)
(config/elixir)
(config/elm)
(config/evil-collection)
(config/evil-goggles)
(config/flycheck)
(config/google-translate)
(config/gtags)
(config/highlight-lines-at-length 80)
(config/ido)
(config/javascript-modes)
(config/latex-mode)
(config/ligatures)
(config/lisps)
(config/org-latex-preview)
(config/org-mode)
(config/projectile)
(config/python)
(config/ruby)
(config/ruby-folding)
(config/set-terminal-emacs-theme)
(config/shell-buffers)
(config/smartparens)
(config/underscore-to-word-char-list)
(config/version-control)
(config/web-beautify)
(config/web-mode)

;; compilation buffer
(setq-default compilation-scroll-output 'first-error)

;; lsp
(add-hook 'elixir-mode-hook #'lsp)

;; tramp
(setq-default tramp-default-method "ssh")

;; ledger
(add-hook 'ledger-mode-hook #'evil-ledger-mode)

;; treemacs
(treemacs-resize-icons 15)

(setq-default ispell-program-name "ispell")

;; Mac-like keybindings
(setq-default mac-command-modifier 'super)

;; display emoji as emoji
(defun --set-emoji-font (frame)
  "Adjust the font settings of FRAME so Emacs can display emoji properly."
  (if (eq system-type 'darwin)
      ;; For NS/Cocoa
      (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") frame 'prepend)
    ;; For Linux
    (set-fontset-font t 'symbol (font-spec :family "Symbola") frame 'prepend)))

;; For when Emacs is started in GUI mode:
(--set-emoji-font nil)

;; Hook for when a frame is created with emacsclient
(add-hook 'after-make-frame-functions '--set-emoji-font)

(add-hook 'after-init-hook #'global-emojify-mode)
(set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)

;; globally enabled minor modes
(add-hook 'after-init-hook #'visual-line-mode)
(global-evil-quickscope-mode 1)
(global-evil-matchit-mode 1)
(global-company-mode)
(smartparens-global-strict-mode)

;; Transparency
(setq-default dotspacemacs-active-transparency 95
              dotspacemacs-inactive-transparency 85)

(spacemacs/enable-transparency)
(add-hook 'after-make-frame-functions #'spacemacs/enable-transparency)
(beacon-mode +1)
(editorconfig-mode 1)

;; webkit
(setq-default browse-url-browser-function 'xwidget-webkit-browse-url)

;; Post-config
(config/prettify-symbols)
(config/company)
(config/load-local-config)

(provide 'setup)
;;; setup.el ends here
