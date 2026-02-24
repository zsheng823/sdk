# SoroSave Telegram Bot

A Telegram bot for monitoring SoroSave group events, including contributions, payouts, and round updates.

## Features

- ✅ Subscribe to SoroSave groups for notifications
- ✅ Real-time alerts for new contributions
- ✅ Payout distribution notifications
- ✅ Round start notifications
- ✅ Easy management with Telegram commands

## Commands

| Command | Description |
|---------|-------------|
| `/subscribe <group_id>` | Subscribe to notifications for a group |
| `/unsubscribe <group_id>` | Unsubscribe from a group |
| `/status` | View your current subscriptions |
| `/help` | Show help message |

## Setup

### 1. Create a Telegram Bot

1. Open Telegram and search for [@BotFather](https://t.me/BotFather)
2. Send `/newbot` command
3. Follow the prompts to name your bot
4. Copy the bot token (it looks like `123456789:ABCdefGHIjklMNOpqrsTUVwxyz`)

### 2. Clone and Install

```bash
cd telegram-bot
npm install
```

### 3. Configure Environment

```bash
cp .env.example .env
# Edit .env and add your bot token
```

### 4. Build and Run

```bash
npm run build
npm start
```

Or for development with auto-reload:

```bash
npm run dev:watch
```

## Usage Examples

### Subscribe to a group

```
/subscribe CA7X4F...
```

### Check your subscriptions

```
/status
```

### Unsubscribe

```
/unsubscribe CA7X4F...
```

## Notification Types

### New Contribution

```
💰 New Contribution

Group: `CA7X4F...`
Contributor: `GABCD...1234`
Amount: 100 XLM
```

### Payout Distributed

```
🎉 Payout Distributed

Group: `CA7X4F...`
Round: #5
Amount: 450 XLM
```

### Round Started

```
🔄 New Round Started

Group: `CA7X4F...`
Round: #6
Start Date: 2026-02-24
```

## Integration with SoroSave SDK

The bot exports a `NotificationService` class that can be imported and used in your SoroSave application:

```typescript
import { NotificationService } from "./telegram-bot";

// Notify about a new contribution
await NotificationService.notifyNewContribution(
  "CA7X4F...",
  "GABCD...1234",
  "100 XLM"
);

// Notify about a payout
await NotificationService.notifyPayoutDistributed(
  "CA7X4F...",
  "450 XLM",
  5
);

// Notify about a new round
await NotificationService.notifyRoundStarted(
  "CA7X4F...",
  6,
  "2026-02-24"
);
```

## Architecture

- **Framework**: Grammy (Modern Telegram Bot Framework)
- **Language**: TypeScript
- **Storage**: In-memory (can be replaced with Redis or database for production)

## Development

```bash
# Install dependencies
npm install

# Watch mode for development
npm run dev:watch

# Build for production
npm run build

# Run compiled bot
npm start
```

## Roadmap

- [ ] Add persistent storage (Redis/PostgreSQL)
- [ ] Add admin commands for bot management
- [ ] Add analytics dashboard
- [ ] Support for multiple notification channels (Discord, Slack)
- [ ] Webhook support for faster delivery

## Contributing

Contributions are welcome! Please read the [Contributing Guide](../CONTRIBUTING.md).

## License

MIT License - see [LICENSE](../LICENSE) file.

## Support

- **Issue Tracker**: [GitHub Issues](https://github.com/sorosave-protocol/sdk/issues/60)
- **Documentation**: [SoroSave Docs](https://github.com/sorosave-protocol/sdk)

---

Made with ❤️ by SoroSave Community
