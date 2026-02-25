# SDK Integration Test Suite

## Test Structure

This directory contains integration tests for the SoroSave SDK.

## Test Categories

### 1. Contract Deployment Tests
Tests for deploying Soroban smart contracts to a test environment.

### 2. SDK Core Functionality Tests
Tests for core SDK features including:
- Savings group creation
- Contribution management
- Payout distribution
- Round management

### 3. Event Listener Tests
Tests for event subscription and real-time event notifications.

### 4. Integration Tests
End-to-end tests for complete workflows.

## Running Tests

```bash
# Run all integration tests
npm test

# Run specific test suite
npm run test:integration

# Run with coverage
npm run test:coverage
```

## Test Environment

The integration tests require a local Soroban instance and deployed contracts.

**Environment Variables:**
- `SOROBAN_RPC_URL`: Local Soroban RPC endpoint
- `CONTRACT_ADDRESS`: Deployed contract address
- `PRIVATE_KEY`: Contract deployment private key
