# DEMO — psi working, observed 2026-10-17. Nothing here is faked.

## Green gate

```sh
$ bash scripts/psi-doctor.sh
ok: preflight denies pkill
ok: preflight warns Hub import
ok: preflight passes clean
ok: retrieval ranks
ok: dashboard counts
ok: snapshot restores
ok: export packs
PSI-GREEN: quad complete, 116 wired
```

## Dashboard

```sh
$ bash scripts/dashboard.sh
observations: 14
surprises: 5
near-misses: 2
goals open: 3
goals done: 6
snapshots: 3
```

## Relevance retrieval

```sh
$ python3 retrieval/score.py observatory.jsonl "serve dev server sandbox"
6 [sandbox-limits] vite/wrangler dev die on uv_interface_addresses (blocked); plain node servers work; environmental, route around
3 [residue] serve scratch from temp dirs; seeds can rewrite tracked files (cuni-example.json): git checkout after
3 [hub-state] data/ gitignored in hub: server state there never pollutes repo
```

The right scar surfaces for the task, scored by fit — not recency.

## Pre-flight gate

```sh
$ bash gates/preflight.sh "pkill -f serve"
PREFLIGHT-DENY: pkill patterns have killed our own shell twice; use exact PIDs
$ bash gates/preflight.sh "ls src"
PREFLIGHT-OK
```

## Successor drill

A blank session reads `legacy/successor.md`, runs the doctor, and is
operational. The yearly succession test (tweak 116) rehearses exactly this.
