# Assumption ledger (tweak 77) — live assumptions per task, each with a kill-check.
Write them down at task start: what must be true for this plan to work, and the
single cheapest check that would kill each. An assumption that survives its
kill-check graduates to evidence (tweak 66); one that fails ends the plan early,
which is the check paying for itself.
2026-10-18: fly-ssh cannot run here (agent unix socket will not bind in sandbox) — volume reads need another path or a human.
2026-10-18: gh works through the proxy — keep proxy vars for external checks, only loopback bypasses them.
Corrected 2026-10-17 (v2): external hosts ARE reachable via proxy env; only loopback bypasses it (no_proxy+=localhost,127.0.0.1). Stripping all proxy vars breaks external checks — verify-live.sh keeps them. A dead control-host probe still means UNKNOWN, never DOWN.
