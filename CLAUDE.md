# lex-pushbullet: Pushbullet Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to the Pushbullet push notification service. Provides runners for sending push notifications, managing devices, and managing channel subscriptions via the Pushbullet REST API (Bearer token auth).

**GitHub**: https://github.com/LegionIO/lex-pushbullet
**License**: MIT
**Version**: 0.2.0

## Architecture

```
Legion::Extensions::Pushbullet
├── Runners/
│   ├── Push              # Send notes/links/files, list, dismiss, delete pushes
│   ├── Device            # List, get, create, update, delete devices
│   └── Channel           # List subscriptions, subscribe, unsubscribe, channel info
├── Helpers/
│   └── Client            # Faraday connection builder (Pushbullet API v2, Bearer token)
└── Client                # Standalone client class (includes all runners)
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/pushbullet.rb` | Entry point, extension registration |
| `lib/legion/extensions/pushbullet/client.rb` | Standalone client (initialize with token:) |
| `lib/legion/extensions/pushbullet/helpers/client.rb` | Faraday builder (Access-Token header auth) |
| `lib/legion/extensions/pushbullet/runners/push.rb` | Push runner: send_note, send_link, send_file, list_pushes, delete_push, dismiss_push |
| `lib/legion/extensions/pushbullet/runners/device.rb` | Device runner: list_devices, get_device, create_device, update_device, delete_device |
| `lib/legion/extensions/pushbullet/runners/channel.rb` | Channel runner: list_subscriptions, subscribe, unsubscribe, channel_info |
| `lib/legion/extensions/pushbullet/version.rb` | Version constant (0.2.0) |

## API Coverage

| Runner | Methods |
|--------|---------|
| Push | `send_note`, `send_link`, `send_file`, `list_pushes`, `delete_push`, `dismiss_push` |
| Device | `list_devices`, `get_device`, `create_device`, `update_device`, `delete_device` |
| Channel | `list_subscriptions`, `subscribe`, `unsubscribe`, `channel_info` |

## Standalone Usage

```ruby
require 'legion/extensions/pushbullet/client'

client = Legion::Extensions::Pushbullet::Client.new(token: 'your_access_token')

client.send_note(title: 'Alert', body: 'Something happened!')
client.send_note(title: 'Alert', body: 'Device only', device_iden: 'abc123')
client.send_link(title: 'Check this', url: 'https://example.com')
client.list_devices
client.list_subscriptions
client.subscribe(channel_tag: 'some_channel')
```

## Dependencies

| Gem | Purpose |
|-----|---------|
| `faraday` (>= 2.0) | HTTP client for Pushbullet REST API v2 |

## Development

20 specs total.

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
