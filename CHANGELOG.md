# Changelog

## [0.2.0] - 2026-03-15

### Added
- `Helpers::Client` — Faraday connection to `https://api.pushbullet.com/v2` with `Access-Token` Bearer auth
- `Runners::Push` — `send_note`, `send_link`, `send_file`, `list_pushes`, `delete_push`, `dismiss_push`
- `Runners::Device` — `list_devices`, `get_device`, `create_device`, `update_device`, `delete_device`
- `Runners::Channel` — `list_subscriptions`, `subscribe`, `unsubscribe`, `channel_info`
- Standalone `Client` class including all three runners
- `faraday >= 2.0` runtime dependency
- 21 specs covering all runner methods

## [0.1.0] - 2026-03-13

### Added
- Initial release
