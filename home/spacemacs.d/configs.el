;;; configs.el --- Emacs configuration functions.

;;; Commentary:
;; Functions invoked from setup.el
;; Defined separately to facilitate isolated and granular debugging.

;;; Code:
(defun config/load-local-config ()
  "Load local configuration overrides."
  (load "~/.init.local.el"))

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
          (add-to-list 'company-backends '(company-tern :with company-keywords company-capf company-yasnippet))
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

(defun config/compilation-buffers ()
  "Configure compilation buffer settings."
  (defun compilation-mode-settings ()
    ;; wrap lines in compilation buffer
    ;; (setq truncate-lines t)
    (add-hook 'compilation-mode-hook
              (lambda () (font-lock-mode -1)))
    (set (make-local-variable 'truncate-partial-width-windows) nil))
  (add-hook 'compilation-mode-hook #'compilation-mode-settings))

(defun config/copy-as-format ()
  "Configure copy-as-format."
  (setq-default
   copy-as-format-asciidoc-include-file-name t
   copy-as-format-default "github"))

(defun config/elixir ()
  "Configure Elixir mode."
  (projectile-register-project-type 'elixir-mix '("mix.exs")
                                    :compile "mix compile"
                                    :test "mix test"
                                    :test-suffix "_test")
  (defun elixir-format-buffer ()
    (interactive)
    (shell-command-on-region
     (point-min) (point-max)
     (format "mix format %s" (buffer-file-name))))

  ;; mix-format interface
  (defun elixir-after-save-hooks ()
    (if (eq major-mode 'elixir-mode)
        (elixir-format-buffer)))
  (add-hook 'after-save-hook #'elixir-after-save-hooks))

(defun config/elm ()
  "Configure Elm."
  (with-eval-after-load 'elm-mode
    (remove-hook 'elm-mode-hook 'elm-indent-mode)))

(defun config/evil-collection ()
  "Enable evil keybindings everywhere."
  (setq-default
   evil-collection-outline-bind-tab-p t
   evil-collection-term-sync-state-and-mode-p t
   evil-collection-setup-minibuffer t
   evil-collection-setup-debugger-keys t)

  ;; load init evil-collection after loading evil
  (when (require 'evil-collection nil t)
    (evil-collection-init)))

(defun config/evil-goggles ()
  "Configure evil-goggles."
  (setq-default evil-goggles-pulse nil
                evil-goggles-duration 0.7)
  (evil-goggles-mode)
  (evil-goggles-use-diff-refine-faces))

(defun config/flycheck ()
  "Configure and enable Flycheck."
  ;; Ruby
  (defun set-ruby-flycheck-checkers ()
    "Set Flycheck checkers for Ruby."
    (flycheck-add-next-checker 'lsp 'ruby-rubocop)
    (flycheck-add-next-checker 'ruby-rubocop 'ruby-reek))

  ;; Python
  (defun set-python-flycheck-checkers ()
    "Set Flycheck checkers for Python."
    (flycheck-add-next-checker 'lsp 'python-flake8)
    (flycheck-add-next-checker 'python-flake8 'python-mypy)
    (flycheck-add-next-checker 'python-mypy 'python-pylint))

  (with-eval-after-load 'lsp-mode
    (add-hook 'ruby-mode-hook #'set-ruby-flycheck-checkers)
    (add-hook 'python-mode-hook #'set-python-flycheck-checkers))

  ;; Enable eagerly in all programming buffers
  (add-hook 'prog-mode-hook #'flycheck-mode))

(defun config/google-translate ()
  "Configure google-translate."
  (setq-default google-translate-backend-method 'curl
                ;; 'popup 'kill-ring 'current-buffer
                google-translate-output-destination 'current-buffer
                google-translate-pop-up-buffer-set-focus t
                google-translate-translation-directions-alist '(("en" . "es")
                                                                ("en" . "fr")
                                                                ("en" . "nl"))))

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

  ;; Lisp modes
  (defun add-lisp-modes-hook (func)
    "Add FUNC as a hook to each of the major Lisp major modes."
    (progn
      (add-hook 'clojure-mode-hook func)
      (add-hook 'scheme-mode-hook func)
      (add-hook 'emacs-lisp-mode-hook func)))

  ;; Lisp minor modes
  (defun lisp-packages ()
    "Enable Lisp minor modes, in the correct sequence."
    (progn
      (parinfer-mode)
      (evil-cleverparens-mode)))

  (remove-hook 'emacs-lisp-mode-hook #'parinfer-mode)
  (add-lisp-modes-hook #'lisp-packages))

(defun config/modeline ()
  "Configure the modeline."
  ;; doom-modeline
  (setq-default
   doom-modeline-buffer-file-name-style 'truncate-with-project
   doom-modeline-buffer-modification-icon t
   doom-modeline-buffer-state-icon t
   doom-modeline-enable-word-count t
   doom-modeline-env-command nil
   doom-modeline-evil-state-icon t
   doom-modeline-github t
   doom-modeline-icon (display-graphic-p)
   doom-modeline-lsp t
   doom-modeline-major-mode-color-icon t
   doom-modeline-major-mode-icon t
   doom-modeline-minor-modes nil
   doom-modeline-persp-name t
   doom-modeline-project-detection 'project
   doom-modeline-version t)

  (defun enable-doom-modeline-in-messages ()
    "Enable doom-modeline in messages buffer."
    (let ((msg-window (get-buffer-window "*Messages*")))
      (if msg-window
          (with-current-buffer (window-buffer msg-window)
            (doom-modeline-set-main-modeline)))))
  (add-hook 'post-command-hook #'enable-doom-modeline-in-messages)

  (doom-modeline-set-modeline 'main t)
  (doom-modeline-mode))

(defun config/org-mode ()
  "Configure and enable org mode."
  (with-eval-after-load 'org-agenda
    (require 'org-projectile)
    (if (boundp 'org-agenda-files)
        (mapc
         #'(lambda (file)
             (when (file-exists-p file)
               (push file org-agenda-files)))
         (org-projectile-todo-files))
      (error "Failed: 'org-agenda-files not bound")))

  (with-eval-after-load 'org
    ;; mode hooks
    (add-hook 'org-mode-hook #'variable-pitch-mode)
    (add-hook 'org-journal-mode-hook #'org-mode)
    (add-hook 'org-capture-mode-hook #'org-align-tags)

    ;; Save clocks
    (org-clock-persistence-insinuate)

    ;; Journal
    (spacemacs|define-transient-state org-journal
      :title "Org Journal Transient State"
      :hint nil
      :foreign-keys run
      :doc
      "\n[_p_/_N_] previous [_n_] next [_c_] current [_s_] search all [_f_] search future [_S_] search range [_q_] quit"
      :bindings
      ("p" org-journal-open-previous-entry)
      ("N" org-journal-open-previous-entry)
      ("n" org-journal-open-next-entry)
      ("c" org-journal-today)
      ("s" org-journal-search-forever)
      ("f" org-journal-search-future)
      ("S" org-journal-search)
      ("q" nil :exit t))

    ;; Capture templates
    (setq-default
     org-capture-templates
     '(("t" "Todo" entry (file+headline org-default-backlog-file "Captures")
        "** %?\n%U" :empty-lines 1)
       ("c" "Commonplace" entry (file+headline "blog/commonplaces.org" "Commonplaces")
        (function org-hugo-new-commonplace-capture-template) :empty-lines 1 :prepend t)
       ("m" "Marginalia" entry (file+headline "blog/marginalia.org" "Marginalia")
        (function org-hugo-new-marginalia-capture-template) :empty-lines 1 :prepend t)
       ("s" "Standup" plain (file+olp+datetree "~/Dropbox/org/STANDUP.org")
        "     %?")
       ("r" "Reference" entry (file+headline org-default-backlog-file "Captures")
        "** %?\n%a\n%U" :empty-lines 1)
       ("n" "Notes" entry (file+headline "blog/notes.org" "Notes")
        (function org-hugo-new-blog-capture-template) :empty-lines 1 :prepend t)
       ("p" "Blog Post" entry (file+headline "blog/blog.org" "Blog")
        (function org-hugo-new-blog-capture-template) :empty-lines 1 :prepend t)
       ("h" "Health journal" entry (file+olp+datetree "~/Dropbox/org/HEALTH.org")
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

(defun config/projectile ()
  "Configure Projectile."
  (setq-default projectile-completion-system 'helm
                projectile-enable-caching t
                projectile-find-dir-includes-top-level t
                projectile-project-search-path '("~/Projects" "~/Work" "~/Resources" "~/Exercism"))

  (if (bound-and-true-p projectile-globally-ignored-directories)
      (setq-default projectile-globally-ignored-directories
                    (append projectile-globally-ignored-directories
                            '("node_modules")))
    (error "Failed appending to projectile-globally-ignored-directories")))

(defun config/python ()
  "Configure python and related modes."
  (let* ((conda-path (format "%s/.anaconda" (getenv "HOME")))
         (python-path (format "%s/bin" conda-path)))
    (setenv "WORKON_HOME" (format "%s/envs" conda-path))
    (setq-default conda-anaconda-home conda-path))

  ;; (add-hook 'python-mode-hook #'elpy-enable)
  (add-hook 'python-mode-hook #'anaconda-mode)
  (add-hook 'python-mode-hook #'anaconda-eldoc-mode)
  (add-hook 'python-mode-hook #'evil-text-object-python-add-bindings)

  ;; Register Pipenv project type with projectile
  (projectile-register-project-type 'python-pipenv '("Pipfile")
                                    :compile "pipenv run compile"
                                    :test "pipenv run test"
                                    :test-suffix "_test")
  (projectile-register-project-type 'python-pytest '(".pytest_cache")
                                    :compile ""
                                    :test "pytest"
                                    :test-prefix "test_"
                                    :test-suffix "_test")

  (defun python-before-save-hooks ()
    (when (and python-format-on-save
               (eq major-mode 'python-mode))
      (progn
        (spacemacs/python-remove-unused-imports)
        (importmagic-fix-imports)
        (py-isort-buffer)
        (yapfify-buffer))))

  (add-hook 'before-save-hook #'python-before-save-hooks)
  nil)

(defun config/ruby ()
  "Configure packages for Ruby mode."
  (defun switch-to-rspec-compilation-buffer ()
    "Switch to the RSpec compilation buffer."
    (switch-to-buffer "*rspec-compilation*"))

  (defun rails--find-related-file (path)
    "Toggle between controller implementation and request spec.
Fall back to controller spec."
    (if (string-match
         (rx (group (or "app" "spec"))
             (group "/" (or "controllers" "requests"))
             (group "/" (1+ anything))
             (group (or "_controller" "_request"))
             (group (or ".rb" "_spec.rb")))
         path)
        (let ((dir (match-string 1 path))
              (subdir (match-string 2 path))
              (file-name (match-string 3 path)))
          (let ((implementation (concat "app/controllers" file-name "_controller.rb"))
                (request-spec (concat "spec/requests" file-name "_request_spec.rb"))
                (controller-spec (concat "spec/controllers" file-name "_controller_spec.rb")))
            (if (equal dir "spec")
                (list :impl implementation)
              (list :test (if (file-exists-p (concat (projectile-project-root) request-spec))
                              request-spec
                            controller-spec)
                    :request-spec request-spec
                    :controller-spec controller-spec))))))

  (projectile-register-project-type
   'rails-rspec '("Gemfile" "app" "lib" "db" "config" "spec")
   :compile "bin/rails server"
   :src-dir "lib/"
   :test "bin/rspec --no-profile --format progress"
   :test-dir "spec/"
   :test-suffix "_spec"
   :related-files-fn #'rails--find-related-file)

  (eval-after-load 'evil-mode
    (require 'evil-rails))

  ;; Enable pry in test runs
  (add-hook 'compilation-filter-hook 'inf-ruby-auto-enter))

(defun config/ruby-folding ()
  "Configure ruby folding."
  (eval-after-load "hideshow"
    '(add-to-list 'hs-special-modes-alist
                  `(ruby-mode
                    ,(rx (or "def" "class" "module" "do" "{" "[")) ; Block start
                    ,(rx (or "}" "]" "end"))                       ; Block end
                    ,(rx (or "#" "=begin")) ; Comment start
                    ruby-forward-sexp nil))))

(defun config/set-terminal-emacs-theme ()
  "Set theme for terminal session."
  (if (not (display-graphic-p))
      (spacemacs/load-theme 'spacemacs-dark)))

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

(defun config/smartparens ()
  "Configure smartparens."
  (setq-default sp-ignore-modes-list
                '(minibuffer-inactive-mode
                  rjsx-mode
                  js2-mode
                  typescript-mode
                  typescript-tsx-mode)))

(defun config/underscore-to-word-char-list ()
  "Add underscore to word char list in prog and other modes."
  (defun add-underscore-to-word-chars ()
    "Adds underscore to the word chars syntax entry list."
    (modify-syntax-entry ?_ "w"))

  (add-hook 'markdown-mode-hook #'add-underscore-to-word-chars)
  (add-hook 'org-mode-hook #'add-underscore-to-word-chars)
  (add-hook 'prog-mode-hook #'add-underscore-to-word-chars)
  (add-hook 'python-mode-hook #'add-underscore-to-word-chars)
  (add-hook 'restclient-mode-hook #'add-underscore-to-word-chars)
  (add-hook 'text-mode-hook #'add-underscore-to-word-chars))

(defun config/version-control ()
  "Configure version-control-related settings."
  (setq-default
   magit-repository-directories '(("~/Projects/" . 2)
                                  ("~/Documents/". 2))))

(defun config/web-beautify ()
  "Configure web-beautify hooks."
  (setq-default web-beautify-format-on-save nil)

  (with-eval-after-load 'web-beautify
    (defconst web-beautify-args '("-")))

  (defun web-beautify-format-html ()
    "Format the buffer if in an HTML mode."
    (when (and web-beautify-format-on-save
               (or (eq major-mode 'html-mode)
                   (eq major-mode 'web-mode)))
      (web-beautify-html-buffer)))
  (add-hook 'before-save-hook #'web-beautify-format-html)

  (defun web-beautify-format-css ()
    "Format the buffer if in a CSS mode."
    (when (and web-beautify-format-on-save
               (eq major-mode 'css-mode))
      (web-beautify-css-buffer)))
  (add-hook 'before-save-hook #'web-beautify-format-css))

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
;;; config.el ends here
