#!/bin/bash
# Kilo-Native Deep Research Protocol v1.1
# Usage: ./scripts/kilo_research.sh "Search Query"

QUERY=$1
if [ -z "$QUERY" ]; then
    echo "Error: No search query provided."
    exit 1
fi

# The model 'kilo/minimax/minimax-m2.5:free' is the verified 'unlimited free' endpoint.
# It is optimized for coding and agentic planning.
MODEL="kilo/minimax/minimax-m2.5:free"

echo "Initializing Kilo Swarm for Unlimited Deep Research: $QUERY"
echo "Target Model: $MODEL"

kilo run --model "$MODEL" "Perform a deep research on: $QUERY. Use your web search and distillation capabilities to provide a comprehensive summary. Deliver the output in professional markdown format."
