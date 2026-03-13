# lex-pushbullet: Pushbullet Integration for LegionIO

**Repository Level 3 Documentation**
- **Category**: `/Users/miverso2/rubymine/legion/extensions/CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to the Pushbullet push notification service. Enables sending notifications to devices via Pushbullet from within Legion task chains.

**License**: MIT

## Architecture

```
Legion::Extensions::Pushbullet
└── (base extension with Pushbullet API integration)
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/pushbullet.rb` | Entry point, extension registration |
| `lib/legion/extensions/pushbullet/version.rb` | Version constant |

## Testing

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
