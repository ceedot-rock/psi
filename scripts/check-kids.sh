#!/usr/bin/env bash
# check-kids.sh — detect signing-vs-verification key skew.
# Usage: check-kids.sh <jwt> <jwks-url>
# Prints the token kid, the published kids, verdict MATCH (exit 0) or SKEW (exit 1).
set -uo pipefail
[[ $# -eq 2 ]] || { echo "usage: check-kids.sh <jwt> <jwks-url>" >&2; exit 2; }
JWT="$1"; URL="$2"

KID="$(python3 - "$JWT" <<'EOF'
import base64, json, sys
def pad(s):
    return s + '=' * (-len(s) % 4)
try:
    hdr = json.loads(base64.urlsafe_b64decode(pad(sys.argv[1].split('.')[0])).decode())
except Exception as e:
    sys.stderr.write("bad jwt header: %s\n" % e)
    sys.exit(2)
print(hdr.get('kid') or '')
EOF
)" || exit 2
[[ -n "$KID" ]] || { echo "SKEW: token carries no kid" >&2; exit 1; }
echo "token kid: $KID"

JWKS="$(curl -sL --max-time 15 "$URL" 2>&1)" || { echo "FAIL: cannot fetch $URL" >&2; exit 2; }
PUBS="$(printf '%s' "$JWKS" | python3 -c 'import json,sys; print("\n".join(k.get("kid") or "" for k in json.load(sys.stdin).get("keys", [])))')" \
  || { echo "FAIL: bad JWKS from $URL" >&2; exit 2; }
echo "published kids:"
printf '%s\n' "$PUBS" | sed 's/^/  /'
if printf '%s\n' "$PUBS" | grep -qxF "$KID"; then
  echo "MATCH: token kid is published"
else
  echo "SKEW: token kid not in published set"
  exit 1
fi
