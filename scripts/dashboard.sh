#!/usr/bin/env bash
# dashboard.sh — one-glance counts that matter (tweak 57).
set -uo pipefail
ROOT="$(cd -- "$(dirname -- "$0")/.." && pwd)"
echo "observations: $(grep -c . "$ROOT/observatory.jsonl")"
echo "surprises: $(grep -c . "$ROOT/learning/surprises.jsonl")"
echo "near-misses: $(grep -c . "$ROOT/learning/counterfactuals.jsonl")"
echo "goals open: $(grep -c -- '- \[ \]' "$ROOT/goals.md")"
echo "goals done: $(grep -c -- '- \[x\]' "$ROOT/goals.md")"
echo "snapshots: $(ls "$ROOT/snapshots" 2>/dev/null | wc -l | tr -d ' ')"
echo "tools: $("$ROOT/scripts/test-tools.sh" >/dev/null 2>&1 && echo TOOLS-GREEN || echo TOOLS-RED)"
