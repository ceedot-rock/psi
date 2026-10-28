#!/usr/bin/env bash
# test-tools.sh — focused checks for obs.sh and verify-live.sh (psi script style).
set -uo pipefail
DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
fail=0

# obs.sh appends one JSON line to all three stores
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
touch "$T/mirror.jsonl" "$T/note.md"
export PSI_ROOT="$T" OBS_MIRROR="$T/mirror.jsonl" OBS_MEMORY_NOTE="$T/note.md"
"$DIR/obs.sh" testcat "hello world" "2026-10-17" >/dev/null
for f in "$T/observatory.jsonl" "$T/mirror.jsonl" "$T/note.md"; do
  grep -q '"c": "testcat"' "$f" && grep -q '"o": "hello world"' "$f" \
    && echo "ok: obs appends $(basename "$f")" \
    || { echo "FAIL: obs appends $(basename "$f")"; fail=1; }
done
python3 - "$T/observatory.jsonl" <<'PYEOF' \
  && echo "ok: obs line is valid JSON" || { echo "FAIL: obs line is valid JSON"; fail=1; }
import json, sys
d = json.load(open(sys.argv[1]))
assert d == {"d": "2026-10-17", "c": "testcat", "o": "hello world"}, d
PYEOF
"$DIR/obs.sh" onlyone 2>/dev/null && { echo "FAIL: obs usage error"; fail=1; } || echo "ok: obs usage error"

# verify-live.sh: dead control -> UNKNOWN exit 2, never DOWN
out="$("$DIR/verify-live.sh" "https://127.0.0.1:9/" "https://127.0.0.1:9/app" 2>&1)"; code=$?
[[ $code -eq 2 ]] && echo "ok: verify-live exit 2 on dead control" || { echo "FAIL: verify-live exit 2 (got $code)"; fail=1; }
echo "$out" | grep -q "UNKNOWN" && ! echo "$out" | grep -q "DOWN" \
  && echo "ok: verify-live says UNKNOWN, never DOWN" \
  || { echo "FAIL: verify-live says UNKNOWN, never DOWN"; fail=1; }

# verify-live.sh: live local control+app -> SERVING exit 0
PORT=18081
python3 -m http.server "$PORT" --bind 127.0.0.1 >/dev/null 2>&1 &
SRV=$!
sleep 1
out="$(unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY; export no_proxy="*"; "$DIR/verify-live.sh" "http://127.0.0.1:$PORT/" "http://127.0.0.1:$PORT/" 2>&1)"; code=$?
kill "$SRV" 2>/dev/null
[[ $code -eq 0 ]] && echo "$out" | grep -q "SERVING" \
  && echo "ok: verify-live SERVING on live app" \
  || { echo "FAIL: verify-live SERVING on live app"; fail=1; }

# scope-box dry-run is heavy: usage check only
"$DIR/scope-box.sh" --help >/dev/null 2>&1 \
  && echo "ok: scope-box usage" || { echo "FAIL: scope-box usage"; fail=1; }
"$DIR/scope-box.sh" 2>/dev/null && { echo "FAIL: scope-box usage error"; fail=1; } || echo "ok: scope-box usage error"

# check-kids static shape only: usage error path, no network
"$DIR/check-kids.sh" 2>/dev/null && { echo "FAIL: check-kids usage error"; fail=1; } || echo "ok: check-kids usage error"

# price-drift must be SYNC on the current tree
SLID="${SLIDPHILABS_ROOT:-/home/ceedotrock/src/SlidPhiLabs}"
out="$("$DIR/check-price-drift.sh" "$SLID" 2>&1)" \
  && echo "$out" | grep -q "PRICE-SYNC" \
  && echo "ok: price-drift SYNC" \
  || { echo "FAIL: price-drift SYNC ($out)"; fail=1; }

# discovery-sync is recorded but non-gating
out="$("$DIR/check-discovery-sync.sh" "$SLID" 2>&1)" || true
echo "$out"
echo "ok: discovery-sync recorded (non-gating)"

# thrift gate: 50 laws wired (durable collateral for the thrift enactment)
"$DIR/thrift-check.sh" >/dev/null 2>&1 \
  && echo "ok: thrift green" || { echo "FAIL: thrift green"; fail=1; }

[[ $fail -eq 0 ]] && echo "TOOLS-GREEN" || { echo "TOOLS-RED"; exit 1; }
