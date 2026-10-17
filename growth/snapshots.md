# Versioned self (tweak 43) — the machinery's evolution stays auditable.
scripts/snapshot.sh copies psi/ (minus snapshots/) to snapshots/<date>.
Snapshot before any structural change; monthly regardless. Diffs between
snapshots are the autobiography of the system. Never snapshot secrets.
