#!/bin/bash

if [[ ! -d "$HOME/.cargo" ]]; then
    echo "Initializing Rust toolchain..."
    rustup-init -y
else
    echo "Rust toolchain already initialized"
fi
