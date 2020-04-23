;;; setup.el --- Emacs configuration customizations.

;;; Commentary:

;;; Code:
(require 'funcs)
(require 'editorconfig)


;;; Package configs

(config/copy-as-format)
(config/evil-collection)
(config/evil-goggles)
(config/flycheck)
(config/google-translate)
(config/highlight-lines-at-length 80)
(config/javascript-modes)
(config/latex-mode)
(config/lisps)
(config/org-latex-preview)
(config/org-mode)
(config/python)
(config/ruby)
(config/shell-buffers)
(config/underscore-to-word-char-list)
(config/web-mode)


;;; Misc settings

(setq-default
 persp-restore-window-conf-method #'no-op
 browse-url-browser-function 'xwidget-webkit-browse-url
 compilation-scroll-output 'first-error
 ido-enable-flex-matching t
 ido-use-faces nil  ;; disable ido faces to see flx highlights
 ispell-program-name "ispell"
 lsp-signature-auto-activate nil  ;; lsp: don't auto-activate signature hints
 json-fmt-on-save nil
 json-fmt-tool 'prettier
 mac-command-modifier 'super
 projectile-completion-system 'helm
 projectile-enable-caching t
 projectile-find-dir-includes-top-level t
 projectile-project-search-path '("~/Projects" "~/Work" "~/Resources" "~/Exercism" "~/Tutorials")
 tramp-default-method "ssh")


;;; Projectile

(with-eval-after-load 'projectile
  (projectile-register-project-type
   'elixir-mix '("mix.exs"
                 :compile "mix compile"
                 :test "mix test"
                 :test-suffix "_test"))
  (projectile-register-project-type
   'python-pipenv '("Pipfile"
                    :compile "pipenv run compile"
                    :test "pipenv run test"
                    :test-suffix "_test"))
  (projectile-register-project-type
   'python-pytest '(".pytest_cache"
                    :compile ""
                    :test "pytest"
                    :test-prefix "test_"
                    :test-suffix "_test"))
  (projectile-register-project-type
   'rails-rspec '("Gemfile" "app" "lib" "db" "config" "spec"
                  :compile "bin/rails server"
                  :src-dir "lib/"
                  :test "bin/rspec --no-profile --format progress"
                  :test-dir "spec/"
                  :test-suffix "_spec"
                  :related-files-fn #'rails--find-related-file))

  (if (boundp 'projectile-globally-ignored-directories)
      (add-to-list 'projectile-globally-ignored-directories "node_modules" t)))



;;; Appearance

;; ensure new frames are created transparent
(add-hook 'after-make-frame-functions #'spacemacs/enable-transparency)

;; make the current one transparent
(spacemacs/enable-transparency)

;; Natural titlebar in GUI
(when window-system
  (add-to-list 'default-frame-alist '(ns-appearance . dark))
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))



;;; Emoji

;; Render unicode emoji as emoji
(defun set-emoji-font (frame)
  "Render unicode emoji as emoji.
Adjust the font settings of the given FRAME to do this."
  (if (eq system-type 'darwin)
      (set-fontset-font t 'unicode (font-spec :family "Apple Color Emoji") frame 'prepend)
    (set-fontset-font t 'unicode (font-spec :family "Symbola") frame 'prepend)))

(if window-system
    (set-emoji-font nil)
  (add-hook 'after-make-frame-functions #'set-emoji-font))



;;; Globally enabled minor modes

(beacon-mode)
(editorconfig-mode)
(global-evil-matchit-mode)
(global-evil-quickscope-mode)
(ido-mode)  ;; ido (for amx, ido-dired)
(flx-ido-mode 1)
(direnv-mode)
(smartparens-global-strict-mode)
(global-visual-line-mode)
(company-prescient-mode)
(prescient-persist-mode)



;; Hooks

;; after-init hooks
(add-hook 'after-init-hook #'global-emojify-mode)
(add-hook 'after-init-hook #'global-company-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; mode-specific hooks
(add-hook 'elixir-mode-hook #'lsp)
(add-hook 'ledger-mode-hook #'evil-ledger-mode)

(with-eval-after-load 'elm-mode
  (remove-hook 'elm-mode-hook 'elm-indent-mode))



;;; Garbage collection optimizations

(defun disable-garbage-collection ()
  "Disable GC by setting threshold to max num."
  (setq-default gc-cons-threshold most-positive-fixnum))

(defun enable-garbage-collection ()
  "Re-enable GC collection. Set threshold to init.el value."
  (defvar dotspacemacs-gc-cons)
  (setq-default gc-cons-threshold (car dotspacemacs-gc-cons)))

(add-hook 'minibuffer-setup-hook #'disable-garbage-collection)
(add-hook 'minibuffer-exit-hook #'enable-garbage-collection)



;;; "Tail" settings (should be run last)

(config/prettify-symbols)
(config/company)

(provide 'setup)
;;; setup.el ends here
