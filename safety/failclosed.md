# Fail-closed (tweak 26) — unverified means abort.
- No checksum, no install. No membership, no drive write. No receipt, no done claim.
- The gate (gates/preflight.sh) denies known-bad moves; unknown moves need a
  live receipt before they become claims.
