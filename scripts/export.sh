#!/usr/bin/env bash
# export.sh — one-command inheritable package (tweak 94). Usage: export.sh [out]
set -uo pipefail
ROOT="$(cd -- "$(dirname -- "$0")/.." && pwd)"
out="${1:-/tmp/psi-inherit.tar.gz}"
tar --exclude='./snapshots' -czf "$out" -C "$(dirname -- "$ROOT")" "$(basename -- "$ROOT")"
echo "export: $out ($(wc -c < "$out" | tr -d ' ') bytes)"
