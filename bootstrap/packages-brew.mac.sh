#!/usr/bin/env bash

brew install qt
brew install octave
brew install gnuplot

brew install osxutils
brew install pinentry-mac

brew install reattach-to-user-namespace
brew install github/gh/gh

# emacs-mac (potentially slower / unstable)
# brew tap railwaycat/emacsmacport
# brew install emacs-mac \
#   --with-dbus \
#   --with-glib \
#   --with-imagemagick \
#   --with-modern-icon \
#   --with-modules \
#   --with-natural-title-bar \
#   --with-rsvg \
#   --with-xml2
# ln -sf /usr/local/opt/emacs-mac/Emacs.app /Applications

# emacs-plus
# brew tap d12frosted/emacs-plus
# brew install emacs-plus
# brew services start d12frosted/emacs-plus/emacs-plus
# ln -s /usr/local/opt/emacs-plus/Emacs.app /Applications

# emacs_version="$(emacs --version | head -1 | sed -E 's/.+\s([0-9]+\.[0-9]+)$/\1/')"
# tic -o ~/.terminfo "/usr/local/share/emacs/$emacs_version/etc/e/eterm-color.ti"

brew tap daviderestivo/emacs-head
brew install emacs-head \
  --HEAD \
  --with-cocoa \
  --with-imagemagick \
  --with-jansson \
  --with-modern-icon-black-variant \
  --with-no-frame-refocus \
  --with-pdumper \
  --with-xwidgets \
ln -s /usr/local/opt/emacs-head/Emacs.app /Applications
tic -o ~/.terminfo /usr/local/opt/emacs-head/share/emacs/28.0.50/etc/e/eterm-color.ti
