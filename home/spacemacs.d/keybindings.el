;;; keybindings.el --- Summary

;;; Commentary:

;;; Code:


;;; Super/Hyper: Global

(global-set-key (kbd "s--") #'spacemacs/scale-down-font)
(global-set-key (kbd "s-0") #'spacemacs/reset-font-size)
(global-set-key (kbd "s-;") #'spacemacs/jump-to-last-layout)
(global-set-key (kbd "s-=") #'spacemacs/scale-up-font)
(global-set-key (kbd "s-c") #'org-clock-in)
(global-set-key (kbd "s-C") #'org-clock-out)
(global-set-key (kbd "s-d") #'spacemacs/close-compilation-window)
(global-set-key (kbd "s-f") #'avy-goto-char-2)
(global-set-key (kbd "s-F") #'avy-goto-char-timer)
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
(global-set-key (kbd "s-T") #'toggle-todos)
(global-set-key (kbd "s-w") #'spacemacs/delete-window)



;;; Super/Hyper: Mode-specific

;; markdown
(with-eval-after-load 'markdown
  (define-key markdown-mode-map (kbd "C-j") #'markdown-next-visible-heading)
  (define-key markdown-mode-map (kbd "C-k") #'markdown-previous-visible-heading))



;;; Leaders: Global

;; hide-and-show mode
(spacemacs/declare-prefix "H" "Hide/Show")
(spacemacs/set-leader-keys
  "H" nil
  "H a" #'hs-hide-all
  "H A" #'hs-show-all
  "H b" #'hs-hide-block
  "H B" #'hs-show-block
  "H l" #'hs-hide-level
  "H L" #'hs-hide-level-recursive)

;; layouts
(spacemacs/declare-prefix "L" "layouts")
(spacemacs/set-leader-keys
  "L" nil
  "L r" #'layouts-reset
  "L b" #'layouts-blog
  "L o" #'layouts-org
  "L d" #'layouts-dotfiles)

;; org-journal
(spacemacs/declare-prefix "a j" "org-journal")
(spacemacs/set-leader-keys
  "a j" nil
  "a j ." #'spacemacs/org-journal-transient-state/body
  "a j RET" #'org-journal-new-entry
  "a j t" #'org-journal-today
  "a j s" #'org-journal-search
  "a j f" #'org-journal-search-forever
  "a j d" #'org-journal-new-date-entry)

(spacemacs/set-leader-keys
  ;; ido-dired: replace dired
  "a d" #'ido-dired
  ;; shell window additions
  "a s f" #'shell-full
  "a s r" #'shell-right
  "a s b" #'shell-below
  "\'" #'shell-below-full-span
  ;; capture / notes additions
  "C RET" #'org-capture
  "C n" #'spacemacs/deft
  "C f" #'deft-find-file
  "C s" #'org-notes-open-sprint
  "C b" #'org-notes-open-backlog
  ;; leader-fp to open file at point
  "f p" #'find-file-at-point
  ;; replace projectile-copy-file-path
  "f y Y" #'display-and-copy-file-path
  ;; magit: changes or create branch
  "g b" #'magit-branch-or-checkout
  ;; magit: git blame
  "g B" #'spacemacs/git-blame-micro-state
  ;; Helpful for interactive functions
  "h d i" #'helpful-command
  ;; insert emoji as unicode
  "i e" #'emojify-insert-emoji
  ;; helm: select search from across all sessions
  "r L" #'helm-select-session
  ;; toggles
  "T n" #'r/cycle-theme
  "T D" #'spacemacs/toggle-debug-on-error
  "T g" #'golden-ratio
  ;; window splitting: swap these around to change defaults
  "w s" #'split-window-below-and-focus
  "w S" #'split-window-below
  "w v" #'split-window-right-and-focus
  "w V" #'split-window-right
  ;; Google translate: addition
  "x g t" #'google-translate-smooth-translate)



;;; Leaders: Mode-specific

(spacemacs/set-leader-keys-for-major-mode
  'deft-mode
  "g" #'deft-refresh)

(spacemacs/set-leader-keys-for-major-mode
  'json-mode
  "=" #'json-pretty-print-buffer)

;; latex / xelatex
(spacemacs/declare-prefix-for-mode
  'latex-mode "C" "compile")
(spacemacs/set-leader-keys-for-major-mode
  'latex-mode
  "C" nil
  "C RET" #'XeLaTeX-compile
  "C r" #'XeLaTeX-compile-resume)

(spacemacs/set-leader-keys-for-major-mode
  'org-journal-mode
  "s" #'org-journal-search
  "t" #'org-journal-today)

(spacemacs/set-leader-keys-for-major-mode
  'ruby-mode
  ;; add rufo to formatting keybindings
  "= =" #'rufo-format-buffer
  ;; toggle breakpoint: C-u to insert in pipeline style
  "d b" #'spacemacs/ruby-toggle-breakpoint)



;;; Emacs style: Mode-specific

;; vterm
(with-eval-after-load 'vterm
  (define-key vterm-mode-map (kbd "C-y") #'vterm-send-C-y)
  (define-key vterm-mode-map (kbd "C-d") #'vterm-send-C-d))

;; ruby
(define-key ruby-mode-map (kbd "C-c C-c") #'xmpfilter-eval-current-line)
(define-key ruby-mode-map (kbd "C-c C-v") #'seeing-is-believing-clear)
(define-key ruby-mode-map (kbd "C-c C-f") #'seeing-is-believing-run)



;;; Evil mode: Global

;; paste in hybrid state
(define-key evil-hybrid-state-map (kbd "s-v") #'evil-paste-after)

;; amx
(define-key evil-visual-state-map (kbd ", :") #'amx/amx-major-mode-commands)
(define-key evil-normal-state-map (kbd ", :") #'amx/amx-major-mode-commands)

;; ex buffers: Emacs bindings in Evil ex minibuffer.
(define-key evil-ex-completion-map (kbd "C-b") 'backward-char)
(define-key evil-ex-completion-map (kbd "C-k") 'kill-line)
(define-key evil-ex-completion-map (kbd "C-a") 'beginning-of-line)

;; evil-lion: align (e.g.: gaip=, gaip/)
(define-key evil-normal-state-map (kbd "g a") #'evil-lion-left)
(define-key evil-normal-state-map (kbd "g A") #'evil-lion-right)
(define-key evil-visual-state-map (kbd "g a") #'evil-lion-left)
(define-key evil-visual-state-map (kbd "g A") #'evil-lion-right)

;; yankee.el
(require 'yankee)
(define-key evil-visual-state-map (kbd "g y") #'yankee-yank)
(define-key evil-visual-state-map (kbd "C-\\") #'yankee-yank)

;; yasnippet
(with-eval-after-load 'yasnippet
  (define-key evil-hybrid-state-map (kbd "C-;") #'company-yasnippet)
  (define-key evil-hybrid-state-map (kbd "TAB") yas-maybe-expand))



;;; Evil mode: Mode-specific

;; prog-mode: code folding with tab
(defun tab-to-fold-in-normal-state ()
  "Bind toggle-fold function to the <tab> key."
  (evil-local-set-key 'normal (kbd "<tab>") #'evil-toggle-fold))
(add-hook 'prog-mode-hook #'tab-to-fold-in-normal-state)

;; rjsx-mode
(defun rjsx-hybrid-keybindings ()
  "Bind ctrl-d to `rjsx-delete-creates-full-tag'."
  (evil-local-set-key 'hybrid (kbd "C-d") #'rjsx-delete-creates-full-tag))
(add-hook 'rjsx-mode-hook #'rjsx-hybrid-keybindings)



;;; Spacemacs buffer

(define-key spacemacs-buffer-mode-map (kbd "g r") #'spacemacs-buffer-recents)
(define-key spacemacs-buffer-mode-map (kbd "g p") #'spacemacs-buffer-projects)
(define-key spacemacs-buffer-mode-map (kbd "g b") #'spacemacs-buffer-bookmarks)
(define-key spacemacs-buffer-mode-map (kbd "g a") #'spacemacs-buffer-agenda)



;;; Org mode

(with-eval-after-load 'org
  (if (boundp 'org-mode-map)
      (progn
        (define-key org-mode-map (kbd "s-j") #'org-occur)
        (define-key org-mode-map (kbd "s-F") #'avy-org-goto-heading-timer)
        (define-key org-mode-map (kbd "s-r") #'avy-org-refile-as-child)
        (define-key org-mode-map (kbd "s-C-<return>") 'org-insert-heading-above)
        (define-key org-mode-map (kbd "s-S-<return>") #'org-insert-subheading-below)
        (define-key org-mode-map (kbd "s-<return>") #'org-insert-heading-below))
    (error "Failed setting org mode super-key keybindings")))

(provide 'keybindings)
;;; keybindings.el ends here
