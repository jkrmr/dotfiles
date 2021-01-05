#!/usr/bin/env bash

#-------------------------------------------------------------
# Apps managed by Homebrew Cask
#-------------------------------------------------------------
# for alternate versions (e.g. iterm2-beta)
brew tap homebrew/cask-versions
# terminal emulator
brew install --cask iterm2-nightly
# password manager
brew install --cask 1password
# removes apps and related files
brew install --cask appcleaner
# vpn
brew install --cask protonvpn
# email
brew install --cask protonmail-bridge
# controls screen brightness
brew install --cask flux
# SQL UI for MySQL, Postgres, MSSQL, SQLite
brew install --cask sqlpro-studio
# trackpad gestures
brew install --cask bettertouchtool
# remap cmd to esc, caps lock to ctrl
brew install --cask karabiner-elements
# system-wide custom keymappings
brew install --cask keyboard-maestro
# cmd + <space> ftw
brew install --cask launchbar
# batch file renamer
brew install --cask name-mangler

# Docker Desktop
brew install --cask docker
# Docker GUI
brew install --cask kitematic
# Gitter
brew install --cask gitter
# lightweight PDF reader with auto-update
brew install --cask skim

# video conferencing / streaming / messaging
brew install --cask discord
brew install --cask skype
brew install --cask slack
brew install --cask streamlabs-obs
brew install --cask whatsapp
brew install --cask zoomus

# torrent machine
brew install --cask transmission
# video player
brew install --cask vlc
# for graphical terminal output (R and Octave dependency)
brew install --cask xquartz
# for mockups
brew install --cask sketch
# window organization
brew install --cask amethyst
# documentation browser
brew install --cask dash
# finder shortcut
brew install --cask openinterminal

# web browsers
brew install --cask dissenter-browser
brew install --cask firefox
brew install --cask google-chrome
brew install --cask homebrew/cask-versions/google-chrome-canary
brew install --cask responsively

brew install --cask 4k-stogram
brew install --cask 4k-video-downloader
brew install --cask 4k-youtube-to-mp3

brew install --cask divvy
brew install --cask dropbox
brew install --cask evernote
brew install --cask keycastr
brew install --cask kindle
brew install --cask licecap
brew install --cask macvim
brew install --cask nvalt
brew install --cask pandora
brew install --cask screenflow
brew install --cask spotify
brew install --cask thinkorswim
brew install --cask visual-studio-code

# LaTeX
brew install --cask latexit
brew install --cask tex-live-utility

# Quick Look viewers: Syntax highlighting
brew install --cask qlcolorcode
# Quick Look viewers: Display image size and res
brew install --cask qlimagesize
# Quick Look Preview: Markdown
brew install --cask qlmarkdown
# Quick Look Preview: Patch files
brew install --cask qlprettypatch
# Quick Look Preview: Extension-less files
brew install --cask qlstephen
# Quick Look Preview: CSV files
brew install --cask quicklook-csv
# Quick Look Preview: JSON files
brew install --cask quicklook-json
# Quick Look Preview: Mac OS X Installer Packages
brew install --cask suspicious-package
# Quick Look Preview: jupyter notebooks
brew install --cask jupyter-notebook-viewer
# Quick Look Preview: webp images
brew install --cask webpquicklook
# Quick Look Preview: video
brew install --cask qlvideo
# Quick Look Preview: Adobe Illustrator swatches
brew install --cask quicklookase

# Research
# brew install --cask manuscripts
# Studies: https://studiesapp.com
# Findings: https://findingsapp.com
# Papers3: https://www.macupdate.com/app/mac/23662/papers

# remove quarantine attributes
xattr -d -r com.apple.quarantine ~/Library/QuickLook
# reset quicklookd
qlmanage -r
