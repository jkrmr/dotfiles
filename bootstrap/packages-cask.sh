#!/usr/bin/env bash

#-------------------------------------------------------------
# Apps managed by Homebrew Cask
#-------------------------------------------------------------
# for alternate versions (e.g. iterm2-beta)
brew tap caskroom/versions
# terminal emulator
brew cask install iterm2-nightly
# password manager
brew cask install 1password
# removes apps and related files
brew cask install appcleaner
# vpn
brew cask install protonvpn
# email
brew cask install protonmail-bridge
# controls screen brightness
brew cask install flux
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

# Docker Desktop
brew cask install docker
# Docker GUI
brew cask install kitematic
# Gitter
brew cask install gitter
# lightweight PDF reader with auto-update
brew cask install skim

# video conferencing / streaming / messaging
brew cask install discord
brew cask install skype
brew cask install slack
brew cask install streamlabs-obs
brew cask install whatsapp
brew cask install zoomus

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
# finder shortcut
brew cask install openinterminal

# web browsers
brew cask install dissenter-browser
brew cask install firefox
brew cask install google-chrome
brew cask install homebrew/cask-versions/google-chrome-canary
brew cask install responsively

brew cask install 4k-stogram
brew cask install 4k-video-downloader
brew cask install 4k-youtube-to-mp3

brew cask install divvy
brew cask install dropbox
brew cask install evernote
brew cask install keycastr
brew cask install kindle
brew cask install licecap
brew cask install macvim
brew cask install nvalt
brew cask install pandora
brew cask install screenflow
brew cask install spotify
brew cask install thinkorswim
brew cask install visual-studio-code

# LaTeX
brew cask install latexit
brew cask install tex-live-utility

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
# Quick Look Preview: video
brew cask install qlvideo
# Quick Look Preview: Adobe Illustrator swatches
brew cask install quicklookase

# Research
brew cask install manuscripts
# Studies: https://studiesapp.com
# Findings: https://findingsapp.com
# Papers3: https://www.macupdate.com/app/mac/23662/papers

# remove quarantine attributes
xattr -d -r com.apple.quarantine ~/Library/QuickLook
# reset quicklookd
qlmanage -r
