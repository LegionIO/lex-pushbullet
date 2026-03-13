# lex-pushbullet: Pushbullet Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to the Pushbullet push notification service. Enables sending notifications to devices via Pushbullet from within Legion task chains.

**GitHub**: https://github.com/LegionIO/lex-pushbullet
**License**: MIT

## Architecture

```
Legion::Extensions::Pushbullet
└── (base extension - skeleton, no runners implemented yet)
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/pushbullet.rb` | Entry point, extension registration |
| `lib/legion/extensions/pushbullet/version.rb` | Version constant |

## Development Notes

This extension is a minimal skeleton. No runners are implemented yet. The gemspec has no runtime dependencies, suggesting runner implementation is pending.

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
