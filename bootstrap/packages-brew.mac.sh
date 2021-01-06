#!/usr/bin/env bash

brew install qt
brew install octave
brew install gnuplot

brew install osxutils
brew install pinentry-mac

brew install reattach-to-user-namespace
brew install github/gh/gh

<<<<<<< HEAD
# emacs-plus: Emacs 27 or 28 (with jansson)
# brew tap d12frosted/emacs-plus
#
# brew install emacs-plus --HEAD --with-no-frame-refocus --with-no-titlebar --with-xwidgets
brew install emacs-plus@28 --with-no-frame-refocus --with-no-titlebar --with-xwidgets --with-native-comp
tic -o ~/.terminfo "/usr/local/share/emacs/28.0.50/etc/e/eterm-color.ti"

# emacs-head: Emacs 28 (with jansson, xwidgets, multicolor fonts)
# brew tap daviderestivo/emacs-head
# brew install emacs-head@28 \
#   --with-cocoa \
#   --with-imagemagick \
#   --with-modern-icon-black-variant \
#   --with-multicolor-fonts \
#   --with-no-frame-refocus \
#   --with-pdumper \
#   --with-xwidgets
#
# ln -sf /usr/local/opt/emacs-head/Emacs.app /Applications
# tic -o ~/.terminfo /usr/local/opt/emacs-head@28/share/emacs/28.0.50/etc/e/eterm-color.ti

# emacs-plus: Emacs 27
# brew install --cask emacs

# emacs-mac: Emacs 27 macos-patched (includes jansson, no xwidgets)
||||||| parent of 84859cb (Bootstrap: Update emacs 28 installation)
# emacs-mac (potentially slower / unstable)
=======
# emacs-plus: Emacs 27 or 28 (with jansson)
# brew tap d12frosted/emacs-plus
#
# brew install emacs-plus --HEAD --with-no-frame-refocus --with-no-titlebar --with-xwidgets
brew install emacs-plus@28 --with-no-frame-refocus --with-no-titlebar --with-xwidgets --with-native-comp
tic -o ~/.terminfo "/usr/local/share/emacs/28.0.50/etc/e/eterm-color.ti"

# emacs-head: Emacs 28 (with jansson, xwidgets, multicolor fonts)
# brew tap daviderestivo/emacs-head
# brew install emacs-head@28 \
#   --with-cocoa \
#   --with-imagemagick \
#   --with-modern-icon-black-variant \
#   --with-multicolor-fonts \
#   --with-no-frame-refocus \
#   --with-pdumper \
#   --with-xwidgets
#
# ln -sf /usr/local/opt/emacs-head/Emacs.app /Applications
# tic -o ~/.terminfo /usr/local/opt/emacs-head@28/share/emacs/28.0.50/etc/e/eterm-color.ti

# emacs-plus: Emacs 27
# brew install --cask emacs

# emacs-mac: Emacs 27 macos-patched (includes jansson, no xwidgets)
>>>>>>> 84859cb (Bootstrap: Update emacs 28 installation)
# brew tap railwaycat/emacsmacport
# brew install emacs-mac --with-imagemagick --with-natural-title-bar --with-rsvg --with-modern-icon

