#!/usr/bin/env bash
# check-price-drift.sh — canonical seat meter in the packages must match pricing.json.
# Usage: check-price-drift.sh [repo-root (default /home/ceedotrock/src/SlidPhiLabs)]
# Scope: pps suite meter vs pricing.json suite, plus root sku anchors in SKU_MAP.
# Prints drift lines (exit 1) or PRICE-SYNC (exit 0).
set -uo pipefail
ROOT="${1:-/home/ceedotrock/src/SlidPhiLabs}"

drift="$(python3 - "$ROOT" <<'EOF'
import json, sys
root = sys.argv[1]
pps = json.load(open(root + '/packages/spl-pay-per-suite/package.json'))
pkg = json.load(open(root + '/package.json'))
price = json.load(open(root + '/docs/site/pricing.json'))
out = []
suite, want = pps['agentic']['suite_pricing'], price['suite']
for f in ('free_cap_gb', 'usd_per_gb_after_free', 'min_paid_usd', 'window'):
    if suite.get(f) != want.get(f):
        out.append('drift: suite_pricing.%s pps=%s pricing.json=%s' % (f, suite.get(f), want.get(f)))
for sku, math in (('chamber-year', 'chamber_year'),):
    a = pkg['pricing']['skus'][sku]['usd']
    b = price['math'][math]
    if a != b:
        out.append('drift: sku %s root=%s pricing.json(%s)=%s' % (sku, a, math, b))
print('\n'.join(out))
EOF
)"
if [[ -z "$drift" ]]; then
  echo "PRICE-SYNC"
else
  printf '%s\n' "$drift"
  exit 1
fi
