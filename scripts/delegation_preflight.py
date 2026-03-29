#!/usr/bin/env python3
import argparse
import sys

MAPPING = {
    "research": "researcher",
    "coding": "coder",
    "writing": "writer",
    "security": "auditor",
    "audit": "auditor",
    "vision": "vision",
    "image": "vision",
    "ai-testing": "ai-tester",
    "ai test": "ai-tester",
    "ai-security": "ai-security",
    "simple": "main",
    "read": "main",
    "command": "main",
}


def normalize(s: str) -> str:
    return s.strip().lower()


def main() -> int:
    p = argparse.ArgumentParser(description="Delegation preflight gate")
    p.add_argument("--task-type", required=True)
    p.add_argument("--agent", required=True)
    args = p.parse_args()

    t = normalize(args.task_type)
    a = normalize(args.agent)

    expected = MAPPING.get(t)
    if expected is None:
        print(f"FAIL: unknown task type '{args.task_type}'. Route to researcher (safe default).")
        return 2

    if expected != a:
        print(f"FAIL: task '{args.task_type}' must route to '{expected}', not '{args.agent}'.")
        return 1

    print(f"PASS: task '{args.task_type}' -> '{args.agent}'")
    return 0


if __name__ == "__main__":
    sys.exit(main())
