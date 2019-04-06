#!/usr/bin/env bash

brew install asdf
brew install atool
brew install awscli
brew install bash
brew install bash-completion
brew install bat
brew install cmake
brew install colordiff
brew install csvkit
brew install direnv
brew install editorconfig
brew install exa
brew install fd
brew install fzf
brew install gpg2
brew install hub
brew install hugo
brew install imagemagick
brew install ispell
brew install isync
brew install libffi
brew install libyaml
brew install mosh
brew install mps-youtube
brew install msmtp
brew install mu
brew install openssl
brew install pgcli
brew install postgres
brew install python@2
brew install ranger
brew install redis
brew install rcm
brew install readline
brew install ripgrep
brew install shellcheck
brew install source-highlight
brew install the_silver_searcher
brew install tldr
brew install tree
brew install universal-ctags --HEAD
brew install w3m
brew install zsh
brew install zsh-completions
brew install zsh-syntax-highlighting

brew install tmux --with-utf8proc
brew install curl --with-openssl
brew install git --with-curl --with-openssl
brew install global --with-ctags --with-pygments

brew install neovim/neovim/neovim
mkdir "$HOME/.config"
ln -s "$HOME/.vim" "$HOME/.config/nvim"

# Taps
brew tap thoughtbot/formulae
brew install rcm parity gitsh

brew tap isacikgoz/gitin
brew install gitin

# Post-installs
source "$(brew --prefix fzf)/install"