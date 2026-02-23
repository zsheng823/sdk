#!/bin/bash
set -e

NETWORK=${1:-testnet}

echo "=== SoroSave Contract Deployment ==="
echo "Network: $NETWORK"

# Build the contract
echo ""
echo "Building contract..."
stellar contract build

# Optimize the WASM
echo "Optimizing WASM..."
stellar contract optimize --wasm target/wasm32-unknown-unknown/release/sorosave.wasm

WASM_PATH="target/wasm32-unknown-unknown/release/sorosave.optimized.wasm"

if [ ! -f "$WASM_PATH" ]; then
    echo "Error: Optimized WASM not found at $WASM_PATH"
    echo "Trying non-optimized..."
    WASM_PATH="target/wasm32-unknown-unknown/release/sorosave.wasm"
fi

echo "WASM size: $(wc -c < "$WASM_PATH") bytes"

# Deploy
echo ""
echo "Deploying to $NETWORK..."
CONTRACT_ID=$(stellar contract deploy \
    --source-account alice \
    --network "$NETWORK" \
    --wasm "$WASM_PATH" \
    2>&1)

echo ""
echo "Contract deployed!"
echo "Contract ID: $CONTRACT_ID"
echo ""
echo "Add to your .env:"
echo "NEXT_PUBLIC_CONTRACT_ID=$CONTRACT_ID"
