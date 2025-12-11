#!/bin/bash

echo "Setting macOS defaults..."

# Dock: autohide
defaults write com.apple.dock autohide -bool true

# Key repeat: fast
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Require password after sleep
defaults write com.apple.screensaver askForPassword -int 1

# Restart affected apps
killall Dock
killall Finder

echo "macOS defaults set. Some changes may require logout/restart."
