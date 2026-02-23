# SoroSave Architecture

## Overview

SoroSave is a decentralized rotating savings group (ROSCA) protocol. The system consists of three layers:

```
┌─────────────────────────────────────────┐
│              Frontend (Next.js)          │
│         Wallet connection, UI           │
├─────────────────────────────────────────┤
│              SDK (TypeScript)            │
│     Transaction building, parsing       │
├─────────────────────────────────────────┤
│          Smart Contract (Soroban)        │
│   Group management, contributions,      │
│   payouts, admin controls               │
├─────────────────────────────────────────┤
│           Stellar Network               │
│      Consensus, token transfers         │
└─────────────────────────────────────────┘
```

## Smart Contract Design

### Data Model

```
┌──────────────────────────────────────────────────────┐
│                    SavingsGroup                       │
│──────────────────────────────────────────────────────│
│ id: u64                                              │
│ name: String                                         │
│ admin: Address                                       │
│ token: Address (SAC token contract)                  │
│ contribution_amount: i128                            │
│ cycle_length: u64 (seconds)                          │
│ max_members: u32                                     │
│ members: Vec<Address>                                │
│ payout_order: Vec<Address>                           │
│ current_round: u32                                   │
│ total_rounds: u32                                    │
│ status: GroupStatus                                  │
│ created_at: u64                                      │
└──────────────────────────────────────────────────────┘
         │
         │ 1:N
         ▼
┌──────────────────────────────────────────────────────┐
│                     RoundInfo                         │
│──────────────────────────────────────────────────────│
│ round_number: u32                                    │
│ recipient: Address                                   │
│ contributions: Map<Address, bool>                    │
│ total_contributed: i128                              │
│ is_complete: bool                                    │
│ deadline: u64                                        │
└──────────────────────────────────────────────────────┘
```

### State Machine

```
  ┌──────────┐     start_group()    ┌──────────┐
  │ Forming  │─────────────────────▶│  Active  │
  └──────────┘                      └──────────┘
       │                             │    │    │
       │ (members join/leave)        │    │    │
       │                             │    │    │
       │                    pause()  │    │    │ all rounds done
       │                    ┌────────┘    │    └──────────────┐
       │                    ▼             │                    ▼
       │              ┌──────────┐   dispute()          ┌──────────┐
       │              │  Paused  │        │              │Completed │
       │              └──────────┘        │              └──────────┘
       │                    │             ▼
       │           resume() │       ┌──────────┐
       │                    └──────▶│ Disputed │
       │                            └──────────┘
       │                                  │
       │                     resolve()    │
       │                                  ▼
       │                            ┌──────────┐
       │                            │  Active  │
       └────────────────────────────┴──────────┘
```

### Storage Layout

| Key | Storage Type | Description |
|---|---|---|
| `DataKey::Admin` | Instance | Protocol admin address |
| `DataKey::GroupCounter` | Instance | Auto-incrementing group ID counter |
| `DataKey::Group(id)` | Persistent | Group configuration and state |
| `DataKey::Round(group_id, round)` | Persistent | Round contribution tracking |
| `DataKey::MemberGroups(addr)` | Persistent | List of groups a member belongs to |
| `DataKey::Dispute(group_id)` | Persistent | Active dispute information |

### Module Structure

```
contracts/sorosave/src/
├── lib.rs           # Contract entry point, public API
├── types.rs         # Data structures (GroupStatus, SavingsGroup, etc.)
├── errors.rs        # ContractError enum
├── storage.rs       # Storage read/write helpers with TTL management
├── group.rs         # Group lifecycle (create, join, leave, start)
├── contribution.rs  # Contribution logic and token transfers
├── payout.rs        # Pot distribution and round advancement
├── admin.rs         # Governance (pause, dispute, emergency)
└── test.rs          # Unit tests
```

### Token Integration

SoroSave uses Stellar Asset Contracts (SAC) for token transfers. The contract acts as an escrow:

1. **Contribute**: `token.transfer(member → contract, amount)`
2. **Payout**: `token.transfer(contract → recipient, pot)`
3. **Emergency**: `token.transfer(contract → each_member, balance / N)`

Members must authorize the contract to transfer tokens on their behalf via `require_auth()`.

## SDK Architecture

The SDK provides a typed TypeScript interface:

```
SoroSaveClient
├── createGroup()      → Transaction
├── joinGroup()        → Transaction
├── contribute()       → Transaction
├── distributePayout() → Transaction
├── getGroup()         → SavingsGroup (simulation)
├── getRoundStatus()   → RoundInfo (simulation)
└── getMemberGroups()  → number[] (simulation)
```

Write operations return unsigned `Transaction` objects that must be signed (via Freighter or other wallet) before submission. Read operations use transaction simulation and return parsed data directly.

## Frontend Architecture

```
Next.js App Router
├── / (landing page)
├── /groups (list all groups)
├── /groups/new (create group form)
└── /groups/[id] (group detail, contribute, manage)

Context Providers
└── WalletContext (Freighter connection state)

Components
├── Navbar, ConnectWallet
├── GroupCard, GroupList
├── CreateGroupForm
├── MemberList, RoundProgress
└── ContributeModal
```

## Security Considerations

- **Authorization**: Every state-changing function requires `require_auth()` from the caller
- **Admin separation**: Group admins manage their group; protocol admin handles emergencies
- **Reentrancy**: Soroban's execution model prevents reentrancy by design
- **Token safety**: All transfers use the standard Soroban token interface
- **Dispute mechanism**: Any member can freeze a group; only admin can unfreeze
- **TTL management**: Storage entries have TTL extensions to prevent data loss
