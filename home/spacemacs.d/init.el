;;; init.el --- Spacemacs initialization
;; -*- mode: emacs-lisp; lexical-binding: t -*-

;;; Commentary:
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

;;; Code:
(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;;   1MB: 1000000
   ;;  10MB: 10000000
   ;; 100MB: 100000000  <--- current
   ;;   1GB: 1000000000
   ;; (default 100MB '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; display a minibuffer message each time gc collection runs
   garbage-collection-messages t

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style '(hybrid :variables
                                       hybrid-mode-enable-evilified-state t
                                       hybrid-mode-enable-hjkl-bindings t
                                       hybrid-mode-default-state 'normal)

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner nil

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 3)
                                (bookmarks . 3)
                                (projects . 3)
                                (agenda . 3)
                                (todos . 3))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme 'doom

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 16.0
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "org"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout t

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names t

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state t

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar nil

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native t

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 85

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but lines are only visual lines are counted. For example, folded lines
   ;; will not be counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers '(:relative t
                               :enabled-for-modes prog-mode
                               :disabled-for-modes pdf-view-mode org-mode doc-view-mode dired-mode
                               :size-limit-kb 1024)

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis t

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server t

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server t

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%b"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format "%b"

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'all

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs t))

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '("~/.spacemacs.d/layers/")
   dotspacemacs-configuration-layers
   '(
     (auto-completion :variables
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-complete-with-key-sequence-delay nil
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-idle-delay 0
                      auto-completion-enable-sort-by-usage nil ;; let prescient handle this
                      auto-completion-private-snippets-directory "~/.spacemacs.d/snippets"
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'complete
                      auto-completion-use-company-box t
                      company-backend t
                      company-box-doc-delay 0
                      company-minimum-prefix-length 1
                      company-selection-wrap-around t
                      company-show-numbers t
                      company-tooltip-idle-delay 1)
     better-defaults
     bm
     (c-c++ :variables
            c-c++-enable-clang-support t)
     command-log
     (conda :variables
            conda-anaconda-home "~/.anaconda")
     copy-as-format
     csv
     dap
     (dash :variables
           dash-docs-docset-newpath "~/Library/Application Support/Dash/DocSets/")
     (deft :variables
           deft-auto-save-interval 10
           deft-default-extension "org"
           deft-directory "~/Dropbox/deft"
           deft-extensions '("txt" "text" "tex" "md" "markdown" "org")
           deft-recursive t
           deft-use-filter-string-for-filename t)
     django
     (docker :variables
             docker-dockerfile-backend 'lsp)
     (elixir :variables
             elixir-backend 'alchemist
             flycheck-elixir-credo-strict t)
     (elm :variables
          elm-format-command "elm-format"
          elm-format-on-save t
          elm-sort-imports-on-save t)
     emacs-lisp
     emoji
     epub
     erlang
     evil-commentary
     finance
     (git :variables
          git-magit-status-fullscreen nil
          magit-display-buffer-function 'magit-display-buffer-fullcolumn-most-v1
          magit-repository-directories '(("~/Projects" . 2) ("~/Work" . 2) ("~/Resources" . 2)))
     github
     (go :variables
         go-backend 'lsp
         go-format-before-save t
         go-tab-width 4
         go-use-golangci-lint nil
         go-use-gometalinter t
         go-use-gocheck-for-testing nil
         go-use-testify-for-testing t
         go-use-test-args "-v --bench --benchmem"
         godoc-at-point-function 'godoc-gogetdoc
         gofmt-command "goimports")
     graphviz
     (gtags :variables
            ggtags-highlight-tag nil  ;; disable tag highlighting
            gtags-enable-by-default nil
            xref-backend-functions '(ggtags--xref-backend elisp--xref-backend gxref-xref-backend etags--xref-backend))
     haskell
     (helm :variables
           completion-styles '(flex)
           helm-candidate-number-limit 100
           helm-completion-style 'emacs
           helm-display-header-line nil
           helm-enable-auto-resize t
           helm-no-header nil
           helm-position 'bottom
           helm-use-fuzzy 'always
           spacemacs-helm-rg-max-column-number 512)
     (helpful :variables
              helpful-max-buffers 1)
     (html :variables
           css-indent-offset 2
           web-fmt-tool 'prettier
           web-mode-attr-indent-offset 2
           web-mode-code-indent-offset 2
           web-mode-css-indent-offset 2
           web-mode-markup-indent-offset 4)
     (ibuffer :variables
              ibuffer-group-buffers-by 'projects)
     imenu-list
     import-js
     (javascript :variables
                 javascript-backend 'lsp
                 javascript-fmt-on-save t
                 javascript-fmt-tool 'prettier
                 javascript-import-tool 'import-js
                 javascript-lsp-linter t
                 javascript-repl 'nodejs
                 js-indent-level 2
                 js2-basic-offset 2
                 js2-mode-show-parse-errors nil
                 js2-mode-show-strict-warnings nil
                 js2-strict-missing-semi-warning nil
                 node-add-modules-path t)
     json
     (latex :variables
            latex-enable-auto-fill t
            latex-enable-folding t)
     (lsp :variables
          lsp-keymap-prefix nil
          lsp-idle-delay 0.500
          lsp-navigation 'both
          lsp-prefer-capf t
          lsp-ui-doc-alignment 'frame
          lsp-ui-doc-delay 0.2
          lsp-ui-doc-enable nil
          lsp-ui-doc-header nil
          lsp-ui-doc-include-signature t
          lsp-ui-doc-position 'at-point
          lsp-ui-doc-use-childframe t
          lsp-ui-doc-use-webkit nil
          lsp-ui-remap-xref-keybindings t
          lsp-ui-sideline-enable nil
          lsp-ui-sideline-ignore-duplicate t
          lsp-ui-sideline-show-symbol t
          read-process-output-max (* 1024 1024))
     (markdown :variables
               markdown-asymmetric-header t
               markdown-live-preview-engine 'vmd)
     multiple-cursors
     nginx
     (org :variables
          org-adapt-indentation t
          org-agenda-block-separator ""
          org-agenda-files '("~/Dropbox/org/")
          org-agenda-window-setup 'current-window
          org-archive-location "~/Dropbox/org/ARCHIVE.org::* %s"
          org-babel-python-command "python3"
          org-blank-before-new-entry '((heading . auto) (plain-list-item . auto))
          org-superstar-headline-bullets-list '("› ")
          org-catch-invisible-edits 'show-and-error
          org-clock-idle-time 5
          org-clock-persist t
          org-confirm-babel-evaluate nil
          org-cycle-separator-lines 2
          org-default-backlog-file "~/Dropbox/org/BACKLOG.org"
          org-default-blog-file "~/Dropbox/org/blog/blog.org"
          org-default-notes-file "~/Dropbox/org/TODOS.org"
          org-directory "~/Dropbox/org/"
          org-edit-src-content-indentation 0
          org-ellipsis " ▾ "
          org-enable-bootstrap-support t
          org-enable-github-support t
          org-enable-hugo-support t
          org-enable-org-journal-support t
          org-enable-reveal-js-support t
          org-export-coding-system 'utf-8
          org-export-with-sub-superscripts nil
          org-fontify-done-headline t
          org-fontify-quote-and-verse-blocks t
          org-fontify-whole-heading-line t
          org-hide-emphasis-markers t
          org-hugo-export-with-section-numbers nil
          org-hugo-export-with-toc nil
          org-image-actual-width 500
          org-journal-dir "~/Dropbox/org/journal/"
          org-journal-file-format "%Y%m%d"
          org-journal-file-type 'monthly
          org-journal-find-file #'find-file
          org-list-use-circular-motion t
          org-md-headline-style 'setext
          org-modules '(ol-bibtex ol-docview org-habit ol-info)
          org-outline-path-complete-in-steps nil
          org-pretty-entities t
          org-projectile-projects-directory "~/Dropbox/org/"
          org-refile-allow-creating-parent-nodes 'confirm
          org-refile-targets '(("~/Dropbox/org/TODOS.org" :maxlevel . 1) ("~/Dropbox/org/BACKLOG.org" :maxlevel . 1))
          org-refile-use-outline-path 'file
          org-src-ask-before-returning-to-edit-buffer nil
          org-src-tab-acts-natively t
          org-src-window-setup 'current-window
          org-startup-indented t
          org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "INPROGRESS(i)" "BLOCKED(b)" "QUESTION(q)" "|" "DONE(d)" "CANCELLED(c)"))
          org-tags-column 0
          spaceline-org-clock-p t)
     (osx :variables
          osx-command-as 'hyper
          osx-option-as 'meta
          osx-control-as 'control
          osx-function-as nil
          osx-right-command-as 'left
          osx-right-option-as 'none
          osx-right-control-as 'left
          osx-swap-option-and-command nil)
     (parinfer :variables
               parinfer-extensions '(defaults pretty-parens evil paredit smart-tab smart-yank))
     pdf
     phoenix
     (prettier :variables
               json-fmt-tool 'prettier
               prettier-js-command "prettier-standard"
               prettier-js-show-errors 'echo)
     prodigy
     (python :variables
             python-backend 'lsp
             python-fill-docstring-style 'django
             python-format-on-save t
             python-formatter 'yapf
             python-guess-indent nil
             python-indent-offset 4
             python-lsp-server 'pyls
             lsp-disabled-clients '(mspyls)
             python-save-before-test t
             python-shell-completion-native-enable t
             python-shell-interpreter "ipython"
             python-shell-interpreter-args "-i --simple-prompt"
             python-sort-imports-on-save t
             python-test-runner 'pytest)
     react
     restclient
     (ruby :variables
           rspec-autosave-buffer t
           rspec-before-verification-hook #'switch-to-rspec-compilation-buffer
           rspec-command-options "--format progress --no-profile"
           rspec-spec-command "rspec"
           rspec-use-bundler-when-possible t
           rspec-use-opts-file-when-available nil
           rspec-use-spring-when-possible nil
           ruby-backend 'lsp
           ruby-current-line nil
           ruby-enable-enh-ruby-mode nil
           ruby-format-on-save nil
           ruby-test-rspec-options '()
           ruby-test-runner 'rspec
           ruby-version-manager nil)
     ruby-on-rails
     rust
     search-engine
     (shell :variables
            multi-term-program "zsh"
            shell-default-full-span t
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-shell 'vterm
            shell-default-term-shell "zsh"
            shell-enable-smart-eshell nil)
     shell-scripts
     speed-reading
     spell-checking
     (sql :variables
          sql-auto-indent t
          sql-capitalize-keywords t)
     (syntax-checking :variables
                      flycheck-disabled-checkers '(javascript-jshint go-golangci-lint markdown-mdl ruby-reek)
                      syntax-checking-enable-by-default t
                      syntax-checking-enable-tooltips t)
     theming
     (typescript :variables
                 typescript-backend 'tide
                 typescript-fmt-on-save t
                 typescript-fmt-tool 'tide
                 typescript-linter 'tslint
                 typescript-lsp-linter t)
     typography
     (version-control :variables
                      version-control-diff-side 'left
                      version-control-diff-tool 'git-gutter
                      version-control-global-margin t)
     vimscript
     vinegar
     yaml)

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages
   '(
     amx ;; depends on ido-completing-read+
     (beacon :location (recipe :fetcher github :repo "Malabarba/beacon"))
     coffee-mode
     company-jedi
     company-prescient
     csv-mode
     dimmer
     direnv
     (doom-modeline :location (recipe :fetcher github :repo "jmromer/doom-modeline"))
     editorconfig
     elpy
     emmet-mode
     evil-collection
     evil-lion
     evil-quickscope
     evil-rails
     evil-text-object-python
     flx
     graphql-mode
     gxref
     ido-completing-read+ ;; dependency of amx
     multi-vterm
     (org-pretty-table :location (recipe :fetcher github :repo "Fuco1/org-pretty-table"))
     (org-books :location (recipe :fetcher github :repo "lepisma/org-books"))
     (org-expand :location (recipe :fetcher github :repo "lepisma/org-expand"))
     ov
     prescient
     pretty-mode
     rjsx-mode
     (rufo :location (recipe :fetcher github :repo "aleandros/emacs-rufo" :branch "master"))
     toc-org
     writeroom-mode
     (yankee :location (recipe :fetcher github :repo "jmromer/yankee.el" :branch "develop")))

   dotspacemacs-frozen-packages
   '()

   dotspacemacs-excluded-packages
   '(
     fancy-battery
     treemacs
     treemacs-icons-dired
     web-beautify
     json-reformat
     )

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  (add-to-load-path "~/.spacemacs.d")
  (add-to-load-path "~/.spacemacs.d/local")
  ;; theme definitions
  (load "themes")

  ;; exec-path
  (setq-default
   exec-path '("/usr/local/opt/gettext/bin"
               "~/.bin"
               "~/.local/bin"
               "~/.anaconda/bin"
               "~/.asdf/shims"
               "~/.cargo/bin"
               "~/.go/bin"
               "./node_modules/.bin"
               "/usr/local/opt/asdf/bin"
               "/usr/local/opt/coreutils/libexec/gnubin"
               "/usr/local/opt/gnu-bin/libexec/gnubin"
               "/usr/local/opt/gnu-indent/libexec/gnubin"
               "/usr/local/opt/gnu-sed/libexec/gnubin"
               "/usr/local/opt/gnu-tar/libexec/gnubin"
               "/usr/local/opt/gnu-which/libexec/gnubin"
               "/usr/local/opt/gnutls/libexec/gnubin"
               "/usr/local/opt/findutils/libexec/gnubin"
               "/usr/local/opt/imagemagick@6/bin"
               "~/.gem/ruby/2.6.0/bin"
               "/usr/local/opt/fzf/bin"
               "/usr/local/heroku/bin"
               "/usr/local/bin"
               "/usr/local/sbin"
               "/usr/bin"
               "/usr/sbin"
               "/bin"
               "/sbin"
               "/opt/X11/bin"
               "~/Library/Android/sdk/tools/bin"
               "/Library/TeX/texbin"
               "/Applications/Emacs.app/Contents/MacOS/libexec"
               "/Applications/Emacs.app/Contents/MacOS/bin"))

  ;; Separate server socket location for CLI emacs
  (when (not window-system)
    (setq-default server-socket-dir (getenv "EMACS_SOCKET_DIR")))

  (setq-default
   ;; set evil-collection vars before loading evil
   evil-want-integration t
   evil-want-keybinding nil
   ;; don't create lockfiles
   create-lockfiles nil
   ;; don't soft-wrap lines
   truncate-lines t
   truncate-partial-width-windows 80
   ;; don't warn about large files
   large-file-warning-threshold nil))

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration.")

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration."
  (defun message-banner (msg)
    "Print MSG banner to the messages buffer."
    (let ((template "%s [%s] %s")
          (dashes (make-string 25 ?-)))
      (message (format template dashes msg dashes))))

  ;; postpone garbage collection during startup
  (let ((gc-cons-threshold most-positive-fixnum))
    (load "xwwp/xwwp.el")
    (require 'xwwp)

    ;; interactive functions
    (load "funcs")
    ;; package config functions
    (load "configs")
    ;; setup config
    (load "setup")
    ;; setup keybindings
    (load "keybindings")
    ;; overrides of package methods
    (load "overrides")
    ;; load local config
    (load "~/.init.local"))

  (message-banner "done configuring emacs"))

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variables.
