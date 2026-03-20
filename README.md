# lex-pushbullet

Pushbullet push notification integration for [LegionIO](https://github.com/LegionIO/LegionIO). Send push notifications to Pushbullet-connected devices from within Legion task chains.

## Installation

```bash
gem install lex-pushbullet
```

Or add to your Gemfile:

```ruby
gem 'lex-pushbullet'
```

## Usage

```ruby
require 'legion/extensions/pushbullet'

client = Legion::Extensions::Pushbullet::Client.new(token: 'your-access-token')

# Send a note
client.send_note(title: 'Hello', body: 'World')

# Send a link
client.send_link(title: 'Check this out', url: 'https://example.com')

# Send a file push
client.send_file(file_name: 'photo.jpg', file_url: 'https://example.com/photo.jpg', file_type: 'image/jpeg')

# List recent pushes
client.list_pushes(limit: 10)

# Delete a push
client.delete_push(iden: 'push_iden_here')

# Dismiss a push
client.dismiss_push(iden: 'push_iden_here')

# Device management
client.list_devices
client.get_device(iden: 'device_iden')
client.create_device(nickname: 'My Desktop')
client.update_device(iden: 'device_iden', nickname: 'New Name')
client.delete_device(iden: 'device_iden')

# Channel subscriptions
client.list_subscriptions
client.subscribe(channel_tag: 'some_channel')
client.unsubscribe(iden: 'subscription_iden')
client.channel_info(tag: 'some_channel')
```

## Runners

| Runner | Methods |
|--------|---------|
| `Runners::Push` | `send_note`, `send_link`, `send_file`, `list_pushes`, `delete_push`, `dismiss_push` |
| `Runners::Device` | `list_devices`, `get_device`, `create_device`, `update_device`, `delete_device` |
| `Runners::Channel` | `list_subscriptions`, `subscribe`, `unsubscribe`, `channel_info` |

## Requirements

- Ruby >= 3.4
- Pushbullet account and API access token
- [LegionIO](https://github.com/LegionIO/LegionIO) framework (optional — standalone Client works without it)

## License

MIT
