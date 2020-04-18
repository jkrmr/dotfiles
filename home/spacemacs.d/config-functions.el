;;; config-functions.el --- Emacs configuration functions.

;;; Commentary:
;; Functions invoked from customizations.el
;; Defined separately to facilitate isolated and granular debugging.

;;; Code:
(defun config/load-local-config ()
  "Load local configuration overrides."
  (load "~/.init.local.el"))

(defun config/amx ()
  "Configure amx keybindings."
  (if (boundp 'evil-visual-state-map)
      (progn
        (define-key evil-visual-state-map (kbd ",:") #'amx/amx-major-mode-commands)))
  (if (boundp 'evil-normal-state-map)
      (progn
        (define-key evil-normal-state-map (kbd ",:") #'amx/amx-major-mode-commands))))

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

(defun config/evil-in-ex-buffer ()
  "Emacs bindings in Evil ex minibuffer."
  (if (boundp 'evil-ex-completion-map)
      (progn
        (define-key evil-ex-completion-map (kbd "C-b") 'backward-char)
        (define-key evil-ex-completion-map (kbd "C-k") 'kill-line)
        (define-key evil-ex-completion-map (kbd "C-a") 'beginning-of-line))
    (error "Failed setting up ex mode keybindings")))

(defun config/evil-goggles ()
  "Configure evil-goggles."
  (setq-default evil-goggles-pulse nil
                evil-goggles-duration 0.7)

  (evil-goggles-mode)
  (evil-goggles-use-diff-refine-faces))

(defun config/evil-lion ()
  "Configure evil-lion alignment text objects."
  ;; align (e.g.: gaip=, gaip/)
  (if (and (boundp 'evil-normal-state-map)
           (boundp 'evil-visual-state-map))
      (progn
        (define-key evil-normal-state-map (kbd "ga") #'evil-lion-left)
        (define-key evil-normal-state-map (kbd "gA") #'evil-lion-right)
        (define-key evil-visual-state-map (kbd "ga") #'evil-lion-left)
        (define-key evil-visual-state-map (kbd "gA") #'evil-lion-right))
    (error "Failed setting up evil-lion alignment keybindings")))

(defun config/frames ()
  "Configure GUI Emacs frames."
  (when window-system
    (add-to-list 'default-frame-alist '(ns-appearance . dark))
    (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))))

(defun config/flycheck ()
  "Configure and enable Flycheck."
  (add-hook 'after-init-hook #'global-flycheck-mode))

(defun config/google-translate ()
  "Configure google-translate."
  (setq-default google-translate-backend-method 'curl
                ;; 'popup 'kill-ring 'current-buffer
                google-translate-output-destination 'current-buffer
                google-translate-pop-up-buffer-set-focus t
                google-translate-translation-directions-alist '(("en" . "es")
                                                                ("en" . "fr")
                                                                ("en" . "nl")))
  (spacemacs/set-leader-keys
    "x g t" #'google-translate-smooth-translate))

(defun config/gtags ()
  "Configure GNU Global tag backend."
  ;; Enable direnv-mode, so bundler-gtags-produced .envrc is activated
  (direnv-mode))

(defun config/helpful ()
  "Configure Helpful."
  ;; Note that the built-in `describe-function' includes both functions
  ;; and macros. `helpful-function' is functions only, so we provide
  ;; `helpful-callable' as a drop-in replacement.
  (global-set-key (kbd "C-h f") #'helpful-callable)
  (global-set-key (kbd "C-h v") #'helpful-variable)
  (global-set-key (kbd "C-h k") #'helpful-key)
  ;; Lookup the current symbol at point. C-c C-d is a common keybinding
  ;; for this in lisp modes.
  (global-set-key (kbd "C-h SPC") #'helpful-at-point)

  ;; Look up *F*unctions (excludes macros).
  ;;
  ;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
  ;; already links to the manual, if a function is referenced there.
  (global-set-key (kbd "C-h F") #'helpful-function)

  ;; Look up *C*ommands.
  ;;
  ;; By default, C-h C is bound to describe `describe-coding-system'. I
  ;; don't find this very useful, but it's frequently useful to only
  ;; look at interactive functions.
  (global-set-key (kbd "C-h C") #'helpful-command))

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

(defun config/ido ()
  "Enable and configure ido mode."
  (add-hook 'after-init-hook #'ido-mode)
  (add-hook 'after-init-hook #'flx-ido-mode)
  (spacemacs/set-leader-keys "a d" #'ido-dired))

(defun config/javascript-modes ()
  "Configure JavaScript modes: js, js2, react."
  (defun json-mode-hooks ()
    (progn
      (setq tab-width 2)
      (spacemacs/set-leader-keys-for-major-mode
        'json-mode "=" #'json-pretty-print-buffer)))
  (add-hook 'json-mode-hook #'json-mode-hooks)

  (with-eval-after-load 'web-mode
    (if (boundp 'web-mode-indentation-params)
        (progn
          (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
          (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
          (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))
      (error "Failed setting up js-modes indentation params")))

  (defun rjsx-hybrid-keybindings ()
    "Bind C-d to `rjsx-delete-creates-full-tag'."
    (if (bound-and-true-p evil-hybrid-state-map)
        (define-key evil-hybrid-state-map (kbd "C-d") #'rjsx-delete-creates-full-tag)
      (error "Failed defining RJSX hybrid state keybindings")))
  (add-hook 'rjsx-mode-hook #'rjsx-hybrid-keybindings))

(defun config/latex-mode ()
  "Configure LaTeX mode."
  (defun XeLaTeX-compile ()
    (interactive)
    (async-shell-command (format "xelatex %s" (buffer-file-name))))

  (spacemacs/declare-prefix-for-mode 'latex-mode "SPC" "compile")
  (spacemacs/set-leader-keys-for-major-mode 'latex-mode "SPC SPC" #'XeLaTeX-compile)

  ;; Compile resume: Defined in local config
  (spacemacs/set-leader-keys-for-major-mode 'latex-mode "SPC r" #'XeLaTeX-compile-resume)

  ;; Update preview when file changes
  (add-hook 'doc-view-mode-hook 'auto-revert-mode)

  ;; Detect xelatex files
  (add-to-list 'auto-mode-alist '("\\.xtx\\'" . LaTeX-mode)))

(defun config/ligatures ()
  "Configure firacode font face with ligatures."
  (let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
                 (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
                 (36 . ".\\(?:>\\)")
                 (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
                 (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
                 (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
                 (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
                 (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
                 (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
                 (48 . ".\\(?:x[a-zA-Z]\\)")
                 (59 . ".\\(?:;;\\|;\\)")
                 (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
                 (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
                 (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
                 (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
                 (91 . ".\\(?:]\\)")
                 (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
                 (94 . ".\\(?:=\\)")
                 (123 . ".\\(?:-\\)")
                 (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
                 (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)"))))
    (dolist (char-regexp alist)
      (set-char-table-range composition-function-table (car char-regexp)
                            `([,(cdr char-regexp) 0 font-shape-gstring]))))

  (defun toggle-ligatures-off ()
    "Disable ligatures."
    (interactive)
    (setq auto-composition-mode nil))

  (defun toggle-ligatures-on ()
    "Disable ligatures."
    (interactive)
    (setq auto-composition-mode t))

  ;; Disable Fira Code ligatures in the following modes:
  (add-hook 'mu4e-headers-mode-hook #'toggle-ligatures-off)
  (add-hook 'compilation-mode-hook #'toggle-ligatures-off)
  (add-hook 'org-mode-hook #'toggle-ligatures-off))

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
      ;; (lispy-mode +1)
      (parinfer-mode)
      (evil-cleverparens-mode)))

  (remove-hook 'emacs-lisp-mode-hook #'parinfer-mode)
  (add-lisp-modes-hook #'lisp-packages))

(defun config/markdown-mode ()
  "Configure Markdown mode."
  (with-eval-after-load 'markdown-mode
    (if (boundp 'markdown-mode-map)
        (progn
          (define-key markdown-mode-map (kbd "C-j") #'markdown-next-visible-heading)
          (define-key markdown-mode-map (kbd "C-k") #'markdown-previous-visible-heading))
      (error "Failed setting markdown mode super-key keybindings"))))

(defun config/modeline ()
  "Configure the modeline."
  ;; evil mode indicators
  (setq-default
   evil-normal-state-tag   (propertize "[Normal]" 'face '((:background "green" :foreground "black")))
   evil-emacs-state-tag    (propertize "[Emacs]" 'face '((:background "orange" :foreground "black")))
   evil-insert-state-tag   (propertize "[Insert]" 'face '((:background "red") :foreground "white"))
   evil-hybrid-state-tag   (propertize "[Hybrid]" 'face '((:background "red") :foreground "white"))
   evil-motion-state-tag   (propertize "[Motion]" 'face '((:background "blue") :foreground "white"))
   evil-visual-state-tag   (propertize "[Visual]" 'face '((:background "grey80" :foreground "black")))
   evil-operator-state-tag (propertize "[Operator]" 'face '((:background "purple"))))

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
    (setq-default
     org-todo-keywords
     '((sequence "TODO(t)"
                 "NEXT(n)"
                 "INPROGRESS(i)"
                 "BLOCKED(b)"
                 "QUESTION(q)"
                 "|"
                 "DONE(d)"
                 "CANCELLED(c)")))
    ;; Save clocks
    (setq-default org-clock-persist t)
    (org-clock-persistence-insinuate)

    ;; Journal
    (spacemacs/set-leader-keys-for-major-mode
      'org-journal-mode
      "s" 'org-journal-search
      "t" 'org-journal-today)

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

    (spacemacs/set-leader-keys
      "a j" nil
      "a j ." #'spacemacs/org-journal-transient-state/body
      "a j RET" #'org-journal-new-entry
      "a j t" #'org-journal-today
      "a j s" #'org-journal-search
      "a j f" #'org-journal-search-forever
      "a j d" #'org-journal-new-date-entry)
    (spacemacs/declare-prefix "a j" "org-journal")

    ;; mode hooks
    (add-hook 'org-journal-mode-hook #'org-mode)
    (add-hook 'org-capture-mode-hook #'org-align-tags)


    (defun org-capture-marginalia-display-char-countdown (change-beg change-end prev-len)
      "Display character countdown in the messages buffer if in org-capture mode."
      (when (and (eq major-mode 'org-mode)
                 (string-match-p "CAPTURE-marginalia.org" (format "%s" (current-buffer))))
        (let ((chars-present (- (point-max) (point-min)))
              (prefilled-chars 133)
              (max-chars 240))
          (message "%s characters left"
                   (- (+ max-chars prefilled-chars) chars-present)))))

    (add-to-list 'after-change-functions
                 #'org-capture-marginalia-display-char-countdown)

    ;; Org capture templates
    (setq-default
     org-capture-templates
     '(
       ("t" "Todo" entry (file+headline org-default-backlog-file "Captures")
        "** %?\n%U" :empty-lines 1)

       ("c" "Commonplace" entry (file+headline "blog/commonplaces.org" "Commonplaces")
        (function org-hugo-new-commonplace-capture-template) :empty-lines 1 :prepend t)

       ("m" "Marginalia" entry (file+headline "blog/marginalia.org" "Marginalia")
        (function org-hugo-new-marginalia-capture-template) :empty-lines 1 :prepend t)

       ("s" "Standup" plain (file+olp+datetree "~/Dropbox/org/journal-standup.org")
        "     %?")

       ("r" "Reference" entry (file+headline org-default-backlog-file "Captures")
        "** %?\n%a\n%U" :empty-lines 1)

       ("n" "Notes" entry (file+headline "blog/notes.org" "Notes")
        (function org-hugo-new-blog-capture-template) :empty-lines 1 :prepend t)

       ("p" "Blog Post" entry (file+headline "blog/blog.org" "Blog")
        (function org-hugo-new-blog-capture-template) :empty-lines 1 :prepend t)

       ("h" "Health / Diet journal" entry (file+olp+datetree "~/Dropbox/org/journal-health.org")
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
    (setq-default conda-anaconda-home conda-path
                  exec-path (cons python-path exec-path)))

  ;; flycheck checkers
  (defun set-python-flycheck-checkers ()
    "Set Flycheck checkers."
    (setq-default flycheck-checker 'lsp)
    (flycheck-add-next-checker 'lsp 'python-flake8)
    (flycheck-add-next-checker 'python-flake8 'python-mypy)
    (flycheck-add-next-checker 'python-mypy 'python-pylint))
  (add-hook 'python-mode-hook #'set-python-flycheck-checkers)

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
        ;; (spacemacs/python-remove-unused-imports)
        ;; (importmagic-fix-imports)
        (py-isort-buffer)
        (yapfify-buffer))))

  (add-hook 'before-save-hook #'python-before-save-hooks))

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

  ;; flycheck checkers
  (defun set-ruby-flycheck-checkers ()
    "Set Flycheck checkers."
    (setq-default flycheck-checker 'lsp)
    (flycheck-add-next-checker 'lsp 'ruby-rubocop)
    (flycheck-add-next-checker 'ruby-rubocop 'ruby-reek))
  (add-hook 'ruby-mode-hook #'set-ruby-flycheck-checkers)

  ;; Enable pry in test runs
  (add-hook 'compilation-filter-hook 'inf-ruby-auto-enter)

  ;; Toggle breakpoint
  (spacemacs/set-leader-keys-for-major-mode 'ruby-mode "d b" #'spacemacs/ruby-toggle-breakpoint)
  ;; (spacemacs/set-leader-keys-for-major-mode 'ruby-mode "d p" #'(lambda () (interactive) (spacemacs/ruby-toggle-breakpoint t)))

  ;; Define keybinding to manually trigger autoformat
  (spacemacs/set-leader-keys-for-major-mode
    'ruby-mode "=" nil)
  (spacemacs/declare-prefix-for-mode
    'ruby-mode "=" "format")
  (spacemacs/set-leader-keys-for-major-mode
    'ruby-mode "==" #'rufo-format-buffer))

(defun config/ruby-in-buffer-eval ()
  "Configure and enable seeing-is-believing and xmpfilter for Ruby."
  (defun xmpfilter-eval-current-line ()
    (interactive)
    (seeing-is-believing-mark-current-line-for-xmpfilter)
    (seeing-is-believing-run-as-xmpfilter))

  (cond
   ((boundp 'ruby-mode-map)
    (progn
      (define-key ruby-mode-map (kbd "C-c C-c") 'xmpfilter-eval-current-line)
      (define-key ruby-mode-map (kbd "C-c C-v") 'seeing-is-believing-clear)
      (define-key ruby-mode-map (kbd "C-c C-f") 'seeing-is-believing-run)))
   ((boundp 'enh-ruby-mode-map)
    (progn
      (define-key enh-ruby-mode-map (kbd "C-c C-c") 'xmpfilter-eval-current-line)
      (define-key enh-ruby-mode-map (kbd "C-c C-v") 'seeing-is-believing-clear)
      (define-key enh-ruby-mode-map (kbd "C-c C-f") 'seeing-is-believing-run)))))

(defun config/ruby-folding ()
  "Configure ruby folding."
  (eval-after-load "hideshow"
    '(add-to-list 'hs-special-modes-alist
                  `(ruby-mode
                    ,(rx (or "def" "class" "module" "do" "{" "[")) ; Block start
                    ,(rx (or "}" "]" "end"))                       ; Block end
                    ,(rx (or "#" "=begin")) ; Comment start
                    ruby-forward-sexp nil)))

  (if (boundp 'ruby-mode-map)
      (progn
        (define-key ruby-mode-map (kbd "C-c h") 'hs-hide-block)
        (define-key ruby-mode-map (kbd "C-c s") 'hs-show-block))
    (error "Failed setting up ruby-folding keybindings")))

(defun config/set-terminal-emacs-theme ()
  "Set theme for terminal session."
  (if (not (display-graphic-p))
      (spacemacs/load-theme 'spacemacs-dark)))

(defun config/shell-buffers ()
  "Configure shell buffers."
  (with-eval-after-load 'vterm
    (if (boundp 'vterm-mode-map)
        (progn
          (define-key vterm-mode-map (kbd "C-y") #'vterm-send-C-y)
          (define-key vterm-mode-map (kbd "C-d") #'vterm-send-C-d))
      (error "Failed setting vterm keybindings")))

  (spacemacs/set-leader-keys "a s f" #'shell-full)
  (spacemacs/set-leader-keys "a s r" #'shell-right)
  (spacemacs/set-leader-keys "a s b" #'shell-below)
  (spacemacs/set-leader-keys "\'" #'shell-below-full-span)

  ;; Use utf8
  (defun term-use-utf8 ()
    (interactive)
    (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
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
                                  ("~/Documents/". 2)))

  ;; leader gb to display branching controls
  (spacemacs/set-leader-keys "gb" #'magit-branch-or-checkout)

  ;; leader gB to display Git blame
  (spacemacs/set-leader-keys "gB" #'spacemacs/git-blame-micro-state))

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

(defun config/window-splitting ()
  "Make focus window commands primary."
  (spacemacs/set-leader-keys "ws" #'split-window-below-and-focus)
  (spacemacs/set-leader-keys "wS" #'split-window-below)
  (spacemacs/set-leader-keys "wv" #'split-window-right-and-focus)
  (spacemacs/set-leader-keys "wV" #'split-window-right))

(defun config/yankee ()
  "Load and configure yankee.el.
Provides facilities for yanking formatted code snippets."
  (require 'yankee)
  (if (boundp 'evil-visual-state-map)
      (define-key evil-visual-state-map (kbd "C-\\") #'yankee-yank)
    (error "Failed setting up yankee.el keybinding")))

(defun config/yasnippet ()
  "Define yasnippet keybindings."
  (with-eval-after-load 'lispy
    (when (boundp 'lispy-mode-map)
        (define-key lispy-mode-map (kbd "C-j") nil)))
  (if (boundp 'evil-hybrid-state-map)
      (progn
        (define-key evil-hybrid-state-map (kbd "C-\'") #'company-yasnippet)
        (define-key evil-hybrid-state-map (kbd "C-;") #'yas-expand-from-trigger-key))
    (error "Could not set yasnippet keybindings")))

(provide 'config-functions)
;;; config-functions.el ends here
