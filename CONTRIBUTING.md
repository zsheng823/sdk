# Contributing to SoroSave

Thank you for your interest in contributing to SoroSave! This guide will help you get started.

## Getting Started

1. **Fork the repository** and clone your fork
2. **Set up your environment** (see README.md for prerequisites)
3. **Find an issue** — Look for issues labeled `good first issue` or `help wanted`
4. **Comment on the issue** to let others know you're working on it
5. **Create a branch** from `main` for your changes
6. **Submit a pull request** when ready

## Development Setup

```bash
# Clone your fork
git clone https://github.com/<your-username>/sorosave.git
cd sorosave

# Add upstream remote
git remote add upstream https://github.com/big14way/sorosave.git

# Install dependencies
pnpm install

# Build everything
pnpm build
```

## Project Structure

| Directory | Description | Language |
|---|---|---|
| `contracts/sorosave/` | Soroban smart contract | Rust |
| `sdk/` | TypeScript SDK wrapping contract | TypeScript |
| `frontend/` | Next.js web application | TypeScript/React |
| `scripts/` | Deployment and setup scripts | Bash |

## Development Workflow

### Smart Contract (Rust)

```bash
# Build
stellar contract build

# Test
cargo test

# Test with logs
cargo test -- --nocapture
```

### SDK (TypeScript)

```bash
cd sdk
pnpm install
pnpm build
pnpm test
```

### Frontend (Next.js)

```bash
cd frontend
pnpm install
pnpm dev       # Start dev server
pnpm build     # Production build
pnpm lint      # Lint check
```

## Code Style

### Rust
- Follow standard Rust conventions (`cargo fmt`, `cargo clippy`)
- Use descriptive error types from `ContractError` enum
- Add tests for all new contract functions

### TypeScript
- Use TypeScript strict mode
- Follow existing patterns in the codebase
- Add JSDoc comments for public API methods

## Pull Request Guidelines

1. **One PR per issue** — Keep changes focused
2. **Write tests** — Contract changes need Rust tests, SDK changes need unit tests
3. **Update docs** — If your change affects the API, update relevant documentation
4. **Descriptive commits** — Use clear commit messages describing what and why
5. **Pass CI** — Ensure all tests and linting pass before requesting review

### PR Title Format

```
feat(contract): add randomized payout order
fix(sdk): handle connection timeout
docs: update deployment guide
test(contract): add edge case for empty group
```

## Issue Labels

| Label | Description |
|---|---|
| `good first issue` | Simple tasks, great for newcomers |
| `help wanted` | Moderate complexity, well-defined scope |
| `bounty` | Significant features, eligible for rewards |
| `contract` | Smart contract (Rust) work |
| `sdk` | TypeScript SDK work |
| `frontend` | React/Next.js frontend work |
| `testing` | Test coverage improvements |
| `documentation` | Docs, guides, comments |
| `security` | Security-related improvements |
| `infrastructure` | CI/CD, tooling, deployment |
| `bug` | Bug reports and fixes |
| `enhancement` | Feature requests and improvements |

## Security

If you discover a security vulnerability, please **do not** open a public issue. Instead, email security concerns directly to the maintainers.

## Code of Conduct

Be respectful, inclusive, and constructive. We're building for communities worldwide — let's reflect that in how we collaborate.

## Questions?

Open a discussion or reach out in our community channels. We're happy to help you get started!
