---
name: web-scraper
description: Elite adaptive web scraping with stealth bypass, auto-element recovery, and AI integration. Powered by Scrapling architecture.
metadata: {"openclaw": {"emoji": "🕷️", "requires": {"bins": ["python3", "pip"]}}}
---

# 🕷️ Web Scraper - Elite Edition

Advanced web scraping with adaptive element tracking, stealth capabilities, and AI-powered extraction.

## ✨ Superpowers

| Feature | Capability |
|---------|------------|
| 🧠 **Adaptive** | Auto-relocates elements after website changes |
| 🛡️ **Stealth** | Bypasses Cloudflare/Turnstile |
| 🔄 **Proxy Rotation** | Built-in rotating proxies |
| 🤖 **AI Ready** | MCP server for Claude/Cursor |
| ⚡ **CLI** | Terminal scraping without code |
| 🎯 **Smart Selectors** | CSS/XPath/regex/text search |

## Installation

```bash
pip install scrapling "scrapling[all]"
scrapling install  # Download browsers
```

## Usage

### Basic Scraping

```python
from scrapling.fetchers import Fetcher

page = Fetcher.get('https://example.com')
data = page.css('.product').getall()
```

### Stealth Mode (Bypass Cloudflare)

```python
from scrapling.fetchers import StealthyFetcher

page = StealthyFetcher.fetch('https://nopecha.com/demo/cloudflare', solve_cloudflare=True)
data = page.css('#content').getall()
```

### Adaptive (Survives Website Changes)

```python
# Auto-tracks elements, survives website redesigns
products = page.css('.product', adaptive=True)
```

### Full Spider Crawler

```python
from scrapling.spiders import Spider, Response

class MySpider(Spider):
    name = "crawler"
    start_urls = ["https://example.com"]
    concurrent_requests = 10
    
    async def parse(self, response: Response):
        for item in response.css('.item'):
            yield {"title": item.css('h2::text').get()}

MySpider().start()
```

### CLI (No Code Required)

```bash
# Extract to file
scrapling extract get 'https://example.com' content.md

# Stealth fetch
scrapling extract stealthy-fetch 'https://example.com' output.txt --solve-cloudflare
```

### MCP Server (AI Integration)

```bash
pip install "scrapling[ai]"
scrapling mcp-server
# Then use in Claude/Cursor via MCP
```

## Proxy Rotation

```python
from scrapling.fetchers import Fetcher
from scrapling.spiders import ProxyRotator

rotator = ProxyRotator(strategy="cyclic")
page = Fetcher.get('https://example.com', proxy=rotator.next())
```

## Best Practices

1. **Always use** `adaptive=True` for long-term scrapers
2. **Stealth mode** for protected sites (Cloudflare, etc.)
3. **Pause/resume** for large crawls: `Spider(crawldir="./data").start()`
4. **Rate limit** with `concurrent_requests = 5` per domain

## Error Handling

| Error | Solution |
|-------|----------|
| Cloudflare block | Use `StealthyFetcher` with `solve_cloudfare=True` |
| Element moved | Re-run with `adaptive=True` |
| Proxy banned | Use `ProxyRotator` |
| Rate limited | Add `download_delay` |

---

**Version**: 1.0.0  
**Powered by**: Scrapling architecture