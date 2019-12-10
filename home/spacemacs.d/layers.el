;;; layers.el --- Summary

;; Spacemacs layer configuration

;;; Commentary:

;; Defines `dotspacemacs/layers'

;;; Code:
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
                      auto-completion-idle-delay 0.0
                      auto-completion-private-snippets-directory "~/.spacemacs.d/snippets"
                      auto-completion-return-key-behavior 'complete
                      auto-completion-use-company-box t
                      auto-completion-tab-key-behavior 'complete)
     better-defaults
     bm
     (c-c++ :variables
            c-c++-enable-clang-support t)
     colors
     command-log
     copy-as-format
     csv
     (dash :variables
           helm-dash-docset-newpath "~/Library/Application Support/Dash/DocSets/")
     deft
     django
     docker
     elixir
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
     git
     github
     (go :variables
         go-backend 'lsp
         gofmt-command "goimports"
         go-use-gometalinter t
         go-format-before-save t
         go-tab-width 4)
     graphviz
     (gtags :variables
            gtags-enable-by-default t)
     haskell
     (helm :variables
           helm-enable-auto-resize t
           helm-no-header nil
           helm-position 'bottom
           helm-use-fuzzy 'always
           spacemacs-helm-rg-max-column-number 512)
     helpful
     (html :variables
           web-fmt-tool 'prettier)
     (ibuffer :variables
              ibuffer-group-buffers-by 'projects)
     imenu-list
     ipython-notebook
     (javascript :variables
                 javascript-backend 'tern
                 javascript-fmt-tool 'prettier
                 node-add-modules-path t)
     (latex :variables
            latex-enable-auto-fill t
            latex-enable-folding t)
     (lsp :variables
          lsp-navigation 'both
          lsp-ui-remap-xref-keybindings nil
          lsp-ui-doc-enable t
          lsp-ui-doc-include-signature nil
          lsp-ui-sideline-enable nil
          lsp-ui-sideline-show-symbol nil)
     (markdown :variables
               markdown-live-preview-engine 'vmd)
     multiple-cursors
     nginx
     (org :variables
          org-enable-bootstrap-support t
          org-enable-github-support t
          org-enable-hugo-support t
          org-enable-org-journal-support t
          org-enable-reveal-js-support t
          org-journal-dir "~/Dropbox/org/journal"
          org-projectile-file "TODOS.org")
     (osx :variables
          osx-command-as 'hyper
          osx-control-as 'control
          osx-function-as nil
          osx-option-as 'meta
          osx-right-command-as 'left
          osx-right-control-as 'left
          osx-right-option-as 'none)
     parinfer
     pdf
     phoenix
     prettier
     prodigy
     (python :variables
             python-backend 'lsp
             python-format-on-save t
             python-formatter 'yapf
             python-fill-docstring-style 'django
             python-save-before-test t
             python-sort-imports-on-save t
             python-test-runner 'pytest)
     react
     restclient
     (ruby :variables
           ruby-enable-enh-ruby-mode nil
           ruby-backend 'robe
           ruby-version-manager nil
           ruby-test-runner 'rspec)
     ruby-on-rails
     rust
     scala
     search-engine
     semantic
     (shell :variables
            multi-term-program "zsh"
            shell-default-full-span nil
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-shell 'multi-term
            shell-default-term-shell "zsh"
            shell-enable-smart-eshell nil)
     shell-scripts
     speed-reading
     spell-checking
     (sql :variables
          sql-capitalize-keywords t
          sql-auto-indent t)
     (syntax-checking :variables
                      syntax-checking-enable-by-default t
                      syntax-checking-enable-tooltips t)
     theming
     (treemacs :variables
               treemacs-follow-after-init nil
               treemacs-use-filewatch-mode t
               treemacs-use-follow-mode t)
     typescript
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
     amx
     (beacon :location (recipe :fetcher github :repo "Malabarba/beacon"))
     coffee-mode
     company-flx
     csv-mode
     direnv
     (doom-modeline :location (recipe :fetcher github :repo "jmromer/doom-modeline"))
     editorconfig
     emmet-mode
     evil-collection
     evil-lion
     evil-quickscope
     evil-rails
     evil-text-object-python
     flx
     graphql-mode
     gxref
     magit-todos
     (org-pretty-table :location (recipe :fetcher github :repo "Fuco1/org-pretty-table"))
     (org-books :location (recipe :fetcher github :repo "lepisma/org-books"))
     (org-expand :location (recipe :fetcher github :repo "lepisma/org-expand"))
     ov
     pretty-mode
     rjsx-mode
     (rufo :location (recipe :fetcher github :repo "aleandros/emacs-rufo" :branch "master"))
     toc-org
     traad
     writeroom-mode
     (yankee :location (recipe :fetcher github :repo "jmromer/yankee.el" :branch "develop"))
     )

   dotspacemacs-frozen-packages
   '()
   dotspacemacs-excluded-packages
   '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))
