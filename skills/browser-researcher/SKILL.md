---
name: browser-researcher
description: Advanced web research and data extraction using the built-in browser tool. No external API keys required.
metadata: {"openclaw": {"requires": {"config": ["browser.enabled"]}, "emoji": "🔍"}}
---

# Browser Researcher

This skill uses the built-in `browser` tool to perform autonomous web research, bypassing the need for search API keys (like Brave or BrowserAct).

## ✨ Features

- 🌐 **No API Keys:** Uses the managed `openclaw` browser profile.
- 🔍 **Search Engine Support:** Can navigate to Google, DuckDuckGo, or Bing.
- 📄 **Deep Extraction:** Can follow links and extract content from multiple pages.
- 📊 **Efficient Snapshots:** Uses `--efficient` snapshots to minimize token usage.

## 🛠️ Usage

This skill is designed to be used by the agent (RedKnight) via the `browser` tool.

### Common Workflows

1. **Search:** Navigate to a search engine and perform a query.
2. **Explore:** Use snapshots to find relevant links and navigate to them.
3. **Extract:** Take snapshots or screenshots of relevant data.
4. **Report:** Synthesize findings into a markdown report.

## 💻 CLI Tools

A helper script is provided to automate search engine queries.

```bash
# Search Google for a topic
python skills/browser-researcher/scripts/search.py "OpenClaw documentation"
```

## 🎯 Best Practices

1. Use `profile="openclaw"` to keep automation isolated.
2. Use `snapshot(mode="efficient")` to save tokens.
3. If blocked, try a different search engine or rotate the User-Agent.
