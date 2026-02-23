# SoroSave SDK

TypeScript SDK for interacting with the SoroSave smart contracts on Soroban.

## Installation

```bash
npm install @sorosave/sdk
```

## Usage

```typescript
import { SoroSaveClient } from "@sorosave/sdk";

const client = new SoroSaveClient({
  rpcUrl: "https://soroban-testnet.stellar.org",
  contractId: "YOUR_CONTRACT_ID",
  networkPassphrase: "Test SDF Network ; September 2015",
});

const tx = await client.createGroup({
  admin: "G...",
  name: "My Savings Group",
  token: "TOKEN_ADDRESS",
  contributionAmount: 1000000n,
  cycleLength: 86400,
  maxMembers: 5,
}, sourcePublicKey);

const group = await client.getGroup(1);
```

## API

- `createGroup()` — Create a new savings group
- `joinGroup()` — Join an existing group
- `leaveGroup()` — Leave a group (while forming)
- `startGroup()` — Start the group (admin only)
- `contribute()` — Contribute to the current round
- `distributePayout()` — Distribute pot to recipient
- `pauseGroup()` / `resumeGroup()` — Admin controls
- `raiseDispute()` — Raise a dispute
- `getGroup()` — Get group details
- `getRoundStatus()` — Get round info
- `getMemberGroups()` — Get all groups for a member

## Documentation

- [ARCHITECTURE.md](./ARCHITECTURE.md) — Protocol architecture
- [CONTRIBUTING.md](./CONTRIBUTING.md) — How to contribute

## License

MIT
