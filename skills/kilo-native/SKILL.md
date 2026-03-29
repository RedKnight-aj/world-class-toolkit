# Kilo-Native Skill Pack

## Overview
This skill pack offloads heavy context-consuming research and labor from the Main Antigravity context to the Kilo Swarm engine.

## Usage
- **Deep Research:** Use `scripts/kilo_research.sh "topic"` to run a background research task.
- **Workflow:**
  1. Main Agent (Antigravity) delegates task via `exec`.
  2. Kilo Engine executes task using free/specialized models.
  3. Result is distilled and returned to the Main Context.

## Configuration
- **Models:** Prefers `google/gemini-3-pro-preview` or `kimi-k2.5-free` via Kilo.
- **Protocol:** Zero-waste, surgical distillation.
