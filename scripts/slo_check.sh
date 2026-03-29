#!/usr/bin/env bash
set -euo pipefail

WORKDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGETS="$WORKDIR/config/ops/slo_targets.json"

if [[ ! -f "$TARGETS" ]]; then
  echo "Missing SLO targets: $TARGETS"
  exit 1
fi

echo "=== Functional SLO Check ==="
echo "Timestamp (UTC): $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
echo

echo "[1/3] OpenClaw status"
openclaw status || true
echo

echo "[2/3] Gateway status"
openclaw gateway status || true
echo

echo "[3/3] Delegation preflight smoke tests"
python3 "$WORKDIR/scripts/delegation_preflight.py" --task-type research --agent researcher
python3 "$WORKDIR/scripts/delegation_preflight.py" --task-type coding --agent coder
python3 "$WORKDIR/scripts/delegation_preflight.py" --task-type security --agent auditor

echo
echo "SLO targets file: $TARGETS"
cat "$TARGETS"
