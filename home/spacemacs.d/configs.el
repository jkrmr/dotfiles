;;; configs.el --- Emacs configuration functions.

;;; Commentary:
;; Functions invoked from setup.el
;; Defined separately to facilitate isolated and granular debugging.

;;; Code:
(defun config/company ()
  "Configure company auto-completion mode."
  (with-eval-after-load 'company
    (if (boundp 'company-backends)
        (progn
          (add-to-list 'company-backends '(company-bbdb :with company-yasnippet))
          (add-to-list 'company-backends '(company-clang :with company-yasnippet))
          (add-to-list 'company-backends '(company-cmake :with company-yasnippet))
          (add-to-list 'company-backends '(company-eclim :with company-yasnippet))
          (add-to-list 'company-backends '(company-oddmuse :with company-yasnippet))
          (add-to-list 'company-backends '(company-xcode :with company-yasnippet))
          (add-to-list 'company-backends '(company-capf :with company-keywords company-yasnippet))
          (add-to-list 'company-backends '(company-robe :with company-keywords company-gtags company-capf company-yasnippet))
          (add-to-list 'company-backends '(company-anaconda :with company-keywords company-jedi company-capf company-yasnippet))
          (add-to-list 'company-backends '(company-gtags :with company-keywords company-capf company-yasnippet))
          (message-banner "backends added"))
      (error "Could not add to `company-backends'"))
    (if (boundp 'company-active-map)
        (progn
          (define-key company-active-map (kbd "C-h") #'company-show-doc-buffer)
          (define-key company-active-map (kbd "C-w") #'company-show-location)
          (define-key company-active-map (kbd "C-r") #'company-search-candidates)
          (define-key company-active-map (kbd "C-f") #'company-filter-candidates)
          (define-key company-active-map [return] #'company-complete-selection)
          (define-key company-active-map (kbd "RET") #'company-complete-selection)
          (define-key company-active-map [tab] #'company-complete-selection)
          (define-key company-active-map (kbd "TAB") #'company-complete-selection)
          (define-key company-active-map [backtab] #'spacemacs//company-complete-common-or-cycle-backward)
          (define-key company-active-map (kbd "S-TAB") #'spacemacs//company-complete-common-or-cycle-backward)
          (message-banner "company map set"))
      (error "Could not define `company-active-map' keybindings"))))

(defun config/flycheck ()
  "Configure and enable Flycheck."
  ;; (with-eval-after-load 'flycheck
  ;;   (with-eval-after-load 'lsp-mode
  ;;     ;; Flycheck: Python
  ;;     (flycheck-add-next-checker 'lsp 'python-flake8)
  ;;     (flycheck-add-next-checker 'lsp 'python-mypy)
  ;;     (flycheck-add-next-checker 'lsp 'python-pylint)

  ;;     ;; Flycheck: JavaScript, TypeScript
  ;;     (flycheck-add-next-checker 'lsp 'javascript-standard)

  ;;     ;; Flycheck: Ruby
  ;;     (flycheck-add-next-checker 'lsp 'ruby-rubocop)))
  ;; Enable eagerly in all programming buffers
  (add-hook 'prog-mode-hook #'flycheck-mode))

(defun config/highlight-lines-at-length (chars)
  "Configure and enable whitespace mode to color text after CHARS chars."
  (setq-default whitespace-line-column chars
                whitespace-style '(face lines-tail empty tabs))
  ;; Enable excess length highlighting in prog-mode
  (add-hook 'prog-mode-hook #'whitespace-mode)
  (add-hook 'org-mode-hook #'whitespace-mode)

  ;; Manually set trailing whitespace cleanup
  ;; (workaround, since the preceding breaks whitespace-cleanup,
  ;; which `dotspacemacs-whitespace-cleanup 'all' uses.)
  (add-hook 'before-save-hook #'delete-trailing-whitespace))

(defun config/javascript-modes ()
  "Configure JavaScript modes: js, js2, react."
  (with-eval-after-load 'web-mode
    (if (boundp 'web-mode-indentation-params)
        (progn
          (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
          (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
          (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))
      (error "Failed setting up js-modes indentation params"))))

(defun config/latex-mode ()
  "Configure LaTeX mode."
  ;; Update preview when file changes
  (add-hook 'doc-view-mode-hook 'auto-revert-mode)
  ;; Detect xelatex files
  (add-to-list 'auto-mode-alist '("\\.xtx\\'" . LaTeX-mode)))

(defun config/lisps ()
  "Configure Lisp modes."
  ;; evil-cleverparens
  (require 'evil-cleverparens-text-objects)
  (spacemacs/toggle-evil-safe-lisp-structural-editing-on-register-hooks)

  (defun lisp-minor-modes ()
    "Enable Lisp minor modes, in the correct sequence."
    (parinfer-mode)
    (evil-cleverparens-mode))
  (remove-hook 'emacs-lisp-mode-hook #'parinfer-mode)
  (add-hook 'clojure-mode-hook #'lisp-minor-modes)
  (add-hook 'emacs-lisp-mode-hook #'lisp-minor-modes))

(defun config/org-mode ()
  "Configure and enable org mode."
  (with-eval-after-load 'org-agenda
    (require 'org-projectile)
    ;; Place tags close to the right-hand side of the window
    (defun place-agenda-tags ()
      "Put the agenda tags by the right border of the agenda window."
      (setq-default org-agenda-tags-column (- 4 (window-width)))
      (org-agenda-align-tags))
    (add-hook 'org-finalize-agenda-hook #'place-agenda-tags))

  (with-eval-after-load 'org-projectile
    ;; programmatically determine the todo-file name for the current project.
    ;; `org-projectile-per-project-filepath' must be set here
    (setq-default org-projectile-per-project-filepath
                  #'org-projectile-project-todo-file-name))

  (with-eval-after-load 'org
    ;; mode hooks
    (add-hook 'org-mode-hook #'variable-pitch-mode)
    (add-hook 'org-journal-mode-hook #'org-mode)
    (add-hook 'org-capture-mode-hook #'org-align-tags)
    ;; save clocks
    (org-clock-persistence-insinuate)

    ;; Capture templates
    (setq-default
     org-capture-templates
     '(("t" "Todo (general)" entry (file+headline org-default-notes-file "Captures")
        "** TODO %?\n%U" :empty-lines 0 :prepend t)
       ("d" "Todo (for development environment)" entry (file+headline "dotfiles.org" "Captures")
        "** TODO %?\n%U" :empty-lines 0 :prepend t)
       ("p" "Todo (for a project)" entry (function org-projectile-project-capture)
        "** TODO %?\n%U" :empty-lines 0 :prepend t)
       ("c" "Commonplace" entry (file+headline "blog/commonplaces.org" "Commonplaces")
        (function org-hugo-new-commonplace-capture-template) :empty-lines 1 :prepend t)
       ("m" "Marginalia" entry (file+headline "blog/marginalia.org" "Marginalia")
        (function org-hugo-new-marginalia-capture-template) :empty-lines 1 :prepend t)
       ("s" "Standup" plain (file+olp+datetree "STANDUP.org")
        "     %?")
       ("r" "Reference" entry (file+headline org-default-backlog-file "Captures")
        "** %?\n%a\n%U" :empty-lines 1)
       ("n" "Notes" entry (file+headline "blog/notes.org" "Notes")
        (function org-hugo-new-blog-capture-template) :empty-lines 1 :prepend t)
       ("b" "Blog Post" entry (file+headline "blog/blog.org" "Blog")
        (function org-hugo-new-blog-capture-template) :empty-lines 1 :prepend t)
       ("h" "Health journal" entry (file+olp+datetree "HEALTH.org")
        "**** [%<%l:%M %p>] %^{Entry} %^g" :immediate-finish t)
       ("j" "Journal entry" plain (function org-journal-find-location)
        "** %(format-time-string org-journal-time-format)%^{Title}\n%i%?" :empty-lines 1)
       ("v" "Paste from clipboard" entry (file+headline org-default-backlog-file "Captures")
        "** %^{Title} %^G\n%?\n%c")))

    ;; Org Babel languages
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((clojure . t)
       (dot . t)
       (elixir . t)
       (emacs-lisp . t)
       (haskell . t)
       (js . t)
       (org . t)
       (python . t)
       (ruby . t)
       (shell . t)))

    (setq-default
     org-structure-template-alist
     '(("a" . "export ascii")
       ("c" . "center")
       ("C" . "comment")
       ("e" . "example")
       ("E" . "export")
       ("h" . "export html")
       ("l" . "export latex")
       ("n" . "export notes")
       ("q" . "quote")
       ("s" . "src")
       ("sp" . "src python")
       ("se" . "src elixir")
       ("sr" . "src ruby")
       ("sj" . "src js")
       ("v" . "verse")))))

(defun config/org-latex-preview ()
  "Configure LaTeX preview settings for Org mode."
  (with-eval-after-load 'org
    (if (boundp 'org-format-latex-options)
        (progn
          (setq org-format-latex-options
                (plist-put org-format-latex-options :justify 'center))
          (setq org-format-latex-options
                (plist-put org-format-latex-options :scale 1.5))))

    (defun org-justify-fragment-overlay (beg end image imagetype)
      "Adjust the justification of a LaTeX fragment.
The justification is set by :justify in `org-format-latex-options'.
Only equations at the beginning of a line are justified."
      (setq-default org-format-latex-header "\\documentclass[reqno]{article}
\\usepackage[usenames]{color}
[PACKAGES]
[DEFAULT-PACKAGES]
\\pagestyle{empty}
% do not remove
% The settings below are copied from fullpage.sty
\\setlength{\\textwidth}{\\paperwidth}
\\addtolength{\\textwidth}{-16cm}
\\setlength{\\oddsidemargin}{1.5cm}
\\addtolength{\\oddsidemargin}{-2.54cm}
\\setlength{\\evensidemargin}{\\oddsidemargin}
\\setlength{\\textheight}{\\paperheight}
\\addtolength{\\textheight}{-\\headheight}
\\addtolength{\\textheight}{-\\headsep}
\\addtolength{\\textheight}{-\\footskip}
\\addtolength{\\textheight}{-3cm}
\\setlength{\\topmargin}{1.5cm}
\\addtolength{\\topmargin}{-2.54cm}")

      (require 'ov)
      (cond
       ;; Centered justification
       ((and (eq 'center (plist-get org-format-latex-options :justify))
             (= beg (line-beginning-position)))
        (let* ((img (create-image image 'imagemagick t))
               (width (car (image-size img)))
               (offset (floor (- (/ 40 2) (/ width 2)))))
          (overlay-put (ov-at) 'before-string (make-string offset ?\s))))
       ;; Right justification
       ((and (eq 'right (plist-get org-format-latex-options :justify))
             (= beg (line-beginning-position)))
        (let* ((img (create-image image 'imagemagick t))
               (width (car (image-display-size (overlay-get (ov-at) 'display))))
               (offset (floor (- 40 width (- (line-end-position) end)))))
          (overlay-put (ov-at) 'before-string (make-string offset ?\s))))))
    (advice-add 'org--format-latex-make-overlay :after #'org-justify-fragment-overlay)))

(defun config/prettify-symbols ()
  "Enable and configure prettify-symbols mode and pretty mode."
  ;; pretty-mode
  (require 'pretty-mode)
  (global-pretty-mode t)

  (pretty-deactivate-groups '(:equality :ordering :ordering-double :arrows
                                        :ordering-triple :arrows-twoheaded
                                        :punctuation :logic :sets))

  (pretty-activate-groups '(:greek :arithmetic-nary))

  ;; prettify symbols
  (global-prettify-symbols-mode)

  ;; prettify symbols: Python
  (defun prettify-symbols-python ()
    "Provide prettify-symbol mode mappings for python-mode."
    (mapc (lambda (pair) (push pair prettify-symbols-alist))
          '(("def" .    #x0192)
            ("in" .     #x2208)
            ("is" .     #x2261)
            ("is not" . #x2262)
            ("not in" . #x2209)
            ("all" .    #x2200)
            ("any" .    #x2203))))
  (add-hook 'python-mode-hook #'prettify-symbols-python)

  ;; prettify symbols: Emacs Lisp
  (defun prettify-symbols-emacs-lisp ()
    "Provide prettify-symbol mode mappings for emacs-lisp-mode."
    (mapc (lambda (pair) (push pair prettify-symbols-alist))
          '(("defun" .  #x0192))))
  (add-hook 'emacs-lisp-mode-hook #'prettify-symbols-emacs-lisp)

  ;; prettify symbols: Elixir
  (defun prettify-symbols-elixir()
    "Provide prettify-symbol mode mappings for elixir-mode."
    (mapc (lambda (pair) (push pair prettify-symbols-alist))
          '(("def" .  #x0192)
            ("defp" .  #x0070)
            ("defmodule" . #x006D)
            ("fn" . #x03BB))))
  (add-hook 'elixir-mode-hook #'prettify-symbols-elixir)

  ;; prettify symbols: JavaScript
  (defun prettify-symbols-javascript ()
    "Provide prettify-symbol mode mappings for javascript modes."
    (mapc (lambda (pair) (push pair prettify-symbols-alist))
          '(("function" .  #x0192))))
  (add-hook 'js2-mode-hook #'prettify-symbols-javascript))

(defun config/python ()
  "Configure python and related modes."
  (let* ((conda-path (format "%s/.anaconda" (getenv "HOME")))
         (python-path (format "%s/bin" conda-path)))
    (setenv "WORKON_HOME" (format "%s/envs" conda-path))
    (setq-default conda-anaconda-home conda-path))

  ;; (add-hook 'python-mode-hook #'elpy-enable)
  (add-hook 'python-mode-hook #'anaconda-mode)
  (add-hook 'python-mode-hook #'anaconda-eldoc-mode)
  (add-hook 'python-mode-hook #'evil-text-object-python-add-bindings))

(defun config/ruby ()
  "Configure packages for Ruby mode."
  (defun switch-to-rspec-compilation-buffer ()
    "Switch to the RSpec compilation buffer."
    (switch-to-buffer "*rspec-compilation*"))

  (eval-after-load 'evil-mode
    (require 'evil-rails))

  ;; Enable pry in test runs
  (add-hook 'compilation-filter-hook 'inf-ruby-auto-enter))

(defun config/shell-buffers ()
  "Configure shell buffers."
  ;; Use utf8
  (defun term-use-utf8 ()
    (set-process-coding-system 'utf-8-unix 'utf-8-unix))
  (add-hook 'term-exec-hook #'term-use-utf8)
  ;; ansi-term: always use default shell
  (defadvice ansi-term (before force-bash)
    (interactive (list shell-default-term-shell)))
  (ad-activate #'ansi-term))

(defun config/add-to-word-char-list ()
  "Add underscore to word char list in prog and other modes."
  (defun add-underscore-to-word-chars ()
    "Adds underscore to the word chars syntax entry list."
    (modify-syntax-entry ?_ "w"))
  (defun add-dash-to-word-chars ()
    "Adds underscore to the word chars syntax entry list."
    (modify-syntax-entry ?- "w"))
  (add-hook 'emacs-lisp-mode-hook #'add-dash-to-word-chars)
  (add-hook 'markdown-mode-hook #'add-underscore-to-word-chars)
  (add-hook 'org-mode-hook #'add-underscore-to-word-chars)
  (add-hook 'prog-mode-hook #'add-underscore-to-word-chars)
  (add-hook 'python-mode-hook #'add-underscore-to-word-chars)
  (add-hook 'restclient-mode-hook #'add-underscore-to-word-chars)
  (add-hook 'text-mode-hook #'add-underscore-to-word-chars))

(defun config/web-mode ()
  "Configure web-mode (for CSS, HTML)."
  (with-eval-after-load 'web-mode
    (if (boundp 'web-mode-indentation-params)
        (progn
          (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
          (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
          (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))
      (error "Failed setting up web-mode indentation params"))))

(provide 'configs)
;;; configs.el ends here
