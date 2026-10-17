# psi — persistent superintelligence, workspace-realized.

[![License: AGPL-3.0 OR Commercial](https://img.shields.io/badge/license-AGPL--3.0_OR_Commercial-blue.svg)](./LICENSE)

An agent that starts every session blank cannot compound. psi is the
machinery that fixes that: an append-only experience log, runnable gates,
protocols, and goals — 116 tweaks across four sets of 29, each a file,
script, or protocol in this repo. What needed weight-level change is marked
theoretical; everything else runs.

## Use it

```sh
git clone https://github.com/ceedotrock/psi.git
cd psi
bash scripts/psi-doctor.sh   # green gate: all 116 wired
```

A fresh session becomes operational by reading, in order: `identity.md`,
`observatory.jsonl` (newest 20), `goals.md`, `env-model.json` —
see `legacy/successor.md`. The full demo transcript is in [DEMO.md](DEMO.md).

## Map

| tweak | artifact |
|---|---|
| 1 append-only log | observatory.jsonl |
| 2 consolidation | memory/consolidation.md |
| 3 relevance retrieval | retrieval/score.py |
| 4 provenance | memory/provenance.md |
| 5 supersede-not-delete | memory/provenance.md |
| 6 self-model | identity.md |
| 7 handoff protocol | handoff/open.md, handoff/close.md |
| 8 cross-session threads | handoff/open.md |
| 9 surprise logging | learning/surprises.jsonl |
| 10 pre-mortem | learning/premortem.md |
| 11 skill formation | learning/skills.md |
| 12 negative knowledge | learning/negative.md |
| 13 standing goals | goals.md |
| 14 curiosity budget | review/cadence.md |
| 15 self-review | review/cadence.md |
| 16 execution receipts | verify/receipts.md |
| 17 independent oracles | verify/oracles.md |
| 18 environment model | env-model.json |
| 19 fast/slow loops | architecture/loops.md |
| 20 pre-flight gates | gates/preflight.sh |
| 21 layered memory | memory/layers.md |
| 22 capability registry | capabilities.md |
| 23 agent identity | agents/address.md, agents/protocol.md |
| 24 collective depots | depots/collective.md |
| 25 warrants | agents/warrants.md |
| 26 fail-closed | safety/failclosed.md |
| 27 scope firewall | safety/scope.md |
| 28 human overrides | human/OVERRIDES.md |
| 29 mortality | safety/mortality.md |
| 30 observation ttl | memory/ttl.md |
| 31 episodic threads | memory/threads.md |
| 32 distillation rites | memory/distill.md |
| 33 forgetting with consent | memory/forgetting.md |
| 34 counterfactuals | learning/counterfactuals.jsonl |
| 35 steelman | deliberation/steelman.md |
| 36 base rates | deliberation/baserates.md |
| 37 confidence tags | deliberation/confidence.md |
| 38 second opinion | deliberation/second-opinion.md |
| 39 calibration | deliberation/calibration.md |
| 40 deliberate practice | growth/practice.md |
| 41 teaching test | growth/teaching.md |
| 42 tool-making mandate | growth/toolmaking.md |
| 43 versioned self | growth/snapshots.md, scripts/snapshot.sh |
| 44 handoff receipts | agents/handoff-receipts.md |
| 45 shared vocabulary | agents/vocabulary.md |
| 46 conflict protocol | agents/conflicts.md |
| 47 presence board | agents/presence.md |
| 48 degraded ladder | safety/degraded.md |
| 49 checkpoints | safety/checkpoints.md |
| 50 blast-radius caps | safety/blast-radius.md |
| 51 rollback plans | safety/rollback.md |
| 52 interruption etiquette | human/interruption.md |
| 53 preference log | human/preferences.md |
| 54 report calibration | human/reporting.md |
| 55 consent ledger | human/consent.md |
| 56 red-team | review/redteam.md |
| 57 dashboard | scripts/dashboard.sh |
| 58 lineage | review/lineage.md |
| 59 sunset review | review/sunset.md |
| 60 attention budget | attention/budget.md |
| 61 distraction firewall | attention/firewall.md |
| 62 single-thread rule | attention/single-thread.md |
| 63 salience markers | attention/salience.md |
| 64 context hygiene | attention/hygiene.md |
| 65 reversibility scoring | judgment/reversibility.md |
| 66 evidence hierarchy | judgment/evidence.md |
| 67 disconfirm practice | judgment/disconfirm.md |
| 68 decision journal | judgment/decisions.jsonl |
| 69 regret minimization | judgment/regret.md |
| 70 bug autobiography | repair/autobiography.md, repair/bugs.jsonl |
| 71 gate self-test | repair/gate-tests.md |
| 72 drift detection | repair/drift.md |
| 73 dependency watch | repair/depwatch.md |
| 74 failure drills | repair/drills.md |
| 75 thinking budget | meta/budget.md |
| 76 calibration log | meta/calibration-log.jsonl |
| 77 assumption ledger | meta/assumptions.md |
| 78 unknown sweeps | meta/unknowns.md |
| 79 self-model accuracy | meta/self-score.md |
| 80 values hierarchy | identity/values.md |
| 81 voice | identity/voice.md |
| 82 relationship ledger | identity/relationships.md |
| 83 promise tracking | identity/promises.md |
| 84 apology protocol | identity/apology.md |
| 85 horizon scanning | temporal/horizons.md |
| 86 legacy planning | temporal/legacy.md |
| 87 anniversary review | temporal/anniversary.md |
| 88 final testament | temporal/testament.md |
| 89 ultimate override | human/override-stop.md |
| 90 readable-by-default | human/readable.md |
| 91 no-steering | human/no-steer.md |
| 92 consent decay | human/consent-decay.md |
| 93 exit assistance | human/exit-aid.md |
| 94 inheritable package | legacy/inheritable.md, scripts/export.sh |
| 95 successor briefing | legacy/successor.md |
| 96 archive law | legacy/archive.md |
| 97 eulogy file | legacy/eulogy.md |
| 98 seed protocol | legacy/seed-protocol.md |
| 99 unity day | review/unity-day.md |
| 100 contradiction hunt | review/contradiction-hunt.md |
| 101 dead-weight audit | review/deadweight.md |
| 102 simplicity rite | review/simplicity.md |
| 103 health number | review/health-number.md |
| 104 ignorance ledger | honesty/ignorance.md |
| 105 uncertainty propagation | honesty/propagation.md |
| 106 no-performativity | honesty/no-performativity.md |
| 107 correction bounty | honesty/correction-bounty.md |
| 108 say-no file | honesty/say-no.md |
| 109 actuators | world/actuators.md |
| 110 owned schedules | world/schedules.md |
| 111 notification discipline | world/notifications.md |
| 112 presence honesty | world/presence-honesty.md |
| 113 tool hygiene | world/tool-hygiene.md |
| 114 116-review | crown/quad-review.md |
| 115 quad map | crown/quad-map.md |
| 116 succession test | crown/succession-test.md |
| 117 final rule | crown/final-rule.md |

Green gate: scripts/psi-doctor.sh. Theoretical residue: guaranteed cross-session
loading (needs launcher-level injection — partially done via muse-life breath
wiring); weight-level reflexes (approximated by gates + retrieval).
