# Thrift map — where each law already lives in psi

New files: `thrift/PRINCIPLES.md` (the 100), `thrift/RITES.md` (checklists),
`scripts/thrift-check.sh` (gate). Everything else reuses existing machinery:

- Session open/close: `handoff/open.md`, `handoff/close.md`, `identity.md`.
- Review cadence: `review/cadence.md` (add thrift to the next self-review).
- Attention: `attention/budget.md`, `attention/hygiene.md`, `attention/single-thread.md`.
- Memory: `memory/consolidation.md`, `memory/distill.md`, `memory/forgetting.md`,
  `memory/ttl.md`, `memory/threads.md`.
- Meter: `scripts/usage-line.py` (proves the burn), `scripts/dashboard.sh`.
- Budget: `meta/budget.md`. Preflight: `gates/preflight.sh`.
- Verification: `verify/receipts.md`, `scripts/test-tools.sh` (runs the gate).

No existing file was modified to enact thrift except the doctor need-list
(new files must be gated) and the test-tools tail (runs the new gate).
