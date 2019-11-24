;;; push-mode.el --- Insert as read-only

;;; Commentary:
;; WIP

;;; Code:
;; (define-minor-mode push-mode)

(defface push-mode-committed
  '((t :inherit default :underline "orange"))
  "Face for committed text."
  :group 'push-mode)

(defun mark-as-readonly (beg end)
  "Mark all text in buffer as readonly.
Accepts BEG and END and length of change LEN.
Leaves a space at the end for more insertion."
  (when (and (eq major-mode 'text-mode)
             (> end 1))
    (message "%s %s" beg end)
    (let ((inhibit-read-only t))
      (message (buffer-substring-no-properties (- beg 1) end))
      (if (eq " " (buffer-substring-no-properties (- beg 1) end))
          (remove-text-properties
           1 end
           '(font-lock-face push-mode-committed read-only t))
        (progn
          (put-text-property 1 end 'font-lock-face 'push-mode-committed)
          (put-text-property 1 end 'read-only t))))))

(add-hook 'text-mode-hook '(lambda ()
                             (add-to-list 'before-change-functions
                                          #'mark-as-readonly)))

(provide 'push-mode)
;;; push-mode ends here
