#!/bin/bash
# Delegation Enforcer Script
# Validates task delegation before execution
# Usage: ./delegation-enforcer.sh "<task>"

TASK="$1"
TASK_LOWER=$(echo "$TASK" | tr '[:upper:]' '[:lower:]')

# Research patterns
RESEARCH_PATTERNS=("price" "find" "search" "lookup" "what is" "how to" "who is" "when did" "why is" "explain")
# Coding patterns
CODING_PATTERNS=("code" "script" "function" "class" "fix" "bug" "implement" "write program")
# Writing patterns
WRITING_PATTERNS=("write" "draft" "create content" "summarize" "article" "blog" "post")
# Security patterns
SECURITY_PATTERNS=("audit" "security" "vulnerability" "check" "review" "penetration")
# Vision patterns
VISION_PATTERNS=("image" "screenshot" "visual" "analyze image" "ocr")
# AI Testing patterns
AI_TESTING_PATTERNS=("test" "evaluate" "benchmark" "metrics" "quality")
# AI Security patterns
AI_SECURITY_PATTERNS=("red team" "prompt injection" "jailbreak" "security test")

check_pattern() {
    local pattern="$1"
    shift
    local array=("$@")
    for p in "${array[@]}"; do
        if [[ "$TASK_LOWER" == *"$p"* ]]; then
            echo "$pattern"
            return 0
        fi
    done
    return 1
}

# Check each category
if check_pattern "researcher" "${RESEARCH_PATTERNS[@]}"; then
    echo "DELEGATE: researcher"
    exit 0
fi

if check_pattern "coder" "${CODING_PATTERNS[@]}"; then
    echo "DELEGATE: coder"
    exit 0
fi

if check_pattern "writer" "${WRITING_PATTERNS[@]}"; then
    echo "DELEGATE: writer"
    exit 0
fi

if check_pattern "auditor" "${SECURITY_PATTERNS[@]}"; then
    echo "DELEGATE: auditor"
    exit 0
fi

if check_pattern "vision" "${VISION_PATTERNS[@]}"; then
    echo "DELEGATE: vision"
    exit 0
fi

if check_pattern "ai-tester" "${AI_TESTING_PATTERNS[@]}"; then
    echo "DELEGATE: ai-tester"
    exit 0
fi

if check_pattern "ai-security" "${AI_SECURITY_PATTERNS[@]}"; then
    echo "DELEGATE: ai-security"
    exit 0
fi

# Default: execute directly
echo "DIRECT: simple task"
exit 1
