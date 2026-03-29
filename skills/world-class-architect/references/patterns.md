# 2026 Elite Architectural Patterns

## 1. The "Lobster" Pipeline (Deterministic Orchestration)
**Use for:** Multi-step tasks where reliability > creativity (e.g., data migration, daily reports).
**Structure:**
- Define a `.lobster` file.
- Chain tools: `exec` -> `transform` -> `write`.
- Add approval gates: `approve: required` before side-effects.
**ROI:** 100% deterministic execution. Zero hallucinations.

## 2. The "OpenProse" Cluster (Multi-Agent Swarm)
**Use for:** Complex, parallelizable tasks (e.g., "Research this topic while fixing this bug").
**Structure:**
- **Main Agent:** The Dispatcher. Holds the context.
- **Sub-Agents:** The Workers. Spawned via `sessions_spawn`.
  - **Researcher:** `group:web` access.
  - **Coder:** `group:fs` + `apply_patch` access.
**ROI:** 3x speedup via parallelism. Main context stays clean.

## 3. The "LanceDB" Substrate (Vector Memory)
**Use for:** Long-term recall and learning.
**Structure:**
- **Auto-Capture:** Plugin automatically indexes high-value facts.
- **Hybrid Search:** Queries use both Vectors (Semantic) and BM25 (Keyword).
**ROI:** Infinite memory. No "context window" limits.
