#!/bin/bash
set -e

echo "=== SoroSave Development Setup ==="

# Check prerequisites
echo "Checking prerequisites..."

if ! command -v rustc &> /dev/null; then
    echo "Error: Rust not installed. Visit https://rustup.rs/"
    exit 1
fi

if ! command -v stellar &> /dev/null; then
    echo "Installing Stellar CLI..."
    cargo install --locked stellar-cli
fi

if ! command -v node &> /dev/null; then
    echo "Error: Node.js not installed. Visit https://nodejs.org/"
    exit 1
fi

if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    npm install -g pnpm
fi

# Add WASM target
echo "Adding wasm32 target..."
rustup target add wasm32-unknown-unknown

# Install JS dependencies
echo "Installing JavaScript dependencies..."
pnpm install

# Build contract
echo "Building smart contract..."
stellar contract build

# Run tests
echo "Running contract tests..."
cargo test

echo ""
echo "Setup complete! You can now:"
echo "  pnpm dev          - Start the frontend"
echo "  cargo test         - Run contract tests"
echo "  pnpm build         - Build everything"
