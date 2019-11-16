#!/usr/bin/env bash

brew install qt
brew install octave
brew install gnuplot

brew install osxutils
brew install pinentry-mac

brew install reattach-to-user-namespace

# brew tap railwaycat/emacsmacport
# brew cask install emacs-mac-spacemacs-icon

brew tap d12frosted/emacs-plus
brew install emacs-plus --with-no-frame-refocus --with-no-titlebar
ln -s /usr/local/opt/emacs-plus/Emacs.app /Applications
brew services start d12frosted/emacs-plus/emacs-plus

emacs_version="$(emacs --version | head -1 | sed -E 's/.+\s([0-9]+\.[0-9]+)$/\1/')"
tic -o ~/.terminfo "/usr/local/share/emacs/$emacs_version/etc/e/eterm-color.ti"
