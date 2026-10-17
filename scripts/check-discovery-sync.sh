#!/usr/bin/env bash
# check-discovery-sync.sh — every HOME-COPY shipped product must appear in each discovery file.
# Usage: check-discovery-sync.sh [repo-root (default /home/ceedotrock/src/SlidPhiLabs)]
# Prints stale lines (exit 1) or DISCOVERY-SYNC (exit 0).
set -uo pipefail
ROOT="${1:-/home/ceedotrock/src/SlidPhiLabs}"
COPY="$ROOT/docs/site/HOME-COPY.md"
FILES=("docs/site/llms.txt" "docs/site/ai.txt" "docs/site/agents.json")

mapfile -t NAMES < <(sed -n '/^## 01 Shipped/,/^## 02 /p' "$COPY" | grep -oE '^\| \*\*[^*]+\*\*' | sed 's/^| \*\*//; s/\*\*$//')
stale=0
for n in "${NAMES[@]}"; do
  for f in "${FILES[@]}"; do
    grep -qiF "$n" "$ROOT/$f" || { echo "stale: $n missing in $f"; stale=1; }
  done
done
[[ $stale -eq 0 ]] && echo "DISCOVERY-SYNC"
exit "$stale"
