;;; overrides.el --- Emacs package overrides.

;;; Commentary:
;; Functions from dependencies that have to be overriden should be defined here.

;;; Code:

(with-eval-after-load 'doom-modeline-segments
  (defun doom-modeline-update-persp-name (&rest _)
    "Update perspective name in mode-line.
Overwrites doom-modeline's version to display on default layout and simplify."
    (setq doom-modeline--persp-name
          ;; Support `persp-mode', while not support `perspective'
          (when (and doom-modeline-persp-name
                     (bound-and-true-p persp-mode)
                     (fboundp 'safe-persp-name)
                     (fboundp 'get-current-persp))
            (let* ((persp (get-current-persp))
                   (name (safe-persp-name persp))
                   (face 'doom-modeline-persp-buffer-not-in-persp))
              (concat (doom-modeline-spc)
                      (propertize name 'face face)
                      (doom-modeline-spc)))))))

(with-eval-after-load 'ox-hugo
  ;; TODO: submit upstream
  (defun org-hugo-headline (headline contents info)
    "Transcode HEADLINE element into Markdown format.
CONTENTS is the headline contents.  INFO is a plist used as
a communication channel."
    (unless (org-element-property :footnote-section-p headline)
      (let* ((numbers (org-hugo--get-headline-number headline info nil))
             (loffset (string-to-number (plist-get info :hugo-level-offset))) ;"" -> 0, "0" -> 0, "1" -> 1, ..
             (level (org-export-get-relative-level headline info))
             (level-effective (+ loffset level))
             (title (org-export-data (org-element-property :title headline) info)) ;`org-export-data' required
             (todo (and (org-hugo--plist-get-true-p info :with-todo-keywords)
                        (org-element-property :todo-keyword headline)))
             (todo-fmtd (when todo
                          (concat (org-hugo--todo todo info) " ")))
             (tags (and (org-hugo--plist-get-true-p info :with-tags)
                        (let ((tag-list (org-export-get-tags headline info)))
                          (and tag-list
                               (format "     :%s:"
                                       (mapconcat #'identity tag-list ":"))))))
             (priority
              (and (org-hugo--plist-get-true-p info :with-priority)
                   (let ((char (org-element-property :priority headline)))
                     (and char (format "[#%c] " char)))))
             (style (plist-get info :md-headline-style)))
        ;; (message "[ox-hugo-headline DBG] num: %s" numbers)
        (cond
         ;; Cannot create a headline.  Fall-back to a list.
         ((or (org-export-low-level-p headline info)
              (not (memq style '(atx setext)))
              (and (eq style 'atx) (> level-effective 6))
              (and (eq style 'setext) (> level-effective 2)))
          (let ((bullet
                 (if (not (org-export-numbered-headline-p headline info)) "-"
                   (concat (number-to-string
                            (car (last (org-export-get-headline-number
                                        headline info))))
                           ".")))
                (heading (concat todo-fmtd " " priority title))) ;Headline text without tags
            (concat bullet (make-string (- 4 (length bullet)) ?\s) heading tags "\n\n"
                    (and contents (replace-regexp-in-string "^" "    " contents)))))
         (t
          (let* ((anchor (format "{#%s}" ;https://gohugo.io/extras/crossreferences/
                                 (org-hugo--get-anchor headline info)))
                 (headline-title (org-hugo--headline-title style level loffset title todo-fmtd "" ""))
                 (content-str (or (org-string-nw-p contents) "")))
            (format "%s%s" headline-title content-str))))))))

(provide 'overrides)
;;; overrides.el ends here
