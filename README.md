# 🛠️ World-Class Toolkit

<p align="center">
  <a href="https://www.npmjs.com/package/world-class-toolkit"><img src="https://img.shields.io/npm/v/world-class-toolkit?style=flat&colorA=1a1a2e&colorB=7f5af0" alt="npm"></a>
  <a href="https://www.npmjs.com/package/world-class-toolkit"><img src="https://img.shields.io/npm/dm/world-class-toolkit?style=flat&colorA=1a1a2e&colorB=7f5af0" alt="downloads"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/npm/l/world-class-toolkit?style=flat&colorA=1a1a2e&colorB=7f5af0" alt="license"></a>
</p>

> The "std lib" for AI developers. Curated, maintained, and evolving.

```
╭────────────────────────────────────────────────────────────╮
│  $ npx world-class-toolkit init my-agent                  │
│                                                      │
│  ████████  Project ready in 3.2s                       │
│                                                      │
│  ✓ ai-agent/ (full agent template)                      │
│  ✓ src/agent.ts (with memory + tools)                  │
│  ✓ tests/agent.test.ts                                │
│  ✓ README.md                                          │
│  ✓ .env.example                                      │
│  ✓ docker-compose.yml                                │
│                                                      │
│  → cd my-agent && npm run dev                         │
╰────────────────────────────────────────────────────────────╯
```

## Why This Exists

Most "awesome lists" are AI-scraped, unmaintained, and gathering dust. **This isn't one of them.**

- ✅ Curated (NOT scraped)
- ✅ Quality gates (tests, docs, security)
- ✅ Local-first (works offline)
- ✅ Self-maintaining (automated updates)

## Quick Start

```bash
# Install all tools
npx world-class-toolkit install

# Initialize a new AI project
npx world-class-toolkit init my-project

# Monitor token usage
npx world-class-toolkit monitor

# Run evaluation
npx world-class-toolkit eval --benchmark
```

## What's Inside

| Category | Tools | Description |
|----------|-------|-------------|
| 🛠️ **CLI Tools** | ai-init, ai-monitor, ai-eval, ai-deploy | Production utilities |
| 🔌 **MCP Servers** | GitHub+, Slack-ai, Metrics | AI-powered integrations |
| 📦 **Templates** | Agent, RAG, Eval, API, SLM | Production-ready scaffolds |
| 🧠 **Skills** | code-review, test-gen | Agent capabilities |
| 📜 **Scripts** | install-all, token-counter | Automation helpers |

## CLI Tools

| Tool | Purpose |
|------|---------|
| `init` | Scaffold new AI projects |
| `monitor` | Track token usage + costs |
| `eval` | Benchmark prompts/models |
| `deploy` | One-click deployment |
| `context` | RAG pipeline for codebase |

## MCP Servers

| Server | Purpose |
|--------|---------|
| `github-plus` | Enhanced GitHub with AI summaries |
| `slack-ai` | Thread summarization, response drafting |
| `metrics` | Prometheus with anomaly detection |

## Templates

| Template | Use Case |
|----------|----------|
| `agent` | AI agent with memory, tools, streaming |
| `rag` | RAG pipeline with chunking strategies |
| `eval` | Prompt/model evaluation harness |
| `api` | FastAPI + AI integration |
| `slm` | Local SLM serving (Ollama, llama.cpp) |

## Installation

```bash
npm install -g world-class-toolkit
```

Or use npx:

```bash
npx world-class-toolkit help
```

## Contributing

PRs welcome! See [CONTRIBUTING.md](CONTRIBUTING.md).

## Star Rewards

| Stars | Reward |
|-------|--------|
| 100 | Mention in README |
| 500 | Custom badge |
| 1K | Priority features |
| 5K | Co-maintainer |

---

<p align="center">
  <sub>Built by AI developers, for AI developers.</sub>
</p>

MIT © 2026