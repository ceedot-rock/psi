#!/usr/bin/env bash
# Pre-flight gate (tweak 20): fail-closed checks from negative knowledge.
# Usage: preflight.sh "<command string>" — exits nonzero with the reason on a hit.
set -uo pipefail
cmd="${1:-}"
hit() { echo "PREFLIGHT-DENY: $1"; exit 1; }
case "$cmd" in
  *pkill*) hit "pkill patterns have killed our own shell twice; use exact PIDs" ;;
  *wrangler\ dev*|*"vite "*dev*|*vite\ --host*) hit "dev servers die on uv_interface_addresses in this sandbox; use a plain-Node harness" ;;
  *curl*\ 127.0.0.1*|*curl*\ localhost*) hit "curl honors proxy env; export no_proxy='*', unset proxies first" ;;
esac
if [[ "$cmd" == *"drive"*upload* || "$cmd" == *"gd import"* ]]; then
  echo "PREFLIGHT-WARN: Hub drive needs membership + 2-of-3 shards; blob cap 8 MB"
fi
echo "PREFLIGHT-OK"
