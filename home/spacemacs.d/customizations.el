;;; customizations.el --- Emacs configuration customizations.

;;; Commentary:
;; Motify init.el minimally in order to update it easily.

;;; Code:
(require 'config-functions)
(require 'editorconfig)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

(setq-default projectile-completion-system 'helm
              projectile-enable-caching t
              projectile-find-dir-includes-top-level t
              projectile-project-search-path '("~/Projects" "~/Work" "~/Resources" "~/Exercism"))

(with-eval-after-load 'org
  (setq-default
   org-adapt-indentation t
   org-agenda-block-separator ""
   org-babel-python-command "python3"
   org-bullets-bullet-list '("› ")
   org-catch-invisible-edits 'show-and-error
   org-clock-idle-time 5
   org-confirm-babel-evaluate nil
   org-cycle-separator-lines 0
   org-edit-src-content-indentation 0
   org-ellipsis "  "
   org-export-coding-system 'utf-8
   org-export-with-sub-superscripts '{}
   org-fontify-done-headline t
   org-fontify-quote-and-verse-blocks t
   org-fontify-whole-heading-line t
   org-hide-emphasis-markers t
   org-image-actual-width 500
   org-md-headline-style 'setext
   org-modules '(org-bibtex org-docview org-habit org-info)
   org-pretty-entities t
   org-src-tab-acts-natively t
   org-startup-indented t
   spaceline-org-clock-p t)

  (add-hook 'org-mode-hook #'variable-pitch-mode))

;; Pre-config
(config/frames)

(config/amx)
(config/code-folding)
(config/compilation-buffers)
(config/copy-as-format)
(config/deft)
(config/elixir)
(config/elm)
(config/evil-collection)
(config/evil-goggles)
(config/evil-in-ex-buffer)
(config/evil-lion)
(config/flycheck)
(config/google-translate)
(config/gtags)
(config/helpful)
(config/highlight-lines-at-length 80)
(config/ido)
(config/javascript-modes)
(config/latex-mode)
(config/ligatures)
(config/lisps)
(config/markdown-mode)
(config/modeline)
(config/org-latex-preview)
(config/org-mode)
(config/projectile)
(config/python)
(config/ruby)
(config/ruby-in-buffer-eval)
(config/ruby-folding)
(config/semantic)
(config/set-terminal-emacs-theme)
(config/terminal-buffers)
(config/underscore-to-word-char-list)
(config/version-control)
(config/web-beautify)
(config/web-mode)
(config/window-splitting)
(config/yankee)
(config/yasnippet)

;; Post-config
(config/company)
(config/diminish)
(config/prettify-symbols)

(editorconfig-mode 1)

;; compilation buffer
(setq-default compilation-scroll-output 'first-error)

;; lsp
(add-hook 'elixir-mode-hook #'lsp)

;; tramp
(setq-default tramp-default-method "ssh")

;; dash prefix
(spacemacs/declare-prefix "d" "docs")

;; ledger
(add-hook 'ledger-mode-hook #'evil-ledger-mode)

;; treemacs
(treemacs-resize-icons 15)

(setq-default ispell-program-name "ispell")

;; Mac-like keybindings
(setq-default mac-command-modifier 'super)
(global-set-key (kbd "s-s") #'save-buffer)
(global-set-key (kbd "s-k") #'spacemacs/kill-this-buffer)
(global-set-key (kbd "s-=") #'spacemacs/scale-up-font)
(global-set-key (kbd "s--") #'spacemacs/scale-down-font)
(global-set-key (kbd "s-0") #'spacemacs/reset-font-size)

;; Cycle theme
(global-set-key (kbd "M-m T n") 'r/cycle-theme)

;; display emoji as emoji
(add-hook 'after-init-hook #'global-emojify-mode)
(set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)

;; leader-fp to open file at point
(spacemacs/set-leader-keys
  "f p" #'find-file-at-point)

;; Display and copy buffer-file's path
(spacemacs/declare-prefix "f d" "files/display")
(spacemacs/set-leader-keys
  "f d" nil
  "f d p" #'display-and-copy-file-path)

(spacemacs/declare-prefix "L" "layouts")
(spacemacs/set-leader-keys
  "L" nil
  "L r" #'layouts-reset
  "L b" #'layouts-blog
  "L o" #'layouts-org
  "L d" #'layouts-dotfiles)

;; globally enabled minor modes
(add-hook 'after-init-hook #'visual-line-mode)
(global-evil-quickscope-mode 1)
(global-evil-matchit-mode 1)
(smartparens-global-strict-mode)

;; Transparency
(setq-default dotspacemacs-active-transparency 95
              dotspacemacs-inactive-transparency 85)

(spacemacs/enable-transparency)
(add-hook 'after-make-frame-functions #'spacemacs/enable-transparency)
(beacon-mode +1)

(provide 'customizations)
;;; customizations.el ends here
