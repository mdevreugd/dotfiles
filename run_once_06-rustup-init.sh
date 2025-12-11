#!/bin/bash

# Set up Homebrew PATH
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    RUSTUP_BIN="$(brew --prefix rustup)/bin/rustup-init"
elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
    RUSTUP_BIN="$(brew --prefix rustup)/bin/rustup-init"
fi

if [[ ! -d "$HOME/.cargo" ]]; then
    echo "Initializing Rust toolchain..."
    "$RUSTUP_BIN" -y
else
    echo "Rust toolchain already initialized"
fi
