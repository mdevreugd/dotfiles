#!/bin/bash

echo "Setting macOS defaults..."

# Set Homebrew zsh as default shell
BREW_ZSH="/opt/homebrew/bin/zsh"
if [[ -f "$BREW_ZSH" ]]; then
    # Add to allowed shells if not already there
    if ! grep -q "$BREW_ZSH" /etc/shells; then
        echo "Adding Homebrew zsh to allowed shells..."
        echo "$BREW_ZSH" | sudo tee -a /etc/shells
    fi

    # Change default shell if not already set
    if [[ "$SHELL" != "$BREW_ZSH" ]]; then
        echo "Changing default shell to Homebrew zsh..."
        chsh -s "$BREW_ZSH"
    fi
else
    echo "Homebrew zsh not found, skipping shell change"
fi

# iTerm2: Load preferences from custom folder
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.config/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

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
