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
  (add-hook 'org-mode-hook #'variable-pitch-mode)
  (setq-default
   org-adapt-indentation t
   org-agenda-block-separator ""
   org-babel-python-command "python3"
   org-blank-before-new-entry '((heading . auto) (plain-list-item . auto))
   org-bullets-bullet-list '("› ")
   org-catch-invisible-edits 'show-and-error
   org-clock-idle-time 5
   org-confirm-babel-evaluate nil
   org-cycle-separator-lines 2
   org-edit-src-content-indentation 0
   org-list-use-circular-motion t
   org-ellipsis " ▾ "
   org-export-coding-system 'utf-8
   org-export-with-sub-superscripts nil
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
   spaceline-org-clock-p t))

;; Pre-config
(config/frames)

(config/amx)
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
(config/org-latex-preview)
(config/org-mode)
(config/projectile)
(config/python)
(config/ruby)
(config/ruby-in-buffer-eval)
(config/ruby-folding)
(config/set-terminal-emacs-theme)
(config/shell-buffers)
(config/smartparens)
(config/underscore-to-word-char-list)
(config/version-control)
(config/web-beautify)
(config/web-mode)
(config/window-splitting)
(config/yankee)
(config/yasnippet)

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

(global-set-key (kbd "s--") #'spacemacs/scale-down-font)
(global-set-key (kbd "s-0") #'spacemacs/reset-font-size)
(global-set-key (kbd "s-;") #'spacemacs/jump-to-last-layout)
(global-set-key (kbd "s-=") #'spacemacs/scale-up-font)
(global-set-key (kbd "s-F") #'avy-goto-char-timer)
(global-set-key (kbd "s-d") #'spacemacs/close-compilation-window)
(global-set-key (kbd "s-f") #'avy-goto-char-2)
(global-set-key (kbd "s-g") #'toggle-magit-status)
(global-set-key (kbd "s-k") #'spacemacs/kill-this-buffer)
(global-set-key (kbd "s-l") #'spacemacs/persp-perspectives)
(global-set-key (kbd "s-m") #'toggle-messages-window)
(global-set-key (kbd "s-n") #'toggle-notes-window)
(global-set-key (kbd "s-o") #'toggle-home-layout)
(global-set-key (kbd "s-p") #'spacemacs/helm-persp-switch-project)
(global-set-key (kbd "s-q") #'kill-buffer-and-window)
(global-set-key (kbd "s-s") #'save-buffer)
(global-set-key (kbd "s-S") #'save-some-buffers)
(global-set-key (kbd "s-t") #'shell-below-full-span)
(global-set-key (kbd "s-w") #'spacemacs/delete-window)

(with-eval-after-load 'evil
  (if (boundp 'evil-hybrid-state-map)
      (progn
        (define-key evil-hybrid-state-map (kbd "s-v") #'evil-paste-after)
        ;; disable which-key keybinding
        (define-key evil-hybrid-state-map (kbd "C-j") nil))
    (error "Failed setting evil hybrid maps")))

(defun org-insert-heading-above ()
  "Insert heading above the current one."
  (interactive)
  (move-beginning-of-line 1)
  (org-insert-heading)
  (evil-insert 1))

(defun org-insert-heading-below ()
  "Insert heading below the current one."
  (interactive)
  (move-end-of-line 1)
  (org-insert-heading)
  (evil-insert 1))

(defun org-insert-subheading-below ()
  "Insert subheading below the current one."
  (interactive)
  (move-end-of-line 1)
  (org-insert-subheading 1)
  (evil-insert 1))

;; org mode
(with-eval-after-load 'org
  (if (boundp 'org-mode-map)
      (progn
        (define-key org-mode-map (kbd "s-j") #'org-occur)
        (define-key org-mode-map (kbd "s-F") #'avy-org-goto-heading-timer)
        (define-key org-mode-map (kbd "s-r") #'avy-org-refile-as-child)
        (define-key org-mode-map (kbd "s-C-<return>") 'org-insert-heading-above)
        (define-key org-mode-map (kbd "s-<return>") #'org-insert-subheading-below)
        (define-key org-mode-map (kbd "s-S-<return>") #'org-insert-heading-below))
    (error "Failed setting org mode super-key keybindings")))

;; cycle theme
(spacemacs/set-leader-keys "T n" 'r/cycle-theme)

;; toggle debug-on-error
(spacemacs/set-leader-keys "T D" #'spacemacs/toggle-debug-on-error)

;; toggle golden ratio mode
(spacemacs/set-leader-keys "T g" #'golden-ratio)

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
(global-company-mode)
(smartparens-global-strict-mode)

;; Transparency
(setq-default dotspacemacs-active-transparency 95
              dotspacemacs-inactive-transparency 85)

;; folding
(define-key evil-normal-state-map (kbd "TAB") #'evil-toggle-fold)

(spacemacs/enable-transparency)
(add-hook 'after-make-frame-functions #'spacemacs/enable-transparency)
(beacon-mode +1)
(editorconfig-mode 1)

;; Post-config
(config/prettify-symbols)
(config/company)

(provide 'customizations)
;;; customizations.el ends here
