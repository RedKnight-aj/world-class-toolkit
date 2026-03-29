#!/bin/bash
# RedKnight Hierarchical Memory Compressor v1.0
# Usage: ./scripts/memory_compressor.sh [date-YYYY-MM-DD]
# Purpose: Distill raw daily logs into long-term strategic insights using Unlimited AI.

DATE=$1
if [ -z "$DATE" ]; then
    DATE=$(date -d "yesterday" +"%Y-%m-%d")
fi

FILE="memory/$DATE.md"

if [ ! -f "$FILE" ]; then
    echo "Error: Memory file $FILE not found."
    exit 1
fi

echo "Initializing Hierarchical Compression for $DATE..."

# The model 'kilo/minimax/minimax-m2.5:free' is used for zero-cost distillation.
MODEL="kilo/minimax/minimax-m2.5:free"

PROMPT="Analyze the following daily activity log from $DATE. 
1. Extract 'Core Facts' (unchanging truths about the user or system).
2. Extract 'Strategic Decisions' (changes to protocol or architecture).
3. Extract 'Lessons Learned' (mistakes to never repeat).
Provide the output in a clean markdown format suitable for appending to a long-term MEMORY.md file. 
Log Content:
$(cat $FILE)"

kilo run --model "$MODEL" "$PROMPT" > "memory/distilled_$DATE.txt"

echo "Compression complete. Distilled output saved to memory/distilled_$DATE.txt"
