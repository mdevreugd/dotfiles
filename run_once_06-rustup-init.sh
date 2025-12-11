#!/bin/bash

# Set up Homebrew PATH
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

if [[ ! -d "$HOME/.cargo" ]]; then
    echo "Initializing Rust toolchain..."
    rustup-init -y
else
    echo "Rust toolchain already initialized"
fi
