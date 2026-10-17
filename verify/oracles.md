# Independent oracles (tweak 17) — who grades the work.
1. The repo's own suite (Hub unittest, conductor node --test, muse-life breath tests).
2. Byte-level comparison (fetch vs source, emitted vs expected).
3. A second method (direct-serve harness vs wrangler; unittest vs manual flow).
4. Falsifiable prediction (pre-mortem tripwires).
Self-authored scripts may probe but never close; only 1-4 close.
