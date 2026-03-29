#!/bin/bash
# =============================================================================
# RedKnight Kilo Intelligent Delegation System v2.0
# =============================================================================
# Smart routing: Auto-detects task type and selects best Kilo model
# No API key required - uses free tier models
# =============================================================================

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Enhanced model mapping with fallbacks
declare -A KILO_MODELS
declare -A KILO_FALLBACKS

# All agents use best reasoning model - minimax
KILO_MODELS[researcher]="kilo/minimax/minimax-m2.5:free"
KILO_FALLBACKS[researcher]="kilo/stepfun/step-3.5-flash:free"

KILO_MODELS[coder]="kilo/minimax/minimax-m2.5:free"
KILO_FALLBACKS[coder]="kilo/stepfun/step-3.5-flash:free"

KILO_MODELS[writer]="kilo/minimax/minimax-m2.5:free"
KILO_FALLBACKS[writer]="kilo/stepfun/step-3.5-flash:free"

KILO_MODELS[auditor]="kilo/minimax/minimax-m2.5:free"
KILO_FALLBACKS[auditor]="kilo/stepfun/step-3.5-flash:free"

KILO_MODELS[vision]="kilo/minimax/minimax-m2.5:free"
KILO_FALLBACKS[vision]="kilo/stepfun/step-3.5-flash:free"

# Auto-detect task type and select model
detect_task_type() {
    local task="$1"
    task_lower=$(echo "$task" | tr '[:upper:]' '[:lower:]')
    
    if echo "$task_lower" | grep -qE "(code|function|class|debug|implement|write.*python|write.*javascript|api)"; then
        echo "coder"
    elif echo "$task_lower" | grep -qE "(research|analyze|find|investigate|explain|compare|review)"; then
        echo "researcher"
    elif echo "$task_lower" | grep -qE "(write|create|content|article|blog|document|summarize)"; then
        echo "writer"
    elif echo "$task_lower" | grep -qE "(security|audit|vulnerability|risk|compliance|check.*security)"; then
        echo "auditor"
    elif echo "$task_lower" | grep -qE "(image|photo|picture|visual|analyze.*image|extract.*text|ocr)"; then
        echo "vision"
    else
        echo "researcher"  # Default
    fi
}

# Get model with fallback
get_model() {
    local agent=$1
    local primary="${KILO_MODELS[$agent]}"
    local fallback="${KILO_FALLBACKS[$agent]}"
    
    # Try primary model with longer timeout
    if timeout 15 kilo run -m "$primary" "test" &>/dev/null; then
        echo "$primary"
    else
        # Try fallback
        echo "$fallback"
    fi
}

# Run task via Kilo CLI with retry logic
run_kilo_task() {
    local agent=$1
    local task="$2"
    local max_retries=2
    local retry=0
    
    MODEL=$(get_model "$agent")
    
    echo -e "${GREEN}[Kilo]${NC} Using model: $MODEL"
    
    while [ $retry -lt $max_retries ]; do
        result=$(echo "$task" | timeout 120 kilo run -m "$MODEL" 2>&1)
        exit_code=$?
        
        if [ $exit_code -eq 0 ]; then
            echo "$result"
            return 0
        else
            retry=$((retry + 1))
            echo -e "${YELLOW}[Kilo]${NC} Retry $retry/$max_retries..."
            sleep 2
        fi
    done
    
    echo -e "${RED}[Kilo]${NC} Failed after $max_retries attempts"
    return 1
}

# Main execution
main() {
    local agent="${1:-researcher}"
    local task="$2"
    
    # Auto-detect if only task provided
    if [ -n "$task" ] && [ -z "$(echo "$task" | grep -E '^(researcher|coder|writer|auditor|vision)$')" ]; then
        # Task is second argument, detect agent type
        agent=$(detect_task_type "$task")
    elif [ -z "$task" ]; then
        # Only one argument - treat as task, auto-detect
        task="$agent"
        agent=$(detect_task_type "$task")
    fi
    
    if [ -z "$task" ]; then
        echo "Usage: $0 [agent] <task>"
        echo ""
        echo "Agents: researcher, coder, writer, auditor, vision"
        echo "Or just provide a task - auto-detection enabled!"
        echo ""
        echo "Examples:"
        echo "  $0 researcher 'Research AI trends'"
        echo "  $0 'Write a Python function'"
        echo "  $0 'Analyze this image'"
        exit 1
    fi
    
    run_kilo_task "$agent" "$task"
}

main "$@"
