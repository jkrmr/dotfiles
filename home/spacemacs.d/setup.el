;;; setup.el --- Emacs configuration customizations.

;;; Commentary:

;;; Code:
(require 'funcs)
(require 'editorconfig)

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
(config/python)
(config/ruby)
(config/ruby-folding)
(config/set-terminal-emacs-theme)
(config/shell-buffers)
(config/underscore-to-word-char-list)
(config/web-mode)

;; misc settings
(setq-default
 persp-restore-window-conf-method #'no-op
 browse-url-browser-function 'xwidget-webkit-browse-url
 compilation-scroll-output 'first-error
 ispell-program-name "ispell"
 lsp-signature-auto-activate nil  ;; lsp: don't auto-activate signature hints
 json-fmt-on-save nil
 json-fmt-tool 'prettier
 mac-command-modifier 'super
 projectile-completion-system 'helm
 projectile-enable-caching t
 projectile-find-dir-includes-top-level t
 projectile-project-search-path '("~/Projects" "~/Work" "~/Resources" "~/Exercism" "~/Tutorials")
 tramp-default-method "ssh")

;; projectile
(add-to-list 'projectile-globally-ignored-directories "node_modules" t)

;; Appearance: Enable transparency
;; ensure new frames are created transparent
(add-hook 'after-make-frame-functions #'spacemacs/enable-transparency)
;; make the current one transparent
(spacemacs/enable-transparency)

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

;; garbage collection optimizations
(defun disable-garbage-collection ()
  "Disable GC by setting threshold to max num."
  (setq-default gc-cons-threshold most-positive-fixnum))
(defun enable-garbage-collection ()
  "Re-enable GC collection. Set threshold to init.el value."
  (setq-default gc-cons-threshold (car dotspacemacs-gc-cons)))
(add-hook 'minibuffer-setup-hook #'disable-garbage-collection)
(add-hook 'minibuffer-exit-hook #'enable-garbage-collection)

;; misc hooks
(add-hook 'elixir-mode-hook #'lsp)
(add-hook 'ledger-mode-hook #'evil-ledger-mode)

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
