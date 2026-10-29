#!/usr/bin/env bash
# thrift-check.sh — green gate for the 100 thrift laws. psi script style.
set -uo pipefail
ROOT="$(cd -- "$(dirname -- "$0")/.." && pwd)"
fail=0

# 1. registry files exist and non-empty
for f in thrift/PRINCIPLES.md thrift/RITES.md thrift/MAP.md; do
  [[ -s "$ROOT/$f" ]] && echo "ok: $f" || { echo "GAP: $f"; fail=1; }
done

# 2. all 50 IDs present exactly once
for i in $(seq 1 100); do
  if [ "$i" -lt 10 ]; then id="0$i"; else id="$i"; fi
  n="$(grep -c "^[[:space:]]*-[[:space:]]*T$id:" "$ROOT/thrift/PRINCIPLES.md" || true)"
  [[ "$n" == "1" ]] && echo "ok: T$id" || { echo "GAP: T$id x$n"; fail=1; }
done

# 3. rites have OPEN and CLOSE checklists
grep -q '^## OPEN' "$ROOT/thrift/RITES.md" && echo "ok: rites open" \
  || { echo "GAP: rites open"; fail=1; }
grep -q '^## CLOSE' "$ROOT/thrift/RITES.md" && echo "ok: rites close" \
  || { echo "GAP: rites close"; fail=1; }

# 4. thrift corpus stays lean: whole dir under 40KB
bytes="$(du -sb "$ROOT/thrift" | cut -f1)"
[[ "$bytes" -lt 40960 ]] && echo "ok: thrift lean ($bytes B)" \
  || { echo "GAP: thrift overweight ($bytes B)"; fail=1; }

# 5. meter scripts compile (they prove the burn)
for py in retrieval/score.py scripts/usage-line.py; do
  python3 -m py_compile "$ROOT/$py" 2>/dev/null && echo "ok: compiles $py" \
    || { echo "GAP: compiles $py"; fail=1; }
done

# 6. usage-line smoke: prints a TOTAL line, exit 0
out="$(python3 "$ROOT/scripts/usage-line.py" 2>/dev/null)"
printf '%s' "$out" | grep -q '^TOTAL' && echo "ok: usage-line smoke" \
  || { echo "GAP: usage-line smoke"; fail=1; }

[[ "$fail" = 0 ]] && echo "THRIFT-GREEN: 100 wired" || { echo "THRIFT-RED"; exit 1; }
