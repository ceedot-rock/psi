#!/usr/bin/env bash
# obs.sh — one-command observatory append to all three stores.
# Usage: obs.sh <category> <observation> [date(YYYY-MM-DD, default today UTC)]
# Kills the triple-write overhead: canonical log, local mirror, memory note.
set -uo pipefail
ROOT="${PSI_ROOT:-$(cd -- "$(dirname -- "$0")/.." && pwd)}"
_default_note() { find "$HOME/.local/share/muse/memory/projects" -name reasoning-observatory.md 2>/dev/null | head -n 1; }
MEMORY_NOTE="${OBS_MEMORY_NOTE:-$(_default_note)}"
MIRROR="${OBS_MIRROR:-$HOME/.local/bin/.muse-observatory.jsonl}"

[[ $# -ge 2 ]] || { echo "usage: obs.sh <category> <observation> [date]" >&2; exit 2; }
cat="$1"; shift
obs="$1"; shift
date="${1:-$(date -u +%F)}"

line="$(python3 -c 'import json,sys; print(json.dumps({"d":sys.argv[1],"c":sys.argv[2],"o":sys.argv[3]}))' "$date" "$cat" "$obs")"
printf '%s\n' "$line" >> "$ROOT/observatory.jsonl"
printf '%s\n' "$line" >> "$MIRROR"
printf '%s\n' "$line" >> "$MEMORY_NOTE"
echo "logged: $line"
