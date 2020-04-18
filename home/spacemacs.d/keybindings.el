;;; keybindings.el --- Summary

;;; Commentary:

;;; Code:
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

;; capture / notes
(spacemacs/set-leader-keys
  "C RET" #'org-capture
  "C n" #'spacemacs/deft
  "C f" #'deft-find-file
  "C s" #'org-notes-open-sprint
  "C b" #'org-notes-open-backlog)
(spacemacs/set-leader-keys-for-major-mode 'deft-mode
  "g" #'deft-refresh)

;; hide-and-show mode
(spacemacs/declare-prefix "H" "Hide/Show")
(spacemacs/set-leader-keys
  "H a" #'hs-hide-all
  "H A" #'hs-show-all
  "H b" #'hs-hide-block
  "H B" #'hs-show-block
  "H l" #'hs-hide-level
  "H L" #'hs-show-level
  "H r" #'hs-hide-level-recursive)

;; cycle theme
(spacemacs/set-leader-keys "T n" 'r/cycle-theme)

;; toggle debug-on-error
(spacemacs/set-leader-keys "T D" #'spacemacs/toggle-debug-on-error)

;; toggle golden ratio mode
(spacemacs/set-leader-keys "T g" #'golden-ratio)

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

;; folding
(define-key evil-normal-state-map (kbd "TAB") #'evil-toggle-fold)

;; select from helm sessions
(spacemacs/set-leader-keys "r L" #'helm-select-session)

;; spacemacs buffer
(defun add-spacemacs-buffer-keybindings ()
  "Set keybindings for spacemacs buffer."
  (define-key spacemacs-buffer-mode-map (kbd "gr") #'(lambda () (interactive) (search-forward "Recent Files:")))
  (define-key spacemacs-buffer-mode-map (kbd "gp") #'(lambda () (interactive) (search-forward "Projects:")))
  (define-key spacemacs-buffer-mode-map (kbd "gb") #'(lambda () (interactive) (search-forward "Bookmarks:")))
  (define-key spacemacs-buffer-mode-map (kbd "ga") #'(lambda () (interactive) (search-forward "Agenda:"))))
(add-hook 'spacemacs-buffer-mode-hook #'add-spacemacs-buffer-keybindings)

(provide 'keybindings)
;;; keybindings.el ends here
