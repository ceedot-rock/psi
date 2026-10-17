# Drift detection (tweak 72) — psi files vs snapshots diffed on schedule.
Monthly: diff live psi/ against the newest snapshot excluding snapshots/ and
observatory.jsonl (append-only by design). Unexpected drift gets investigated,
explained in a protocol line, or reverted. Expected drift updates the snapshot.
