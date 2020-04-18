;;; funcs.el --- Summary

;;; Commentary:
;;  Custom functions used interactively or as auxiliaries

;;; Code:

;; amx

(defun amx/emacs-commands ()
  "Execute amx with a better prompt."
  (interactive)
  (let ((amx-prompt-string "Emacs commands: "))
    (amx)))

(defun amx/amx-major-mode-commands ()
  "Re-execute smex with major mode commands only."
  (interactive)
  (let ((amx-prompt-string (format "%s commands: " major-mode)))
    (amx-major-mode-commands)))

(defun spacemacs/ruby-toggle-breakpoint (&optional in-pipeline)
  "Add a break point, highlight it. Pass IN-PIPELINE to add using tap."
  (interactive (cond
                ((equal current-prefix-arg nil) (list nil))
                ((equal current-prefix-arg '(4)) (list t))))
  (let ((trace (cond (in-pipeline ".tap { |result| require \"pry\"; binding.pry }")
                     (t "require \"pry\"; binding.pry")))
        (line (thing-at-point 'line)))
    (if (and line (string-match trace line))
        (kill-whole-line)
      (progn
        (back-to-indentation)
        (indent-according-to-mode)
        (insert trace)
        (insert "\n")
        (indent-according-to-mode)))))

;; kill other buffers

(defun kob-deletable-buffer-list ()
  "Return a list of all open buffers, excluding current one.
Also exclude any buffers with names matching the pattern in
`kob-buffer-to-keep-name-pattern'."
  (interactive)

  (defvar kob-keep-buffers-named-pattern
    "company\\|scratch"
    "When deleting all buffers, keep buffers with names that match this
    pattern.")

  (remove-if
   #'(lambda (x)
       (or
        (string-match-p kob-keep-buffers-named-pattern (buffer-name x))
        (eq x (current-buffer))))
   (buffer-list)))

(defun kob-rudely ()
  "Kill other buffers, including those in other layouts.
Do not request confirmation for buffers outside the current perspective."
  (interactive)
  (if (boundp 'persp-kill-foreign-buffer-behaviour)
      (let ((original-behavior persp-kill-foreign-buffer-behaviour))
        (setq persp-kill-foreign-buffer-behaviour 'kill)
        (mapc 'kill-buffer (kob-deletable-buffer-list))
        (delete-other-windows)
        (setq persp-kill-foreign-buffer-behaviour original-behavior))
    (progn
      (mapc 'kill-buffer (kob-deletable-buffer-list))
      (delete-other-windows))))

;; layout

(defun layouts-reset ()
  "Reset to the default set of layouts."
  (interactive)
  (let ((delay 1))
    (kob-rudely)
    (sleep-for delay)
    (layouts-org)
    (sleep-for delay)
    (layouts-dotfiles)
    (sleep-for delay)
    (layouts-blog)
    (spacemacs/layout-goto-default)))

(defun layouts-org ()
  "Set up org layout."
  (interactive)
  (progn
    (spacemacs/layout-goto-default)
    (delete-other-windows)

    (let ((journal "[journal]")
          (today "[today]")
          (backlog "[backlog]"))

      ;; Kill the journal buffer, since it might need to visit a new file
      (when (get-buffer journal)
        (kill-buffer journal))

      ;; create buffers
      (find-file (expand-file-name org-default-notes-file))
      (rename-buffer today)
      (find-file (expand-file-name org-default-backlog-file))
      (rename-buffer backlog)
      (org-journal-today)
      (rename-buffer journal)
      (delete-other-windows)

      (switch-to-buffer today)
      (purpose-toggle-window-buffer-dedicated)

      (split-window-right-and-focus)
      (switch-to-buffer backlog)
      (purpose-toggle-window-buffer-dedicated)

      (split-window-below-and-focus)
      (switch-to-buffer journal)
      (purpose-toggle-window-buffer-dedicated)
      (save-buffer)

      (select-window (get-buffer-window today))
      (split-window-below-and-focus)
      (org-agenda-list)
      (purpose-toggle-window-buffer-dedicated)

      (select-window (get-buffer-window today)))))

(defun layouts-blog ()
  "Set up blog layout."
  (interactive)
  (let ((blog "blog"))
    (persp-switch blog)
    (delete-other-windows)
    (if (and (boundp 'org-default-blog-file) org-default-blog-file)
        (dired (file-name-directory (expand-file-name org-default-blog-file)))
      (error "Org blog path `org-default-blog-file' not set"))
    (rename-buffer (format "[%s]" blog))
    (writeroom-mode)))

(defun layouts-dotfiles ()
  "Set up dotfiles layout."
  (interactive)
  (let ((dotfiles "dotfiles")
        (dotfiles-dir "~/.spacemacs.d/"))
    (persp-switch dotfiles)
    (find-file dotfiles-dir)
    (delete-other-windows)
    (split-window-right-and-focus)
    (org-projectile/goto-todos)
    (rename-buffer (format "[%s]" dotfiles))
    (purpose-toggle-window-buffer-dedicated)
    (split-window-below-and-focus)
    (find-file org-default-notes-file)
    (purpose-toggle-window-buffer-dedicated)
    (enlarge-window-horizontally (-  (/ (window-body-width) 2) (window-body-width)))))

(defun message-banner (msg)
  "Print MSG banner to the messages buffer."
  (let ((template "%s [%s] %s")
        (dashes (make-string 25 ?-)))
    (message (format template dashes msg dashes))))

;; Org mode

(defun org-journal-find-location ()
  "Open today's journal entry."
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-max)))

(defun org-journal-today ()
  "Open today's journal."
  (interactive)
  (org-journal-find-location)
  (goto-char (point-max)))

(defun org-notes-open-sprint ()
  "Open the sprint file."
  (interactive)
  (if (boundp 'org-default-notes-file)
      (find-file org-default-notes-file)
    (error "No `org-default-notes-file' set")))

(defun org-notes-open-backlog ()
  "Open the backlog file."
  (interactive)
  (if (boundp 'org-default-backlog-file)
      (find-file org-default-backlog-file)
    (error "No `org-default-backlog-file' set")))

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

;; Hugo

(defun hugo-timestamp ()
  "Return a timestamp in ISO 8601 format."
  (concat
     (format-time-string "%Y-%m-%dT%T")
     ((lambda (x)
        (concat
         (substring x 0 3)
         ":"
         (substring x 3 5)))
      (format-time-string "%z"))))

(defun hugo-blog-open ()
  "Open Hugo blog, served locally using the default port, in a browser."
  (interactive)
  (progn
    (async-shell-command "open http://127.0.0.1:1313")
    (delete-window)))

(defun hugo-blog-serve ()
  "Start the hugo server."
  (interactive)
  (start-process "hugo-server" "*blog-server*" "blog-serve"))

;; Org Export: Hugo

(defun org-hugo-new-blog-capture-template ()
  "Return `org-capture' template string for new Hugo blog post.
See `org-capture-templates' for more information."
  (save-match-data
    (let ((date (format-time-string "%Y-%m-%d" (current-time)))
          (timestamp (hugo-timestamp))
          (title (read-from-minibuffer "Title: " "New Post"))
          (location (read-from-minibuffer "Location: " "New York")))
      (mapconcat #'identity
                 `(
                   ,(concat "* DRAFT " title)
                   ":PROPERTIES:"
                   ,(concat ":EXPORT_FILE_NAME: " date "-" (org-hugo-slug title))
                   ,(concat ":EXPORT_DATE: " timestamp)
                   ,(concat ":EXPORT_HUGO_CUSTOM_FRONT_MATTER: :location " location)
                   ":END:"
                   "%?\n")
                 "\n"))))

(defun org-hugo-new-marginalia-capture-template ()
  "Return `org-capture' template string for new Hugo marginalia post.
See `org-capture-templates' for more information."
  (save-match-data
    (let ((timestamp (hugo-timestamp)))
      (mapconcat #'identity
                 `(
                   ,(concat "* " timestamp)
                   ":PROPERTIES:"
                   ,(concat ":EXPORT_FILE_NAME: " (org-hugo-slug timestamp))
                   ,(concat ":EXPORT_DATE: " timestamp)
                   ":END:"
                   "%?\n")
                 "\n"))))

(defun org-hugo-new-commonplace-capture-template ()
  "Return `org-capture' template string for new Hugo commonplace post.
See `org-capture-templates' for more information."
  (save-match-data
    (let ((title (read-from-minibuffer "Title: "))
          (desc (read-from-minibuffer "Description: "))
          (author (read-from-minibuffer "Author: "))
          (source (read-from-minibuffer "Source Title: "))
          (cite (read-from-minibuffer "Citation Date: "))
          (url (read-from-minibuffer "Source URL: "))
          (timestamp (hugo-timestamp))
          (type (car (cdr  (read-multiple-choice
                            "Source Type: "
                            '((?b "book" "Book / Magazine / Film / Album")
                              (?a "article" "Article / Essay")
                              (?p "poem" "Poem")
                              (?t "tweet" "Tweet")))))))
      (mapconcat #'identity
                 `(
                   ,(concat "* DRAFT " title)
                   ":PROPERTIES:"
                   ,(concat ":EXPORT_FILE_NAME: " (org-hugo-slug title))
                   ,(concat ":EXPORT_AUTHOR: " author)
                   ,(concat ":EXPORT_DATE: " timestamp)
                   ,(concat ":EXPORT_HUGO_CUSTOM_FRONT_MATTER: "
                            ":source " source
                            " :cite " cite
                            " :type " type
                            " :sourceurl " url)
                   ,(concat ":EXPORT_DESCRIPTION: " desc)
                   ":END:"
                   "%?\n")
                 "\n"))))

(defun org-hugo-deploy ()
  "Commit and deploy hugo blog."
  nil)

;; yasnippet

(defun yas/camelcase-file-name ()
  "Camel-case the current buffer's file name."
  (interactive)
  (let ((filename
         (file-name-nondirectory (file-name-sans-extension
                                  (or (buffer-file-name)
                                      (buffer-name (current-buffer)))))))
    (mapconcat #'capitalize (split-string filename "[_\-]") "")))

(defun yas/strip (str)
  "Extract a parameter name from STR."
  (replace-regexp-in-string ":.*$" ""
   (replace-regexp-in-string "^\s+" ""
    (replace-regexp-in-string "," ""
     str))))

(defun yas/to-field-assignment (str)
  "Make 'STR' to 'self.`STR` = `STR`'."
  (format "self.%s = %s" (yas/strip str) (yas/strip str)))

(defun yas/prepend-colon (str)
  "Make `STR' to :`STR'."
  (format ":%s" (yas/strip str)))

(defun yas/indent-level ()
  "Determine the number of spaces the current line is indented."
  (interactive)
  (string-match "[^[:space:]]" (thing-at-point 'line t)))

(defun yas/indent-string ()
  "Return a string of spaces matching the current indentation level."
  (interactive)
  (make-string (yas/indent-level) ?\s))

(defun yas/indented-newline ()
  "Newline followed by correct indentation."
  (interactive)
  (format "\n%s" (yas/indent-string)))

(defun yas/args-list ()
  "Extract an args list from the current line."
  (interactive)
  (string-match "\(.+\)" (thing-at-point 'line t)))

(defun yas/to-ruby-accessors (str)
  "Splits STR into an `attr_accesor' statement."
  (interactive)
  (mapconcat 'yas/prepend-colon (split-string str ",") ", "))

(defun yas/to-ruby-setters (str)
  "Splits STR into a sequence of field assignments."
  (interactive)
  (mapconcat 'yas/to-field-assignment
             (split-string str ",")
             (yas/indented-newline)))

;; Utilities

(defun helm-select-session ()
  "Select an active Helm session."
  (interactive)
  (helm-resume 10))

(defun display-and-copy-file-path ()
  "Print the path of the current buffer's file.
Depends on yankee.el."
  (interactive)
  (let ((file-path (yankee--abbreviated-project-or-home-path-to-file)))
    (kill-new file-path)
    (message file-path)))

(defun shell-right ()
  "Open a terminal split to the right and focus it."
  (interactive)
  (let ((default-directory (project-root-or-default-dir))
        (shell-pop-full-span nil)
        (shell-pop-window-position "right")
        (shell-pop-window-size 35))
    (call-interactively #'spacemacs/shell-pop-vterm)))

(defun shell-below ()
  "Open a terminal split below and focus it."
  (interactive)
  (let ((default-directory (project-root-or-default-dir))
        (shell-pop-full-span nil)
        (shell-pop-window-position "below")
        (shell-pop-window-size 50))
    (call-interactively #'spacemacs/shell-pop-vterm)))

(defun shell-below-full-span ()
  "Open a terminal below across the full frame."
  (interactive)
  (let ((default-directory (project-root-or-default-dir))
        (shell-pop-full-span t)
        (shell-pop-window-position "below")
        (shell-pop-window-size 30))
    (call-interactively #'spacemacs/shell-pop-vterm)))

(defun shell-full ()
  "Open a terminal in the current window."
  (interactive)
  (let ((default-directory (project-root-or-default-dir))
        (shell-pop-full-span nil)
        (shell-pop-window-position "top")
        (shell-pop-window-size 100))
    (vterm)))

(defun project-root-or-default-dir ()
  "Return the projectile project root if in a project.
If not in a project, return the current `default-dir'."
  (let ((proj-root (projectile-project-root)))
    (or proj-root default-directory)))

(defun toggle-messages-window ()
  "Toggle the messages popup window."
  (interactive)
  (let ((msg-window (get-buffer-window "*Messages*")))
    (if msg-window
        (popwin:close-popup-window)
      (progn
        (popwin:messages)
        (popwin:stick-popup-window)))))

(defun toggle-home-layout ()
  "Toggle the home layout."
  (interactive)
  (if (eq dotspacemacs-default-layout-name
          (safe-persp-name (get-current-persp)))
      (spacemacs/jump-to-last-layout)
    (spacemacs/layout-goto-default)))

(defun toggle-notes-window ()
  "Toggle notes in the current window."
  (interactive)
  (let* ((notes-buf (get-buffer "*Deft*"))
         (notes-win (get-buffer-window notes-buf)))
    (cond
     ((and notes-buf notes-win)
      (progn
        (quit-window notes-win)))
     (notes-buf
      (progn
        (switch-to-buffer notes-buf)))
     (t
      (progn
        (deft)
        (goto-char (point-min))
        (evil-append-line 1))))))

(defun toggle-magit-status ()
  "Toggle the magit status window."
  (interactive)
  (if (eq 'magit-status-mode
          (buffer-local-value 'major-mode (current-buffer)))
      (magit-mode-bury-buffer)
    (magit-status-setup-buffer)))

(defun rerun-term-command-right ()
   "Re-issue previously issued command in terminal split to the right."
   (interactive)
   (evil-window-right 1)
   (evil-insert-state)
   (execute-kbd-macro (kbd "M-p"))
   (execute-kbd-macro (kbd "RET"))
   (evil-window-left 1))

(defun rerun-term-command-below ()
  "Re-issue previously issued command in a terminal split below."
  (interactive)
  (evil-window-down 1)
  (evil-insert-state)
  (execute-kbd-macro (kbd "M-p"))
  (execute-kbd-macro (kbd "RET"))
  (evil-window-up 1))

(defun r/cycle-theme ()
  "Cycle between dark and light scheme."
  (interactive)
  (if (eq r-current-theme r-dark-theme)
      (progn
        (r/light)
        (setq r-current-theme r-light-theme))
    (progn
      (r/dark)
      (setq r-current-theme r-dark-theme))))

(defun r/light ()
  "Switch to light theme."
  (interactive)
  (disable-theme r-dark-theme)
  (spacemacs/load-theme r-light-theme)
  (setq org-bullets-bullet-list '(" "))
  (r-org/reset-buffers)
  (beacon-mode -1))

(defun r/dark ()
  "Switch to dark theme."
  (interactive)
  (disable-theme r-light-theme)
  (spacemacs/load-theme r-dark-theme)
  (setq org-bullets-bullet-list '("› "))
  (r-org/reset-buffers)
  (beacon-mode +1))

(defun r-org/reset-buffers ()
  "Reset `org-mode' in all org buffers."
  (interactive)
  (dolist (buff (buffer-list))
    (with-current-buffer buff
      (if (string-equal "org-mode" major-mode)
          (org-mode)))))

(provide 'funcs)
;;; functions.el ends here
