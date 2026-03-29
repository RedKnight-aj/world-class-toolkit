# MCP Tools Skill

## Available Tools

### 1. Web Search (Exa)
```bash
python3 ~/.openclaw/workspace/mcp-servers/mcp_tool.py exa "AI agents 2026"
```

### 2. Brave Search
```bash
python3 ~/.openclaw/workspace/mcp-servers/mcp_tool.py brave "latest AI tools"
```

### 3. Stock Quote
```bash
python3 ~/.openclaw/workspace/mcp-servers/mcp_tool.py stock AAPL
```

### 4. Web Fetch
```bash
python3 ~/.openclaw/workspace/mcp-servers/mcp_tool.py fetch https://example.com
```

### 5. Run Command
```bash
python3 ~/.openclaw/workspace/mcp-servers/mcp_tool.py run "ls -la"
```

## Environment Variables Needed

Set these for full functionality:

```bash
export EXA_API_KEY="your-exa-key"       # Get free key at exa.ai
export BRAVE_API_KEY="your-brave-key"    # Get free key at brave.com
export ALPHA_VANTAGE_KEY="your-av-key"   # Get free key at alphavantage.co
```

## Free Tier Limits

| Tool | Free Limit |
|------|------------|
| Exa | 1,000 searches/month |
| Brave | 2,000 searches/month |
| Alpha Vantage | 25 requests/day |

## Usage in Workflows

Use these tools when:
- Need fresh web data (not just training cut-off)
- Real-time stock/financial data
- Better search than web_search tool
- Custom data extraction

## Priority

Use in this order:
1. Exa (best AI search)
2. Brave (backup)
3. Alpha Vantage (financial)
