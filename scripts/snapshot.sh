#!/usr/bin/env bash
# snapshot.sh — version the psi machinery (tweak 43). Usage: snapshot.sh [label]
set -uo pipefail
ROOT="$(cd -- "$(dirname -- "$0")/.." && pwd)"
label="${1:-$(date +%Y-%m-%d)}"
dest="$ROOT/snapshots/$label"
mkdir -p -- "$dest"
tar --exclude='./snapshots' -cf - -C "$ROOT" . | tar -xf - -C "$dest"
echo "snapshot: $dest ($(find "$dest" -type f | wc -l | tr -d ' ') files)"
