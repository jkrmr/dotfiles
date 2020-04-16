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
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

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
                                (projects . 7)
                                (bookmarks . 5)
                                (agenda . 5)
                                (todos . 5))

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
   dotspacemacs-auto-generate-layout-names nil

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
   dotspacemacs-inactive-transparency 90

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
                      auto-completion-enable-sort-by-usage t
                      auto-completion-idle-delay 0.01
                      auto-completion-private-snippets-directory "~/.spacemacs.d/snippets"
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'complete
                      auto-completion-use-company-box t
                      company-box-doc-delay 0
                      company-minimum-prefix-length 1
                      company-selection-wrap-around t
                      company-show-numbers t
                      company-tooltip-idle-delay 1)
     better-defaults
     bm
     (c-c++ :variables
            c-c++-enable-clang-support t)
     colors
     command-log
     copy-as-format
     csv
     dap
     (dash :variables
           helm-dash-docset-newpath "~/Library/Application Support/Dash/DocSets/")
     (deft :variables
       deft-auto-save-interval 10
       deft-default-extension "org"
       deft-directory "~/Dropbox/deft"
       deft-extensions '("txt" "text" "tex" "md" "markdown" "org")
       deft-recursive t)
     django
     (docker :variables
             docker-dockerfile-backend 'lsp)
     (elixir :variables
             flycheck-elixir-credo-strict t)
     (elm :variables
          elm-sort-imports-on-save t
          elm-format-on-save t
          elm-format-command "elm-format")
     emacs-lisp
     emoji
     epub
     erlang
     evil-commentary
     finance
     (git :variables
          git-magit-status-fullscreen t)
     github
     (go :variables
         go-backend 'lsp
         go-format-before-save t
         go-use-golangci-lint t
         go-use-gometalinter t
         go-tab-width 4
         godoc-at-point-function 'godoc-gogetdoc
         gofmt-command "goimports")
     graphviz
     (gtags :variables
            gtags-enable-by-default t
            ;; Add GNU Global as an xref-backend
            xref-backend-functions '(ggtags--xref-backend
                                     elisp--xref-backend
                                     gxref-xref-backend
                                     etags--xref-backend))
     haskell
     (helm :variables
           completion-styles '(helm-flex)
           helm-candidate-number-limit 100
           helm-completion-style 'emacs
           helm-display-header-line nil
           helm-enable-auto-resize t
           helm-no-header t
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
                 prettier-js-command "prettier-standard"
                 prettier-js-show-errors 'echo
                 node-add-modules-path t)
     (latex :variables
            latex-enable-auto-fill t
            latex-enable-folding t)
     (lsp :variables
          lsp-navigation 'both
          lsp-ui-remap-xref-keybindings t
          lsp-ui-doc-enable t
          lsp-ui-doc-include-signature t
          lsp-ui-sideline-enable t
          lsp-ui-sideline-ignore-duplicate t
          lsp-ui-sideline-show-symbol t)
     (markdown :variables
               markdown-asymmetric-header t
               markdown-live-preview-engine 'vmd)
     multiple-cursors
     nginx
     (org :variables
          org-agenda-files '("~/Dropbox/org")
          org-agenda-window-setup 'current-window
          org-archive-location "~/Dropbox/org/archive.org::* %s"
          org-default-backlog-file "~/Dropbox/org/sprint-backlog.org"
          org-default-blog-file "~/Dropbox/org/blog/blog.org"
          org-default-notes-file "~/Dropbox/org/sprint-today.org"
          org-directory "~/Dropbox/org"
          org-enable-bootstrap-support t
          org-enable-github-support t
          org-enable-hugo-support t
          org-enable-org-journal-support t
          org-enable-reveal-js-support t
          org-hugo-export-with-section-numbers nil
          org-hugo-export-with-toc nil
          org-journal-dir "~/Dropbox/org/journal"
          org-journal-file-format "%Y%m%d"
          org-journal-file-type 'monthly
          org-journal-find-file #'find-file
          org-outline-path-complete-in-steps nil
          org-projectile-file "TODOS.org"
          org-refile-allow-creating-parent-nodes 'confirm
          org-refile-targets '(("~/Dropbox/org/sprint-today.org" :maxlevel . 1)
                               ("~/Dropbox/org/sprint-backlog.org" :maxlevel . 1))
          org-refile-use-outline-path 'file)
     (osx :variables
          osx-command-as 'hyper
          osx-control-as 'control
          osx-function-as nil
          osx-option-as 'meta
          osx-right-command-as 'left
          osx-right-control-as 'left
          osx-right-option-as 'none)
     (parinfer :variables
               parinfer-extensions '(defaults
                                      pretty-parens
                                      evil
                                      paredit
                                      smart-tab
                                      smart-yank))
     pdf
     phoenix
     prettier
     prodigy
     (python :variables
             python-backend 'lsp
             python-fill-docstring-style 'django
             python-format-on-save t
             python-formatter 'yapf
             python-guess-indent nil
             python-indent-offset 4
             python-lsp-server 'mspyls
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
           ruby-backend 'robe
           ruby-current-line nil
           ruby-enable-enh-ruby-mode nil
           ruby-format-on-save nil
           ruby-test-rspec-options '()
           ruby-test-runner 'rspec
           ruby-version-manager nil)
     ruby-on-rails
     rust
     search-engine
     semantic
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
          sql-capitalize-keywords t
          sql-auto-indent t)
     (syntax-checking :variables
                      flycheck-disabled-checkers '(javascript-jshint
                                                   ruby-reek
                                                   markdown-mdl)
                      syntax-checking-enable-by-default t
                      syntax-checking-enable-tooltips t)
     theming
     (treemacs :variables
               treemacs-follow-after-init nil
               treemacs-use-git-mode 'simple
               treemacs-collapse-dirs 3
               treemacs-lock-width t
               treemacs-use-filewatch-mode t
               treemacs-use-follow-mode t)
     (typescript :variables
                 typescript-backend 'tide
                 typescript-lsp-linter nil
                 typescript-fmt-tool 'typescript-formatter
                 typescript-linter 'tslint
                 typescript-fmt-on-save t)
     typography
     (version-control :variables
                      version-control-diff-tool 'git-gutter
                      version-control-global-margin t
                      version-control-diff-side 'left)
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
     csv-mode
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
     (org-pretty-table :location (recipe :fetcher github :repo "Fuco1/org-pretty-table"))
     (org-books :location (recipe :fetcher github :repo "lepisma/org-books"))
     (org-expand :location (recipe :fetcher github :repo "lepisma/org-expand"))
     ov
     pretty-mode
     rjsx-mode
     (rufo :location (recipe :fetcher github :repo "aleandros/emacs-rufo" :branch "master"))
     toc-org
     writeroom-mode
     (yankee :location (recipe :fetcher github :repo "jmromer/yankee.el" :branch "develop"))
     )


   dotspacemacs-frozen-packages
   '()
   dotspacemacs-excluded-packages
   '(
     importmagic
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

  ;; color scheme definitions
  (load "colors")

  ;; exec-path
  (setq-default
   exec-path '("/usr/local/opt/gettext/bin"
               "~/.bin"
               "~/.local/bin"
               "~/.anaconda/bin"
               "~/.asdf/shims"
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

  ;; set these before loading evil
  (setq-default evil-want-integration t
                evil-want-keybinding nil)

  (setq-default
   ;; don't create lockfiles
   create-lockfiles nil
   ;; don't soft-wrap lines
   truncate-lines t
   truncate-partial-width-windows t
   ;; don't warn about large files
   large-file-warning-threshold nil))

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration.")

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration."
  ;; define interactive functions
  (load "functions")

  ;; define package configurations
  (load "config-functions")

  ;; define overrides of package methods
  (load "overrides")

  ;; set customizations, invoke customization functions
  (load "customizations")

  (message-banner "done configuring emacs"))

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variables.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(evil-want-Y-yank-to-eol nil)
   '(package-selected-packages
     (quote
      (company-jedi jedi-core python-environment epc ctable concurrent yasnippet-snippets yapfify yankee yaml-mode xterm-color ws-butler writeroom-mode winum which-key web-mode web-beautify vterm volatile-highlights vmd-mode vimrc-mode vi-tilde-fringe uuidgen use-package unfill typo treemacs-projectile treemacs-persp treemacs-magit treemacs-evil toml-mode toc-org tide terminal-here tagedit symon symbol-overlay string-inflection stickyfunc-enhance srefactor sqlup-mode sql-indent spray spaceline-all-the-icons smeargle slim-mode shell-pop seeing-is-believing scss-mode sass-mode rvm rufo ruby-tools ruby-test-mode ruby-refactor ruby-hash-syntax rubocopfmt rubocop rspec-mode robe rjsx-mode reveal-in-osx-finder restclient-helm restart-emacs rbenv rainbow-mode rainbow-identifiers rainbow-delimiters racer pytest pyenv-mode py-isort pug-mode prodigy pretty-mode prettier-js popwin pony-mode pippel pipenv pip-requirements pdf-tools password-generator parinfer paradox ox-twbs ox-hugo ox-gfm overseer ov osx-trash osx-dictionary osx-clipboard orgit org-re-reveal org-projectile org-pretty-table org-present org-pomodoro org-mime org-journal org-expand org-download org-cliplink org-bullets org-brain org-books open-junk-file ob-restclient ob-http ob-elixir nov nodejs-repl nginx-mode nameless mwim multi-term move-text mmm-mode minitest markdown-toc magit-svn magit-section magit-gitflow macrostep lsp-ui lsp-python-ms lsp-haskell lorem-ipsum livid-mode live-py-mode link-hint launchctl json-navigator js2-refactor js-doc intero insert-shebang indent-guide impatient-mode ibuffer-projectile hybrid-mode hungry-delete hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers helpful helm-xref helm-themes helm-swoop helm-rtags helm-pydoc helm-purpose helm-projectile helm-org-rifle helm-mode-manager helm-make helm-lsp helm-ls-git helm-hoogle helm-gtags helm-gitignore helm-git-grep helm-flx helm-descbinds helm-dash helm-css-scss helm-company helm-c-yasnippet helm-ag haskell-snippets gxref graphviz-dot-mode graphql-mode google-translate google-c-style golden-ratio godoctor go-tag go-rename go-impl go-guru go-gen-test go-fill-struct go-eldoc gnuplot gitignore-templates github-search github-clone gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe gist gh-md ggtags fuzzy forge font-lock+ flyspell-correct-helm flycheck-ycmd flycheck-rust flycheck-rtags flycheck-pos-tip flycheck-package flycheck-mix flycheck-ledger flycheck-haskell flycheck-golangci-lint flycheck-elsa flycheck-elm flycheck-credo flycheck-bashate flx-ido fish-mode fill-column-indicator feature-mode fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-textobj-line evil-text-object-python evil-surround evil-rails evil-quickscope evil-org evil-numbers evil-mc evil-matchit evil-magit evil-lisp-state evil-lion evil-ledger evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-commentary evil-collection evil-cleverparens evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help erlang engine-mode emojify emoji-cheat-sheet-plus emmet-mode elpy elm-test-runner elm-mode elisp-slime-nav editorconfig dumb-jump dotenv-mode doom-modeline dockerfile-mode docker disaster direnv diminish devdocs deft dash-at-point dap-mode dante dactyl-mode cython-mode csv-mode cquery cpp-auto-include company-ycmd company-web company-tern company-statistics company-shell company-rtags company-restclient company-reftex company-quickhelp company-lsp company-go company-ghci company-ghc company-emoji company-cabal company-c-headers company-box company-auctex company-anaconda command-log-mode column-enforce-mode color-identifiers-mode coffee-mode cmm-mode clean-aindent-mode clang-format chruby centered-cursor-mode ccls cargo bundler browse-at-remote bm blacken beacon auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile auctex-latexmk attrap amx alchemist aggressive-indent add-node-modules-path ace-link ace-jump-helm-line ac-ispell)))
   '(safe-local-variable-values
     (quote
      ((javascript-fmt-tool)
       (ruby-format-on-save)
       (hugo-section . commonplaces)
       (hugo-section . notes)
       (hugo-section . poetry)
       (hugo-section . blog)
       (hugo-section . marginalia)
       (hugo-base-dir . ~/Projects/blogs/jmromer)))))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(company-scrollbar-bg ((t (:background "#1C2028"))))
   '(company-scrollbar-fg ((t (:background "#505a6f"))))
   '(company-tooltip ((t (:background "#1C2028" :foreground "#7b87a0"))))
   '(company-tooltip-common ((t (:foreground "#81A1C1"))))
   '(company-tooltip-mouse ((t (:background "#81A1C1"))))
   '(company-tooltip-selection ((t (:background "#242934"))))
   '(company-tootip-annotation ((t (:foreground "#8FBCBB"))))
   '(cursor ((t (:background "#B48EAD"))))
   '(dired-subtree-depth-1-face ((t (:background nil))))
   '(dired-subtree-depth-2-face ((t (:background nil))))
   '(dired-subtree-depth-3-face ((t (:background nil))))
   '(dired-subtree-depth-4-face ((t (:background nil))))
   '(dired-subtree-depth-5-face ((t (:background nil))))
   '(dired-subtree-depth-6-face ((t (:background nil))))
   '(elfeed-search-feed-face ((t (:foreground "#81A1C1"))))
   '(eval-sexp-fu-flash ((t (:background "#5E81AC" :foreground "#ECEFF4"))))
   '(eval-sexp-fu-flash-error ((t (:background "#81A1C1" :foreground "#ECEFF4"))))
   '(evil-goggles-change-face ((t (:inherit diff-refine-removed))))
   '(evil-goggles-delete-face ((t (:inherit diff-refine-removed))))
   '(evil-goggles-paste-face ((t (:inherit diff-refine-added))))
   '(evil-goggles-undo-redo-add-face ((t (:inherit diff-refine-added))))
   '(evil-goggles-undo-redo-change-face ((t (:inherit diff-refine-changed))))
   '(evil-goggles-undo-redo-remove-face ((t (:inherit diff-refine-removed))))
   '(evil-goggles-yank-face ((t (:inherit diff-refine-changed))))
   '(fixed-pitch ((t (:family "Source Code Pro"))))
   '(flycheck-error ((t (:background nil))))
   '(flycheck-warning ((t (:background nil))))
   '(font-latex-sectioning-0-face ((t (:foreground "#8FBCBB" :height 1.2))))
   '(font-latex-sectioning-1-face ((t (:foreground "#8FBCBB" :height 1.1))))
   '(font-latex-sectioning-2-face ((t (:foreground "#8FBCBB" :height 1.1))))
   '(font-latex-sectioning-3-face ((t (:foreground "#8FBCBB" :height 1.0))))
   '(font-latex-sectioning-4-face ((t (:foreground "#8FBCBB" :height 1.0))))
   '(font-latex-sectioning-5-face ((t (:foreground "#8FBCBB" :height 1.0))))
   '(font-latex-verbatim-face ((t (:foreground "#8FBCBB"))))
   '(font-lock-builtin-face ((t (:foreground "#8FBCBB"))))
   '(font-lock-comment-face ((t (:foreground "#7b87a0" :slant italic))))
   '(font-lock-constant-face ((t (:foreground "#B48EAD"))))
   '(font-lock-doc-face ((t (:foreground "#7b87a0"))))
   '(font-lock-function-name-face ((t (:foreground "#88C0D0"))))
   '(font-lock-keyword-face ((t (:foreground "#81A1C1"))))
   '(font-lock-string-face ((t (:foreground "#A3BE8C"))))
   '(font-lock-type-face ((t (:foreground "#8FBCBB"))))
   '(font-lock-variable-name-face ((t (:foreground "#8a9899"))))
   '(git-gutter-fr:added ((t (:foreground "#A3BE8C"))))
   '(git-gutter-fr:modified ((t (:foreground "#5E81AC"))))
   '(header-line ((t (:background nil :inherit nil))))
   '(helm-M-x-key ((t (:foreground "#8FBCBB"))))
   '(helm-buffer-file ((t (:background nil))))
   '(helm-ff-directory ((t (:foreground "#8FBCBB"))))
   '(helm-ff-dotted-symlink-directory ((t (:background nil))))
   '(helm-ff-file ((t (:background nil))))
   '(helm-ff-prefix ((t (:foreground "#81A1C1"))))
   '(helm-ff-symlink ((t (:foreground "#81A1C1"))))
   '(helm-grep-match ((t (:foreground "#B48EAD"))))
   '(helm-match ((t (:foreground "#81A1C1"))))
   '(helm-separator ((t (:foreground "#81A1C1"))))
   '(highlight ((t (:background "#242934" :foreground "#ECEFF4"))))
   '(highlight-numbers-number ((t (:foreground "#B48EAD"))))
   '(hl-line ((t (:background "#20242e"))))
   '(ido-first-match ((t (:foreground "#B48EAD"))))
   '(js2-error ((t (:foreground nil :inherit font-lock-keyword-face))))
   '(js2-external-variable ((t (:foreground nil :inherit font-lock-variable-name-face))))
   '(js2-function-call ((t (:foreground nil :inherit font-lock-function-name-face))))
   '(js2-function-param ((t (:foreground nil :inherit font-lock-constant-face))))
   '(js2-instance-member ((t (:foreground nil :inherit font-lock-variable-face))))
   '(js2-jsdoc-html-tag-delimiter ((t (:foreground nil :inherit font-lock-type-face))))
   '(js2-jsdoc-html-tag-name ((t (:foreground nil :inherit font-lock-string-face))))
   '(js2-jsdoc-tag ((t (:foreground nil :inherit font-lock-comment-face))))
   '(js2-jsdoc-type ((t (:foreground nil :inherit font-lock-type-face))))
   '(js2-jsdoc-value ((t (:foreground nil :inherit font-lock-doc-face))))
   '(js2-object-property ((t (:foreground nil :inherit font-lock-type-face))))
   '(js2-object-property-access ((t (:foreground nil :inherit font-lock-type-face))))
   '(js2-private-function-call ((t (:foreground nil :inherit font-lock-function-name-face))))
   '(js2-private-member ((t (:foreground nil :inherit font-lock-builtin-face))))
   '(line-number-current-line ((t (:foreground "#8FBCBB"))))
   '(link ((t (:foreground "#81A1C1"))))
   '(linum ((t (:background nil))))
   '(lsp-face-highlight-read ((t (:background nil :foreground nil :underline "#5E81AC"))))
   '(lsp-face-highlight-textual ((t (:background nil :foreground nil :underline "#5E81AC"))))
   '(lsp-face-highlight-write ((t (:background nil :foreground nil :underline "#5E81AC"))))
   '(magit-branch-current ((t (:foreground "#B48EAD"))))
   '(magit-branch-local ((t (:foreground "#5E81AC"))))
   '(magit-branch-remote ((t (:foreground "#A3BE8C"))))
   '(magit-diff-added ((t (:background "#252822" :foreground "#88ab6b"))))
   '(magit-diff-added-highlight ((t (:background "#31362e" :foreground "#A3BE8C"))))
   '(magit-diff-file-heading-selection ((t (:background "#434C5E" :foreground "#ECEFF4"))))
   '(magit-diff-hunk-heading ((t (:background "#434C5E" :foreground "#7b87a0"))))
   '(magit-diff-hunk-heading-highlight ((t (:background "#434C5E" :foreground "#ECEFF4"))))
   '(magit-diff-lines-heading ((t (:background "#8FBCBB" :weight bold :foreground "#191d25"))))
   '(magit-diff-removed ((t (:background "#2a2929" :foreground "#a8444d"))))
   '(magit-diff-removed-highlight ((t (:background "#383535" :foreground "#BF616A"))))
   '(magit-header-line ((t (:background nil :foreground "#191d25" :box nil))))
   '(magit-log-author ((t (:foreground "#8FBCBB"))))
   '(magit-log-date ((t (:foreground "#5E81AC"))))
   '(magit-section-heading ((t (:foreground "#81A1C1"))))
   '(magit-section-heading-selection ((t (:foreground "#8a9899"))))
   '(markdown-blockquote-face ((t (:inherit org-quote :foreground nil))))
   '(markdown-bold-face ((t (:inherit bold :foreground nil))))
   '(markdown-code-face ((t (:inherit org-code :foreground nil))))
   '(markdown-header-delimiter-face ((t (:inherit org-level-1 :foreground "#7b87a0"))))
   '(markdown-header-face ((t (:inherit org-level-1 :foreground nil))))
   '(markdown-header-face-1 ((t (:inherit org-level-1 :foreground nil))))
   '(markdown-header-face-2 ((t (:inherit org-level-2 :foreground nil))))
   '(markdown-header-face-3 ((t (:inherit org-level-3 :foreground nil))))
   '(markdown-header-face-4 ((t (:inherit org-level-4 :foreground nil))))
   '(markdown-header-face-5 ((t (:inherit org-level-5 :foreground nil))))
   '(markdown-header-face-6 ((t (:inherit org-level-6 :foreground nil))))
   '(markdown-inline-code-face ((t (:inherit org-code))))
   '(markdown-italic-face ((t (:inherit italic :foreground nil))))
   '(markdown-link-face ((t (:inherit org-link :foreground nil))))
   '(markdown-list-face ((t (:inherit org-list-dt :foreground nil))))
   '(markdown-metadata-key-face ((t (:inherit font-lock-keyword-face :foreground nil))))
   '(markdown-pre-face ((t (:inherit org-block :foreground nil))))
   '(markdown-url-face ((t (:inherit org-link :foreground nil))))
   '(match ((t (:foreground nil :background nil :underline "#BF616A"))))
   '(minibuffer-prompt ((t (:foreground "#81A1C1"))))
   '(minimap-active-region-background ((t (:background "#434C5E"))))
   '(mmm-default-submode-face ((t (:background "#20242e"))))
   '(mode-line ((t (:background "#1C2028"))))
   '(mode-line-inactive ((t (:box nil))))
   '(org-agenda-current-time ((t (:foreground "#81A1C1"))))
   '(org-agenda-date ((t (:foreground "#7b87a0" :inherit variable-pitch :height 1.2))))
   '(org-agenda-date-today ((t (:height 1.4 :foreground "#81A1C1" :inherit variable-pitch))))
   '(org-agenda-date-weekend ((t (:inherit org-agenda-date :height 1.0 :foreground "#505a6f"))))
   '(org-agenda-done ((t (:inherit nil :strike-through t :foreground "#7b87a0"))))
   '(org-agenda-structure ((t (:height 1.3 :foreground "#7b87a0" :weight normal :inherit variable-pitch))))
   '(org-block ((t (:family "Source Code Pro" :height 1.0))))
   '(org-block-begin-line ((t (:background nil :height 0.8 :foreground "#81A1C1"))))
   '(org-block-end-line ((t (:background nil :height 0.8 :foreground "#81A1C1"))))
   '(org-code ((t (:foreground "#8FBCBB" :height 1.0 :family "Source Code Pro" :height 0.9))))
   '(org-column ((t (:background nil :weight bold))))
   '(org-column-title ((t (:background nil :underline t))))
   '(org-date ((t (:foreground "#7b87a0"))))
   '(org-document-info ((t (:foreground "#7b87a0" :slant italic))))
   '(org-document-info-keyword ((t (:foreground "#505a6f"))))
   '(org-document-title ((t (:inherit variable-pitch :height 1.3 :weight normal :foreground "#7b87a0" :underline nil))))
   '(org-done ((t (:inherit variable-pitch :foreground "#5E81AC"))))
   '(org-ellipsis ((t (:underline nil :background nil :foreground "#7b87a0"))))
   '(org-formula ((t (:foreground "#8FBCBB"))))
   '(org-headline-done ((t (:strike-through t))))
   '(org-indent ((t (:inherit org-hide))))
   '(org-level-1 ((t (:inherit variable-pitch :height 1.1 :weight bold :foreground "#81A1C1"))))
   '(org-level-2 ((t (:inherit variable-pitch :weight bold :height 1.1 :foreground "#8a9899"))))
   '(org-level-3 ((t (:inherit variable-pitch :weight bold :height 1.1 :foreground "#7b87a0"))))
   '(org-level-4 ((t (:inherit variable-pitch :weight bold :height 1.0 :foreground "#7b87a0"))))
   '(org-level-5 ((t (:inherit variable-pitch :weight bold :height 1.0 :foreground "#7b87a0"))))
   '(org-level-6 ((t (:inherit variable-pitch :weight bold :height 1.0 :foreground "#7b87a0"))))
   '(org-level-7 ((t (:inherit variable-pitch :weight bold :height 1.0 :foreground "#7b87a0"))))
   '(org-level-8 ((t (:inherit variable-pitch :weight bold :height 1.0 :foreground "#7b87a0"))))
   '(org-link ((t (:underline nil :weight normal :foreground "#81A1C1"))))
   '(org-list-dt ((t (:foreground "#88C0D0"))))
   '(org-quote ((t (:slant italic :family "EtBembo"))))
   '(org-ref-cite-face ((t (:foreground "#8FBCBB"))))
   '(org-ref-ref-face ((t (:foreground nil :inherit org-link))))
   '(org-scheduled ((t (:foreground "#7b87a0"))))
   '(org-scheduled-previously ((t (:foreground "#81A1C1"))))
   '(org-scheduled-today ((t (:foreground "#ECEFF4"))))
   '(org-special-keyword ((t (:height 0.9 :foreground "#505a6f"))))
   '(org-table ((t (:inherit fixed-pitch :background nil :foreground "#7b87a0"))))
   '(org-tag ((t (:foreground "#7b87a0"))))
   '(org-time-grid ((t (:foreground "#505a6f"))))
   '(org-todo ((t (:foreground "#8FBCBB" :background nil))))
   '(org-upcoming-deadline ((t (:foreground "#81A1C1"))))
   '(org-variable-pitch-face ((t (:height 0.9))))
   '(org-verbatim ((t (:foreground "#8FBCBB"))))
   '(org-warning ((t (:foreground "#8FBCBB"))))
   '(powerline-active1 ((t (:background "#FEFFF9"))))
   '(powerline-active2 ((t (:background "#FEFFF9"))))
   '(powerline-inactive1 ((t (:background "#FEFFF9"))))
   '(powerline-inactive2 ((t (:background "#FEFFF9"))))
   '(rainbow-delimiters-depth-1-face ((t (:foreground "#5E81AC"))))
   '(rainbow-delimiters-depth-2-face ((t (:foreground "#81A1C1"))))
   '(rainbow-delimiters-depth-3-face ((t (:foreground "#B48EAD"))))
   '(rainbow-delimiters-depth-4-face ((t (:foreground "#8FBCBB"))))
   '(rainbow-delimiters-depth-5-face ((t (:foreground "#81A1C1"))))
   '(rainbow-delimiters-depth-6-face ((t (:foreground "#A3BE8C"))))
   '(rainbow-delimiters-depth-7-face ((t (:foreground "#88C0D0"))))
   '(rainbow-delimiters-depth-8-face ((t (:foreground "#8a9899"))))
   '(rainbow-delimiters-depth-9-face ((t (:foreground "#8FBCBB"))))
   '(region ((t (:background "#434C5E"))))
   '(show-paren-match ((t (:background "#81A1C1" :foreground "#191d25"))))
   '(sldb-restartable-frame-line-face ((t (:foreground "#A3BE8C"))))
   '(slime-repl-inputed-output-face ((t (:foreground "#81A1C1"))))
   '(solaire-default-face ((t (:background "#20242e"))))
   '(solaire-hl-line-face ((t (:background "#20242e"))))
   '(sp-pair-overlay-face ((t (:background "#20242e"))))
   '(sp-show-pair-match-face ((t (:background "#505a6f" :foreground "#8a9899"))))
   '(sp-wrap-overlay-face ((t (:background "#20242e"))))
   '(spacemacs-emacs-face ((t (:background "#191d25" :foreground "#ECEFF4"))))
   '(spacemacs-evilified-face ((t (:background "#191d25" :foreground "#ECEFF4"))))
   '(spacemacs-hybrid-face ((t (:background "#191d25" :foreground "#ECEFF4"))))
   '(spacemacs-lisp-face ((t (:background "#191d25" :foreground "#ECEFF4"))))
   '(spacemacs-motion-face ((t (:background "#191d25" :foreground "#ECEFF4"))))
   '(spacemacs-normal-face ((t (:background "#191d25" :foreground "#ECEFF4"))))
   '(spacemacs-visual-face ((t (:background "#191d25" :foreground "#ECEFF4"))))
   '(swiper-line-face ((t (:background "#434C5E" :foreground "#ECEFF4"))))
   '(swiper-match-face-2 ((t (:background "#8FBCBB"))))
   '(tooltip ((t (:foreground "#7b87a0" :background "#1C2028"))))
   '(treemacs-directory-collapsed-face ((t (:foreground "#ECEFF4"))))
   '(treemacs-git-added-face ((t (:foreground "#A3BE8C"))))
   '(treemacs-git-conflict-face ((t (:foreground "#BF616A"))))
   '(treemacs-git-modified-face ((t (:foreground "#B48EAD"))))
   '(treemacs-git-unmodified-face ((t (:foreground "#ECEFF4"))))
   '(treemacs-root-face ((t (:foreground "#81A1C1" :height 1.1))))
   '(treemacs-tags-face ((t (:foreground "#81A1C1" :height 0.9))))
   '(variable-pitch ((t (:family "Source Sans Pro" :height 1.1))))
   '(vertical-border ((t (:background "#434C5E" :foreground "#434C5E"))))
   '(which-key-command-description-face ((t (:foreground "#8FBCBB"))))
   '(which-key-key-face ((t (:foreground "#A3BE8C")))))
  )
