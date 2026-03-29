#!/bin/bash
# RedKnight State Checkpointer v1.0
# Usage: ./scripts/checkpoint.sh "Status" "Active Task" "Completed Milestone"

STATUS=$1
ACTIVE_TASK=$2
MILESTONE=$3
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

if [ -z "$STATUS" ]; then
    echo "Usage: ./scripts/checkpoint.sh <status> <active_task> <completed_milestone>"
    exit 1
fi

# We use the unlimited Kilo tier to surgically update the JSON without manual string manipulation errors
MODEL="kilo/minimax/minimax-m2.5:free"

PROMPT="Update the following state.json content. 
1. Set 'status' to: $STATUS
2. Set 'active_task' to: $ACTIVE_TASK
3. Update 'last_update_ist' to: $TIMESTAMP (IST)
4. If a 'MILESTONE' is provided, add it to the 'milestones' array with status 'COMPLETED'.
Current state.json:
$(cat state.json)
Provide the updated JSON only."

kilo run --model "$MODEL" "$PROMPT" > state.json.tmp && mv state.json.tmp state.json

echo "Checkpoint Successful: System State Synchronized."
