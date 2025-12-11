#!/bin/bash

VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
CONFIG_DIR="$HOME/.config/vscode"

# Create VS Code user directory if it doesn't exist
mkdir -p "$VSCODE_USER_DIR"

# Symlink settings.json
if [[ -L "$VSCODE_USER_DIR/settings.json" ]]; then
    echo "settings.json symlink already exists"
elif [[ -f "$VSCODE_USER_DIR/settings.json" ]]; then
    echo "Backing up existing settings.json"
    mv "$VSCODE_USER_DIR/settings.json" "$VSCODE_USER_DIR/settings.json.backup"
    ln -s "$CONFIG_DIR/settings.json" "$VSCODE_USER_DIR/settings.json"
    echo "settings.json symlinked"
else
    ln -s "$CONFIG_DIR/settings.json" "$VSCODE_USER_DIR/settings.json"
    echo "settings.json symlinked"
fi

# Symlink keybindings.json
if [[ -L "$VSCODE_USER_DIR/keybindings.json" ]]; then
    echo "keybindings.json symlink already exists"
elif [[ -f "$VSCODE_USER_DIR/keybindings.json" ]]; then
    echo "Backing up existing keybindings.json"
    mv "$VSCODE_USER_DIR/keybindings.json" "$VSCODE_USER_DIR/keybindings.json.backup"
    ln -s "$CONFIG_DIR/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"
    echo "keybindings.json symlinked"
else
    ln -s "$CONFIG_DIR/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"
    echo "keybindings.json symlinked"
fi
