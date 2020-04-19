;;; setup.el --- Emacs configuration customizations.

;;; Commentary:

;;; Code:
(require 'funcs)
(require 'editorconfig)

(config/compilation-buffers)
(config/copy-as-format)
(config/elixir)
(config/elm)
(config/evil-collection)
(config/evil-goggles)
(config/flycheck)
(config/google-translate)
(config/highlight-lines-at-length 80)
(config/javascript-modes)
(config/latex-mode)
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

;; misc settings
(setq-default
 browse-url-browser-function 'xwidget-webkit-browse-url
 compilation-scroll-output 'first-error
 ispell-program-name "ispell"
 mac-command-modifier 'super
 projectile-completion-system 'helm
 projectile-enable-caching t
 projectile-find-dir-includes-top-level t
 projectile-project-search-path '("~/Projects" "~/Work" "~/Resources" "~/Exercism")
 tramp-default-method "ssh")

;; misc hooks
(add-hook 'elixir-mode-hook #'lsp)
(add-hook 'ledger-mode-hook #'evil-ledger-mode)

;; Appearance: treemacs icons
(treemacs-resize-icons 15)

;; Appearance: Enable transparency
(setq-default
 dotspacemacs-active-transparency 95
 dotspacemacs-inactive-transparency 85)
(add-hook 'after-make-frame-functions #'spacemacs/enable-transparency)

;; Appearance: Natural titlebar
(when window-system
  (add-to-list 'default-frame-alist '(ns-appearance . dark))
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))

;; Appearance: Render emoji
(defun set-emoji-font (frame)
  "Adjust the font settings of FRAME so Emacs can render emoji codes as emoji."
  (if (eq system-type 'darwin)
      (set-fontset-font t 'unicode (font-spec :family "Apple Color Emoji") frame 'prepend)
    (set-fontset-font t 'unicode (font-spec :family "Symbola") frame 'prepend)))

(if window-system (set-emoji-font nil)
  (add-hook 'after-make-frame-functions #'set-emoji-font))

;; globally enabled minor modes
(beacon-mode)
(editorconfig-mode)
(global-evil-matchit-mode)
(global-evil-quickscope-mode)
(direnv-mode)
(smartparens-global-strict-mode)
(global-visual-line-mode)
(company-prescient-mode)
(prescient-persist-mode)

;; ido (for amx, ido-dired)
(ido-mode)
(flx-ido-mode 1)
(setq-default
 ido-enable-flex-matching t
 ;; disable ido faces to see flx highlights
 ido-use-faces nil)

;; after-init hooks
(add-hook 'after-init-hook #'global-emojify-mode)
(add-hook 'after-init-hook #'global-company-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Post-config
(config/prettify-symbols)
(config/company)
(config/load-local-config)

(provide 'setup)
;;; setup.el ends here
