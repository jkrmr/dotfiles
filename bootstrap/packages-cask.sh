#!/usr/bin/env bash

#-------------------------------------------------------------
# Apps managed by Homebrew Cask
#-------------------------------------------------------------
brew tap homebrew/cask-versions

brew install --cask 1password
brew install --cask 4k-stogram
brew install --cask 4k-video-downloader
brew install --cask 4k-youtube-to-mp3
brew install --cask android-studio
brew install --cask appcleaner
brew install --cask authy
brew install --cask bettertouchtool
brew install --cask brave-browser
brew install --cask dash
brew install --cask discord
brew install --cask dissenter-browser
brew install --cask divvy
brew install --cask docker
brew install --cask dropbox
brew install --cask firefox
brew install --cask flux
brew install --cask gitter
brew install --cask google-chrome
brew install --cask homebrew/cask-versions/google-chrome-canary
brew install --cask iterm2-beta
brew install --cask karabiner-elements
brew install --cask keyboard-maestro
brew install --cask keycastr
brew install --cask kindle
brew install --cask latexit
brew install --cask launchbar
brew install --cask launchcontrol
brew install --cask launchpad-manager
brew install --cask macvim
brew install --cask name-mangler
brew install --cask nvalt
brew install --cask pandora
brew install --cask protonmail-bridge
brew install --cask protonvpn
brew install --cask responsively
brew install --cask screenflow
brew install --cask skim
brew install --cask skype
brew install --cask slack
brew install --cask spotify
brew install --cask sqlpro-studio
brew install --cask streamlabs-obs
brew install --cask tastyworks
brew install --cask telegram
brew install --cask tex-live-utility
brew install --cask thinkorswim
brew install --cask transmission
brew install --cask upwork
brew install --cask visual-studio-code
brew install --cask vlc
brew install --cask whatsapp
brew install --cask xquartz
brew install --cask zoom

#-------------------------------------------------------------
# Quick Look viewers
#-------------------------------------------------------------

# Syntax highlighting
brew install --cask qlcolorcode
# Display image size and resolution
brew install --cask qlimagesize
# Markdown
brew install --cask qlmarkdown
# Patch files
brew install --cask qlprettypatch
# Extension-less files
brew install --cask qlstephen
# CSV files
brew install --cask quicklook-csv
# JSON files
brew install --cask quicklook-json
# Mac OS X Installer Packages
brew install --cask suspicious-package
# jupyter notebooks
brew install --cask jupyter-notebook-viewer
# webp images
brew install --cask webpquicklook
# video
brew install --cask qlvideo
# Adobe Illustrator swatches
brew install --cask quicklookase

# Research
# Studies: https://studiesapp.com
# Manuscripts: https://www.manuscriptsapp.com/
# Findings: https://findingsapp.com
# Papers3: https://www.macupdate.com/app/mac/23662/papers

# remove quarantine attributes
xattr -d -r com.apple.quarantine ~/Library/QuickLook
# reset quicklookd
qlmanage -r
