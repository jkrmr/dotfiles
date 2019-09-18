#!/usr/bin/env bash

#-------------------------------------------------------------
# Apps managed by Homebrew Cask
#-------------------------------------------------------------
# for alternate versions (e.g. iterm2-beta)
brew tap caskroom/versions
# terminal emulator
brew cask install iterm2-nightly
# password manager 6 (NB: don't use the app store version or v7)
brew cask install 1password6
# removes apps and related files
brew cask install appcleaner
# vpn
brew cask install protonvpn
# email
brew cask install protonmail-bridge
# web browser
brew cask install firefox
# controls screen brightness
brew cask install flux
# web browser
brew cask install google-chrome
# web browser
brew cask install google-chrome-canary
# SQL UI for MySQL, Postgres, MSSQL, SQLite
brew cask install sqlpro-studio
# trackpad gestures
brew cask install bettertouchtool
# remap cmd to esc, caps lock to ctrl
brew cask install karabiner-elements
# system-wide custom keymappings
brew cask install keyboard-maestro
# cmd + <space> ftw
brew cask install launchbar
# batch file renamer
brew cask install name-mangler
# PDF article manager
brew cask install papers

# Quick Look viewers: Zip files
brew cask install betterzipql
# Quick Look viewers: Syntax highlighting
brew cask install qlcolorcode
# Quick Look viewers: Display image size and res
brew cask install qlimagesize
# Quick Look Preview: Markdown
brew cask install qlmarkdown
# Quick Look Preview: Patch files
brew cask install qlprettypatch
# Quick Look Preview: Extension-less files
brew cask install qlstephen
# Quick Look Preview: CSV files
brew cask install quicklook-csv
# Quick Look Preview: JSON files
brew cask install quicklook-json
# Quick Look Preview: Mac OS X Installer Packages
brew cask install suspicious-package
# Quick Look Preview: jupyter notebooks
brew cask install jupyter-notebook-viewer
# Quick Look Preview: webp images
brew cask install webpquicklook
# Docker Desktop
brew cask install docker
# Docker GUI
brew cask install kitematic
# Gitter
brew cask install gitter
# lightweight PDF reader with auto-update
brew cask install skim
# video conferencing
brew cask install zoomus
# instant messaging
brew cask install ripcord
# torrent machine
brew cask install transmission
# video player
brew cask install vlc
# for graphical terminal output (R and Octave dependency)
brew cask install xquartz
# for mockups
brew cask install sketch
# window organization
brew cask install amethyst
# documentation browser
brew cask install dash
# media management

brew cask install 4k-stogram
brew cask install 4k-video-downloader
brew cask install 4k-youtube-to-mp3

brew cask install visual-studio-code
brew cask install screenflow
brew cask install divvy
brew cask install keycastr
brew cask install kindle
brew cask install nvalt
brew cask install julia
brew cask install slack
