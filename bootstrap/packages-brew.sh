#!/usr/bin/env bash

brew install asdf
brew install atool
brew install autoconf
brew install awscli
brew install bash
brew install bash-completion
brew install bat
brew install cmake
brew install colordiff
brew install csvkit
brew install ddgr
brew install direnv
brew install editorconfig
brew install exa
brew install fd
brew install fzf
brew install git-delta
brew install gpg2
brew install hadolint
brew install hub
brew install httpie --HEAD
brew install imagemagick
brew install ispell
brew install libffi
brew install libxml2
brew install libyaml
brew install libzip
brew install llvm
brew install ncurses
brew install openssl
brew install pgcli
brew install pkg-config
brew install python@2
brew install ranger
brew install re2
brew install rcm
brew install readline
brew install ripgrep
brew install shellcheck
brew install source-highlight
brew install the_silver_searcher
brew install tree
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install zlib
brew install zsh
brew install zsh-completions

brew install curl
brew install httpie
brew install git
brew install global

brew install vim
brew install neovim
mkdir "$HOME/.config"
ln -s "$HOME/.vim" "$HOME/.config/nvim"

# Taps
brew tap thoughtbot/formulae
brew install rcm parity gitsh

brew tap isacikgoz/gitin
brew install gitin

# Docker completions
brew install docker-completion docker-compose-completion

# Post-installs
source "$(brew --prefix fzf)/install"
