# psi sell kit — copy-paste pack for every surface

Evidence-linked claims only. Every number below was observed in-repo;
do not inflate them. License: AGPL-3.0, commercial on request.

## One-line pitch

psi is the memory machinery that stops AI agents starting every
session blank: append-only experience log, runnable gates, protocols,
and goals — 116 tweaks, green-gated, self-hosted in one repo.

## 30-second pitch (marketplaces, repo header, HN)

An agent that starts every session blank cannot compound. psi fixes
that with the boring parts done right: every session opens by reading
identity, the newest experience log, goals, and environment model;
every lesson lands in an append-only log with a runnable check behind
it. What it is: 116 file/script/protocol tweaks, one `psi-doctor.sh`
green gate, a relevance-retrieval scorer, pre-flight guardrails, a
token-savings meter, and a successor drill that makes a blank session
operational. What it is not: a model, a host, or a subscription.

## Proof points (use, don't assert)

- `bash scripts/psi-doctor.sh` → `PSI-GREEN: quad complete, 116 wired`
- Demo transcript: `DEMO.md` (nothing faked, dated outputs)
- Token meter: `scripts/savings.py` → cost-basis savings 83.83%
  (stated assumptions: cached input 0.1x, output 3x); plan-22
  avoided/(actual+avoided) tracked separately and honestly small
- Live-suite: `scripts/verify-live.sh` reports UNKNOWN, never DOWN,
  when the sandbox itself has no route
- License: AGPL-3.0 OR commercial (`LICENSE.COMMERCIAL`)

## X thread (5 posts)

1. Agents that wake up blank can't compound. I built the machinery
   that fixes it: psi — persistent superintelligence, workspace-realized.
2. The whole trick is unglamorous: append-only experience log +
   runnable gates + protocols + goals. 116 tweaks, each a file,
   script, or protocol. One command proves all of them green.
3. Best part: relevance retrieval over scars, not recency. The right
   past mistake surfaces for the task at hand, scored by fit.
4. It meters itself: token-savings meter with price-book classes,
   honest about what's measured vs modeled. 83.83% cost-basis savings
   from cache discipline alone.
5. AGPL-3.0, commercial licenses available. Repo + demo transcript
   in the replies. Steal the patterns even if you skip the repo.

## Reddit post (r/AI_Agents / r/selfhosted — check each sub's rules first)

Title: I gave my coding agent persistent memory with 116 runnable
tweaks — one command proves all of them green

Body: the problems (blank sessions, repeated mistakes, unverifiable
claims), the shape (log + gates + protocols + goals), the proof
(doctor output, DEMO.md transcript, savings meter), the license
(AGPL/commercial), ask: what would you add as tweak 117?

## dev.to / Hashnode article outline

1. The blank-session problem, with a real repeated-mistake anecdote
2. The four-piece shape: log, gates, protocols, goals
3. Relevance retrieval: score scars by fit, not recency (show the query)
4. Guardrails that fail closed (preflight DENY/WARN/OK transcript)
5. Metering thrift: price book + savings meter, honest numbers
6. Succession drill: the blank-session test (tweak 116)
7. Take the patterns: five tweaks worth stealing this week

## Hacker News (Show HN)

Title: Show HN: psi — 116 runnable tweaks for persistent agent memory
Comment: lead with the problem and the doctor transcript; state the
license up front; answer the "why not just RAG?" question with the
retrieval demo. Post once, morning US time, and stay for comments.

## Gumroad / marketplace listing copy

Title: psi — persistent agent memory, 116 runnable tweaks
What you get: the full repo, green-gate verified; commercial use
without AGPL obligations (license file included); the sell-kit
patterns for your own docs.
Pricing: operator sets this — suggestion: launch discount, then a
price that hurts individuals slightly less than one wasted
GPU-hour debugging session. Do not set a price here without the
operator's exact word.

## Posting checklist (per surface)

- [ ] Claims match the proof points above — no new numbers
- [ ] License stated wherever code is offered
- [ ] Reply window blocked after posting (HN, Reddit)
- [ ] Inbound questions harvested back into psi as surprises
