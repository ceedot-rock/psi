---
type: reference
---

# Token economy (2026-10-26, measured where stated, modeled where marked)

Standing facts: input outweighs output ~127:1, so every plan below attacks
input first. Prompt caching is ALREADY ON and carrying ~94% of input
(measured 2026-10-26 via `usage-line.py`: 288.8M/304.3M cached on the
marathon session, 95.7M/101.6M here). An early single-record sample
wrongly read zero — corrected by the aggregate. PSI corpus costs ~4k
tokens per session to load. Per-step prices from session logs: 18k
(small sessions) to 75k (marathon contexts). A dead-end rabbit hole
runs 0.1–1M tokens.

## A. Cache the context (platform; already working — protect it)

1. Caching is on (~94% of input served from cache). The lever is now
   defensive: keep it engaged and watch the meter. If `cached` share ever
   collapses, treat it as an incident, not background noise.
2. Keep prompt prefixes stable (system, skills, memory in fixed order) so
   cache blocks keep hitting instead of churning.

## B. Spend fewer turns (each turn re-sends full context)

3. No-poll discipline. Every status poll is a full-context turn (~60k+ tokens
   at current sizes); this session burned ~15 polls. Wait for delivery; check
   once only when the check gates substantive next work.
4. Batch independent calls per turn (already the norm; keep it a rule).
5. One-shot commands. Read before acting; combine probe chains so fixes land
   first try instead of ping-pong.
6. Never re-run a green check. A second identical run buys zero information
   for a full context re-send. (Already repo law; extend to ad-hoc probes.)
7. Size delegation. One child per subtask *group*, ≤15 total — each child
   carries its own context copy, so fan-out is token spend.

## C. Shrink what turns carry

8. Bounded reads, tail-first. The 94MB-log discipline is the standing pattern:
   slices and windows, never whole multi-megabyte files into context.
9. Cap tool output (`max_output_tokens` small); persist big outputs to files
   and quote receipts, not dumps.
10. Load each skill once per session, reuse the result.
11. Deltas over rewrites (`edit_file` for changes; `write_file` for new).
    Whole-file content in args is context too.
12. Concise replies. Output is 1/127th of spend — minor, but dumps compound
    when quoted back.

## D. Avoid the work entirely

13. Prospective avoidance log. Every applied lesson with its price-book cost
    goes to the observatory the same turn; the log IS the savings meter.
14. Policy files over deliberation (intune `policy.json` pattern): decide
    from counts on disk instead of re-reasoning each session.
15. Golden files and receipts. Bench once, read back forever; never recompute
    what a file already proves.
16. Kill-switch hygiene. Terminate superseded background runs immediately —
    session-level stops can orphan workers (seen: 11 strays), which burn CPU
    and force re-runs. Verify by process list, not by faith.
17. Session sizing. Resume chains context forever; a fresh session plus a
    handoff note resets the prefix. Trade-off: resets cache sympathy too —
    prefer fresh starts at natural boundaries (project switches, day breaks).

## E. Route wisely

18. Lighter models for scut work (fetch-and-grep children), full strength
    for design and debugging. Specify per child; never default everything up.
19. Fewer, larger model calls over chatty sequences; group questions so one
    human round-trip settles a decision instead of five.
20. Expensive verifications (full benches, corpus runs) go to background with
    no polling; results arrive free.

## F. Measure to manage

21. Standing per-session usage line in the observatory: total in/out, steps,
    error-batch share. Produced by `psi/scripts/usage-line.py [--log]`
    (single-record samples lie; always read the aggregate). No meter,
    no management.
22. Price book + avoided log (design settled 2026-10-26): incident classes
    priced from real past loops; savings% = avoided / (actual + avoided).
23. Cache-hit check after enabling (A1): confirm `cached_tokens` climbs;
    if it doesn't, the biggest plan silently failed.

## Explicit non-plans

- Shrinking answers to save output tokens: 1/127th, not worth quality loss.
- Skipping verification runs that gate correctness: a re-run is cheaper than
  shipping a bug, which costs a whole debugging session.
- Compressing PSI/memory below usefulness: the 4k load prevents 0.1–1M
  dead ends; starving it is penny-wise.
