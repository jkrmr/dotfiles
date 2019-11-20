;;; config-functions.el --- Emacs configuration functions.

;;; Commentary:
;; Loaded from customizations.el

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

(defun config/code-folding ()
  "Configure code folding settings."
  (if (and (boundp 'evil-visual-state-map)
           (boundp 'evil-normal-state-map)
           (boundp 'evil-fold-list))
      (progn
        ;; Toggle folds with TAB
        (define-key evil-normal-state-map (kbd "TAB") #'evil-toggle-fold)
        ;; Set up vimish-fold
        (add-to-list 'evil-fold-list '((vimish-fold-mode)
                                       :open-all   vimish-fold-unfold-all
                                       :close-all  nil
                                       :toggle     vimish-fold-toggle
                                       :open       vimish-fold-unfold
                                       :open-rec   nil
                                       :close      vimish-fold))
        (define-key evil-visual-state-map (kbd "zf") #'vimish-fold)
        (define-key evil-normal-state-map (kbd "zf") nil)
        (define-key evil-normal-state-map (kbd "zfd") #'vimish-fold-delete)
        (define-key evil-normal-state-map (kbd "zfj") #'vimish-fold-next-fold)
        (define-key evil-normal-state-map (kbd "zfk") #'vimish-fold-previous-fold)
        (define-key evil-normal-state-map (kbd "zfm") #'vimish-fold-refold-all)
        (define-key evil-normal-state-map (kbd "zfr") #'vimish-fold-unfold-all)
        (define-key evil-normal-state-map (kbd "zft") #'vimish-fold-toggle-all)
        (define-key evil-normal-state-map (kbd "zfa") #'vimish-fold-toggle))
    (error "Failed setting up vimish-fold")))

(defun config/company ()
  "Configure company auto-completion mode."
  (with-eval-after-load 'company
    ;; (company-flx-mode +1)
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
      (define-key company-active-map (kbd "S-TAB") #'spacemacs//company-complete-common-or-cycle-backward))

    (setq-default
     ;; Number the candidates (use M-1, M-2 etc to select completions).
     company-show-numbers t
     ;; Trigger completion immediately.
     company-box-doc-delay 0.0
     company-tooltip-idle-delay 0.0
     company-quickhelp-delay 0.0
     company-idle-delay 0.0)

    (if (boundp 'company-backends)
        (progn
          (add-to-list 'company-backends '(company-anaconda :with company-yasnippet))
          (add-to-list 'company-backends '(company-capf :with company-yasnippet))
          (add-to-list 'company-backends '(company-dabbrev :with company-yasnippet))
          (add-to-list 'company-backends '(company-dabbrev-code :with company-yasnippet))
          (add-to-list 'company-backends '(company-keywords :with company-yasnippet))
          (add-to-list 'company-backends '(company-gtags :with company-yasnippet))
          (add-to-list 'company-backends '(company-etags :with company-yasnippet))
          (add-to-list 'company-backends '(company-files :with company-yasnippet))
          (add-to-list 'company-backends '(company-tern :with company-yasnippet)))
      (error "Not adding company backends"))

    (if (boundp 'company-frontends)
        (progn
          (add-to-list 'company-frontends 'company-pseudo-tooltip-frontend)
          (add-to-list 'company-frontends 'company-echo-metadata-frontend))
      (error "Not adding company front-ends"))))

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

(defun config/deft ()
  "Configure deft notes browser."
  (setq-default
   deft-auto-save-interval 10
   deft-directory "~/Dropbox/deft"
   deft-extensions '("txt" "text" "tex" "md" "markdown" "org")
   deft-default-extension "org"
   deft-recursive t)

  (spacemacs/set-leader-keys
    "a n" nil
    "a n RET" #'spacemacs/deft
    "a n f" #'deft-find-file
    "a n n" #'deft-new-file-named
    "a n s" #'org-notes-open-sprint
    "a n b" #'org-notes-open-backlog)
  (spacemacs/declare-prefix "a n" "notes")

  (spacemacs/set-leader-keys-for-major-mode 'deft-mode
    "g" #'deft-refresh))

(defun config/diminish ()
  "Configure diminish glyphs for various minor modes."
  (with-eval-after-load 'diminish
    (diminish 'alchemist-mode "⊛")
    (diminish 'alchemist-phoenix-mode "⊙")
    (diminish 'elm-indent-mode "⨕")
    (diminish 'minitest-mode "⨷")
    (diminish 'rubocop-mode "℞")
    (diminish 'ruby-refactor-mode "RR")
    (diminish 'seeing-is-believing "S")
    (diminish 'tern-mode "₸")))

(defun config/elixir ()
  "Configure Elixir mode."
  (setq-default flycheck-elixir-credo-strict t)

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
  (setq-default
   flycheck-global-modes '(LaTeX-mode
                           c++-mode
                           c-mode
                           coffee-mode
                           elixir-mode
                           emacs-lisp-mode
                           enh-ruby-mode
                           go-mode
                           haml-mode
                           haskell-mode
                           js2-mode
                           json-mode
                           less-mode
                           markdown-mode
                           pug-mode
                           python-mode
                           react-mode
                           ruby-mode
                           sass-mode
                           scss-mode
                           slim-mode
                           web-mode
                           yaml-mode))
  (global-flycheck-mode))

(defun config/global-modes ()
  "Enable globally set modes."
  (flx-ido-mode)
  (global-evil-quickscope-mode 1)
  (smartparens-global-strict-mode)
  (visual-line-mode))

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
  (direnv-mode)
  ;; Add GNU Global as an xref-backend
  (setq-default
   xref-backend-functions '(ggtags--xref-backend
                            elisp--xref-backend
                            gxref-xref-backend
                            etags--xref-backend)))

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

(defun config/javascript-modes ()
  "Configure JavaScript modes: js, js2, react."
  (setq-default js-indent-level 2
                js2-basic-offset 2
                js2-strict-missing-semi-warning nil
                prettier-js-command "prettier-standard"
                prettier-js-show-errors 'echo)

  (setq-default javascript-format-on-save t)
  (defun js-before-save-hooks ()
    (when (and javascript-format-on-save
               (or (eq major-mode 'rjsx-mode)
                   (eq major-mode 'js2-mode)))
      (prettier-js)))
  (add-hook 'before-save-hook #'js-before-save-hooks)

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
  (smartparens-strict-mode)
  (spacemacs/toggle-evil-safe-lisp-structural-editing-on-register-hooks)

  (setq-default
   parinfer-extensions '(
                         defaults
                         pretty-parens
                         evil
                         ;; lispy
                         paredit
                         smart-tab
                         smart-yank))

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
  (defun alchemist-iex-send-current-code-block ()
    "Send the current Markdown code block to iex."
    (interactive)
    (save-excursion
      (re-search-backward "```")
      (forward-line)
      (push-mark)
      (re-search-forward "```")
      (forward-line -1)
      (move-end-of-line nil)
      (alchemist-iex-send-region (region-beginning) (region-end))
      (pop-mark)))

  ;; markdown mode leader keybindings
  (spacemacs/declare-prefix-for-mode 'markdown-mode "e" "markdown/evaluate")
  (spacemacs/set-leader-keys-for-major-mode 'markdown-mode "ee" #'alchemist-iex-send-current-code-block)

  (setq-default markdown-asymmetric-header t))

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
    (setq-default org-agenda-files '("~/Dropbox/org")
                  org-agenda-window-setup 'current-window)

    (if (boundp 'org-agenda-files)
        (mapc
         #'(lambda (file)
             (when (file-exists-p file)
               (push file org-agenda-files)))
         (org-projectile-todo-files))
      (error "Failed: 'org-agenda-files not bound")))

  (setq-default
   org-refile-use-outline-path 'file
   org-refile-allow-creating-parent-nodes 'confirm
   org-outline-path-complete-in-steps nil
   org-refile-targets '(("~/Dropbox/org/sprint-today.org" :maxlevel . 1)
                        ("~/Dropbox/org/sprint-backlog.org" :maxlevel . 1)
                        ("~/Dropbox/org/sprint-icebox.org" :maxlevel . 1)))

  (with-eval-after-load 'org
    (setq-default
     org-directory "~/Dropbox/org"
     org-default-blog-file "~/Dropbox/org/blog.org"
     org-default-commonplaces-file "~/Dropbox/org/marginalia.org"
     org-default-notes-file "~/Dropbox/org/sprint-today.org"
     org-default-backlog-file "~/Dropbox/org/sprint-backlog.org"
     org-archive-location "~/Dropbox/org/archive.org::* %s")

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

    ;; Keybindings
    (evil-define-key 'hybrid evil-org-mode-map (kbd "C-H-<return>") 'org-insert-subheading)

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

    (setq-default org-journal-find-file #'find-file
                  org-journal-file-format "%Y%m%d"
                  org-journal-file-type 'monthly)

    (add-hook 'org-journal-mode-hook #'org-mode)
    (add-hook 'org-capture-mode-hook #'org-align-all-tags)

    (defun org-capture-marginalia-display-word-count (change-beg change-end prev-len)
      "Display word count in the messages buffer if in org-capture mode."
      (when (and (eq major-mode 'org-mode)
                 (string-match-p "CAPTURE-marginalia.org" (format "%s" (current-buffer))))
        (message "%s characters left" (- 240 (- (point-max) (point-min) 81)))))

    (add-to-list 'after-change-functions #'org-capture-marginalia-display-word-count)

    ;; ox-hugo
    (setq-default
     org-hugo-export-with-toc nil
     org-hugo-export-with-section-numbers nil)

    ;; Org capture templates
    (setq-default
     org-capture-templates
     '(
       ("b" "Backlog" entry (file+headline org-default-backlog-file "Captures")
        "** %?\n%U" :empty-lines 1)

       ("a" "Annotation" entry (file+headline org-default-backlog-file "Captures")
        "** %?\n%a\n%U" :empty-lines 1)

       ("d" "Deadline" entry (file+headline org-default-backlog-file "Captures")
        "** %?\nDEADLINE: %^t\n %U" :empty-lines 1)

       ("t" "Task (Today's Sprint)" entry (file+headline org-default-notes-file "To Do Today")
        "** TODO %?\nSCHEDULED: %t\n %U" :empty-lines 1)

       ("n" "Note" plain (function org-capture-deft-new-file)
        "%(format \"#+TITLE: %s\n#+DATE: %s\n\" org-capture-deft--title %U)\n*  %?")

       ("j" "Journal entry" plain (function org-journal-find-location)
        "** %(format-time-string org-journal-time-format)%^{Title}\n%i%?" :empty-lines 1)

       ("p" "Blog post" entry (file+headline "blog.org" "Blog")
        (function org-hugo-new-blog-capture-template) :empty-lines 1 :prepend t)

       ("m" "Marginalia post" entry (file+headline "marginalia.org" "Marginalia")
        (function org-hugo-new-marginalia-capture-template) :empty-lines 1 :prepend t)

       ("s" "Standup" plain (file+olp+datetree "~/Dropbox/org/journal-standup.org")
        "     %?")

       ("h" "Health / Diet journal" entry (file+olp+datetree "~/Dropbox/org/journal-health.org")
        "**** [%<%l:%M %p>] %^{Entry} %^g" :immediate-finish t)

       ("v" "Paste from clipboard" entry (file+headline org-default-backlog-file "Captures")
        "** %^{Title} %^G\n%?\n%c")

       ("c" "Commonplace" entry (file "~/Dropbox/org/journal-commonplaces.org")
        "* %^{Title} %^G\n%?")))

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
                projectile-git-submodule-command nil
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

  (setq-default python-guess-indent nil
                python-indent-offset 4
                python-shell-completion-native-enable t
                python-shell-interpreter "ipython"
                python-shell-interpreter-args "-i --simple-prompt")

  (add-hook 'python-mode-hook #'anaconda-eldoc-mode)
  (add-hook 'python-mode-hook #'anaconda-mode)
  (add-hook 'python-mode-hook #'evil-text-object-python-add-bindings)

  ;; conda-env
  ;; (setq-default conda-anaconda-home (getenv "ANACONDA_HOME"))
  ;; (conda-env-initialize-interactive-shells)
  ;; (conda-env-initialize-eshell)
  ;; (conda-env-autoactivate-mode)

  ;; elpy
  ;;(elpy-enable)

  ;; traad
  ;; Expects a conda env of the same name be defined
  ;; Execute (traad-install-server) to set up
  (setq-default traad-environment-name "traad")

  ;; Register Pipenv project type with projectile
  (projectile-register-project-type 'python-pipenv '("Pipfile")
                                    :compile "pipenv run compile"
                                    :test "pipenv run test"
                                    :test-suffix "_test")

  (setq-default python-format-on-save t)
  (defun python-before-save-hooks ()
    (when (and python-format-on-save
               (eq major-mode 'python-mode))
      (progn
        (pyimport-remove-unused)
        (importmagic-fix-imports)
        (py-isort-buffer)
        (yapfify-buffer))))

  (add-hook 'before-save-hook #'python-before-save-hooks))

(defun config/ruby ()
  "Configure packages for Ruby mode."
  (defun switch-to-rspec-compilation-buffer ()
    "Switch to the RSpec compilation buffer."
    (switch-to-buffer "*rspec-compilation*"))

  (setq-default
   ruby-format-on-save t
   ruby-current-line nil
   rspec-use-opts-file-when-available nil
   rspec-autosave-buffer t
   rspec-before-verification-hook #'switch-to-rspec-compilation-buffer
   rspec-use-spring-when-possible nil
   rspec-use-bundler-when-possible t
   rspec-spec-command "rspec"
   rspec-command-options "--format progress --no-profile")

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

  (defun ruby-before-save-hooks ()
    (when (and ruby-format-on-save
               (eq major-mode 'ruby-mode))
      (setq ruby-current-line (line-number-at-pos))
      (rufo-format-buffer)))

  (defun ruby-after-save-hooks ()
    (when (and ruby-format-on-save
               (eq major-mode 'ruby-mode))
      (when ruby-current-line
        (evil-scroll-line-to-center ruby-current-line))))

  (add-hook 'before-save-hook #'ruby-before-save-hooks)
  (add-hook 'after-save-hook #'ruby-after-save-hooks)

  ;; Enable pry in test runs
  (add-hook 'compilation-filter-hook 'inf-ruby-auto-enter)

  ;; Toggle breakpoint
  (spacemacs/set-leader-keys-for-major-mode 'ruby-mode "d b" #'spacemacs/ruby-toggle-breakpoint)
  (spacemacs/set-leader-keys-for-major-mode 'ruby-mode "d p" #'(lambda () (interactive) (spacemacs/ruby-toggle-breakpoint t)))

  ;; Define keybinding to manually trigger autoformat
  (spacemacs/set-leader-keys-for-major-mode
    'ruby-mode "=" nil)
  (spacemacs/declare-prefix-for-mode
    'ruby-mode "=" "format")
  (spacemacs/set-leader-keys-for-major-mode
    'ruby-mode "==" #'rufo-format-buffer))

(defun config/ruby-in-buffer-eval ()
  "Configure and enable seeing-is-believing and xmpfilter for Ruby."
  (require 'seeing-is-believing)
  (add-hook 'ruby-mode-hook 'seeing-is-believing)

  (defun xmpfilter-eval-current-line ()
    (interactive)
    (seeing-is-believing-mark-current-line-for-xmpfilter)
    (seeing-is-believing-run-as-xmpfilter))

  (defun define-xmpfilter-keybindings ()
    "Define keybindings for xmpfilter."
    (if (boundp 'ruby-mode-map)
        (progn
          (define-key ruby-mode-map (kbd "C-c C-c") 'xmpfilter-eval-current-line)
          (define-key ruby-mode-map (kbd "C-c C-v") 'seeing-is-believing-clear)
          (define-key ruby-mode-map (kbd "C-c C-f") 'seeing-is-believing-run))
      (error "Failed setting up xmpfilter keybindings")))

  (add-hook 'ruby-mode-hook 'define-xmpfilter-keybindings))

(defun config/ruby-folding ()
  "Configure ruby folding."
  (add-hook 'ruby-mode-hook
            (lambda () (hs-minor-mode)))

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

(defun config/semantic ()
  "Remove semantic mode hooks."
  (defun config/semantic-remove-hooks ()
    (remove-hook 'completion-at-point-functions
                 'semantic-analyze-completion-at-point-function)
    (remove-hook 'completion-at-point-functions
                 'semantic-analyze-notc-completion-at-point-function)
    (remove-hook 'completion-at-point-functions
                 'semantic-analyze-nolongprefix-completion-at-point-function))
  (add-hook 'semantic-mode-hook #'config/semantic-remove-hooks))

(defun config/set-terminal-emacs-theme ()
  "Set theme for terminal session."
  (if (not (display-graphic-p))
      (spacemacs/load-theme 'spacemacs-dark)))

(defun config/terminal-buffers ()
  "Configure terminal buffers."
  (evil-set-initial-state 'term-mode 'insert)

  (defun term-send-ctrl-y ()
    (interactive)
    (term-send-raw-string "\C-y"))

  (defun term-mode-config ()
    (if (boundp 'term-raw-map)
        (progn
          (define-key term-raw-map (kbd "C-y") #'term-send-ctrl-y)
          (define-key term-raw-map (kbd "C-p") #'term-send-up)
          (define-key term-raw-map (kbd "C-n") #'term-send-down)
          (evil-define-key 'normal term-raw-map (kbd "C-p") #'evil-scroll-page-up)
          (evil-define-key 'normal term-raw-map (kbd "C-n") #'evil-scroll-page-down)
          (define-key term-raw-map (kbd "C-v") #'term-paste)
          (goto-address-mode))
      (error "Failed setting up term mode keybindings")))

  (add-hook 'term-mode-hook #'term-mode-config)

  ;; Use utf8
  (defun my-term-use-utf8 ()
    (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
  (add-hook 'term-exec-hook #'my-term-use-utf8)

  ;; ansi-term: always use default shell
  (defadvice ansi-term (before force-bash)
    (interactive (list shell-default-term-shell)))
  (ad-activate #'ansi-term))

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
  (with-eval-after-load 'magit
    (magit-todos-mode)

    ;; Display Magit full-screen
    (setq-default git-magit-status-fullscreen t)

    (spacemacs/set-leader-keys-for-major-mode
      'magit-status-mode "t" #'magit-todos-jump-to-todos)

    (if (and (boundp 'magit-completing-read-function)
             (boundp 'magit-mode-map))
        (progn
          (define-key magit-mode-map (kbd "<tab>") 'magit-section-toggle))
      (error "Failed setting up magit")))

  (setq-default
   magit-repository-directories '(("~/Projects/" . 2)
                                  ("~/Documents/". 2)))

  ;; leader gb to display branching controls
  (spacemacs/set-leader-keys "gb" #'magit-branch-or-checkout)

  ;; leader gB to display Git blame
  (spacemacs/set-leader-keys "gB" #'spacemacs/git-blame-micro-state)

  ;; Git Gutter: Display fringe on left
  (setq-default git-gutter-fr+-side 'left-fringe
                git-gutter-fr:side 'left-fringe))

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
  (setq-default css-indent-offset 2
                web-mode-markup-indent-offset 4
                web-mode-css-indent-offset 2
                web-mode-attr-indent-offset 2
                web-mode-code-indent-offset 2)

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
  (spacemacs/set-leader-keys "wV" #'split-window-right)
  (spacemacs/set-leader-keys "wT" #'split-term-window-right-and-focus))

(defun config/yankee ()
  "Load and configure yankee.el.
Provides facilities for yanking formatted code snippets."
  (require 'yankee)
  (if (boundp 'evil-visual-state-map)
      (define-key evil-visual-state-map (kbd "g y") #'yankee-yank)
    (error "Failed setting up yankee.el keybinding")))

(defun config/yasnippet ()
  "Define yasnippet keybindings."
  (with-eval-after-load 'lispy
    (if (boundp 'lispy-mode-map)
        (define-key lispy-mode-map (kbd "C-j") nil)
      (error "Not overriding `lispy-mode-map' for yasnippet")))

  (define-key global-map (kbd "C-j") nil)
  (spacemacs/declare-prefix (kbd "C-j") "tools")
  (define-key global-map (kbd "C-j C-j") #'company-yasnippet)
  (define-key global-map (kbd "C-j C-;") #'yas-expand))

(provide 'config-functions)
;;; config-functions.el ends here
