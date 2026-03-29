---
name: cognee-memory
description: Use Cognee GraphRAG memory for deep reasoning and complex relationship mapping. Use when tasks require understanding connections between entities (e.g. "How does X relate to Y?") or when LanceDB vector search is insufficient.
metadata:
  {
    "openclaw":
      {
        "requires": { "bins": ["python3"], "env": ["LLM_API_KEY"] },
        "primaryEnv": "LLM_API_KEY",
      },
  }
---

# Cognee Memory (GraphRAG)

## Usage

### 1. Add Memory
When you encounter complex information with relationships, add it to the graph:
`python3 {baseDir}/scripts/cognee_wrapper.py add "<text>"`

### 2. Cognify (Build Graph)
After adding new data, you MUST run cognify to build the relationships:
`python3 {baseDir}/scripts/cognee_wrapper.py cognify`

### 3. Search
To find answers requiring deep understanding:
`python3 {baseDir}/scripts/cognee_wrapper.py search "<question>"`

## Installation
Ensure `cognee` is installed in the environment:
`pip install cognee`
