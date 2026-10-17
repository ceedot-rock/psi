#!/usr/bin/env bash
# verify-live.sh — honest live-site verdicts. Never reports "down" when the
# sandbox itself has no outbound route: a control host is probed first, and
# when the control fails every verdict is UNKNOWN (exit 2), not DOWN.
# Usage: verify-live.sh [control-url] [app-url ...]
# Default apps: the Fly-served lab surface.
set -uo pipefail

# External hosts go through the proxy; only loopback bypasses it.
export no_proxy="${no_proxy:+,}localhost,127.0.0.1"

CONTROL="${1:-https://registry.npmjs.org/}"
shift || true
APPS=("$@")
[[ ${#APPS[@]} -gt 0 ]] || APPS=(
  "https://slidphilabs.fly.dev/healthz"
  "https://www.slidphilabs.com/healthz"
  "https://agentrider.fly.dev/"
  "https://teachaid.fly.dev/api/agent"
)

probe() { # url -> "code <n>" | "FAIL <reason>"
  local out code
  out="$(curl -sL -o /dev/null -w "%{http_code}" --max-time 15 "$1" 2>&1)" && {
    code="$out"
    [[ "$code" == "000" ]] && echo "FAIL no-route-or-timeout" || echo "code $code"
  } || echo "FAIL curl-error"
}

fail=0
control="$(probe "$CONTROL")"
echo "control $CONTROL -> $control"
if [[ "$control" == FAIL* ]]; then
  echo "UNKNOWN: no outbound route from here; cannot judge any app (exit 2)"
  for app in "${APPS[@]}"; do echo "UNKNOWN $app (control failed)"; done
  exit 2
fi
for app in "${APPS[@]}"; do
  r="$(probe "$app")"
  if [[ "$r" == "code 2"* || "$r" == "code 3"* ]]; then
    echo "SERVING $app -> $r"
  else
    echo "DOWN $app -> $r"
    fail=1
  fi
done
exit "$fail"
