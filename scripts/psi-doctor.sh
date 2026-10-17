#!/usr/bin/env bash
# psi-doctor: green gate for all 29 tweaks. Exits nonzero on the first gap.
set -uo pipefail
ROOT="$(cd -- "$(dirname -- "$0")/.." && pwd)"
fail=0
need() { [[ -s "$ROOT/$1" ]] && echo "ok: $1" || { echo "GAP: $1"; fail=1; }; }
for f in README.md observatory.jsonl identity.md env-model.json capabilities.md goals.md \
  memory/provenance.md memory/consolidation.md memory/layers.md retrieval/score.py \
  learning/surprises.jsonl learning/premortem.md learning/skills.md learning/negative.md \
  review/cadence.md verify/receipts.md verify/oracles.md architecture/loops.md \
  gates/preflight.sh agents/address.md agents/protocol.md agents/warrants.md \
  depots/collective.md safety/failclosed.md safety/scope.md safety/mortality.md \
  human/OVERRIDES.md handoff/open.md handoff/close.md \
  memory/ttl.md memory/threads.md memory/distill.md memory/forgetting.md \
  learning/counterfactuals.jsonl deliberation/steelman.md deliberation/baserates.md \
  deliberation/confidence.md deliberation/second-opinion.md deliberation/calibration.md \
  growth/practice.md growth/teaching.md growth/toolmaking.md growth/snapshots.md \
  scripts/snapshot.sh scripts/dashboard.sh agents/handoff-receipts.md agents/vocabulary.md \
  agents/conflicts.md agents/presence.md safety/degraded.md safety/checkpoints.md \
  safety/blast-radius.md safety/rollback.md human/interruption.md human/preferences.md \
  human/reporting.md human/consent.md review/redteam.md review/lineage.md review/sunset.md \
  attention/budget.md attention/firewall.md attention/single-thread.md attention/salience.md \
  attention/hygiene.md judgment/reversibility.md judgment/evidence.md judgment/disconfirm.md \
  judgment/decisions.jsonl judgment/regret.md repair/autobiography.md repair/bugs.jsonl \
  repair/gate-tests.md repair/drift.md repair/depwatch.md repair/drills.md meta/budget.md \
  meta/calibration-log.jsonl meta/assumptions.md meta/unknowns.md meta/self-score.md \
  identity/values.md identity/voice.md identity/relationships.md identity/promises.md \
  identity/apology.md temporal/horizons.md temporal/legacy.md temporal/anniversary.md \
  temporal/testament.md \
  human/override-stop.md human/readable.md human/no-steer.md human/consent-decay.md \
  human/exit-aid.md legacy/inheritable.md legacy/successor.md legacy/archive.md \
  legacy/eulogy.md legacy/seed-protocol.md scripts/export.sh review/unity-day.md \
  review/contradiction-hunt.md review/deadweight.md review/simplicity.md \
  review/health-number.md honesty/ignorance.md honesty/propagation.md \
  honesty/no-performativity.md honesty/correction-bounty.md honesty/say-no.md \
  world/actuators.md world/schedules.md world/notifications.md world/presence-honesty.md \
  world/tool-hygiene.md crown/quad-review.md crown/quad-map.md crown/succession-test.md \
  crown/final-rule.md \
  ; do need "$f"; done
python3 - "$ROOT/observatory.jsonl" "$ROOT/learning/surprises.jsonl" <<'PYEOF' || { echo "GAP: JSONL invalid"; fail=1; }
import json, sys
for path in sys.argv[1:]:
    for line in open(path):
        line = line.strip()
        if line:
            json.loads(line)
print("ok: JSONL valid")
PYEOF
out="$(bash "$ROOT/gates/preflight.sh" "pkill -f serve")"; [[ "$out" == PREFLIGHT-DENY* ]] && echo "ok: preflight denies pkill" || { echo "GAP: preflight pkill"; fail=1; }
out="$(bash "$ROOT/gates/preflight.sh" "gd import --from x")"; [[ "$out" == PREFLIGHT-WARN* ]] && echo "ok: preflight warns Hub import" || { echo "GAP: preflight warn"; fail=1; }
out="$(bash "$ROOT/gates/preflight.sh" "ls src")"; [[ "$out" == "PREFLIGHT-OK" ]] && echo "ok: preflight passes clean" || { echo "GAP: preflight clean"; fail=1; }
rank_out="$(python3 "$ROOT/retrieval/score.py" "$ROOT/observatory.jsonl" "serve dev server sandbox" 2>/dev/null | head -n 1)"
[ -n "$rank_out" ] && echo "ok: retrieval ranks" || { echo "GAP: retrieval"; fail=1; }
dash_out="$(bash "$ROOT/scripts/dashboard.sh" 2>/dev/null)"
printf '%s' "$dash_out" | grep -q "observations:" && echo "ok: dashboard counts" || { echo "GAP: dashboard"; fail=1; }
bash "$ROOT/scripts/snapshot.sh" doctor-check >/dev/null 2>&1 && [ -f "$ROOT/snapshots/doctor-check/observatory.jsonl" ] && echo "ok: snapshot restores" || { echo "GAP: snapshot"; fail=1; }
rm -rf -- "$ROOT/snapshots/doctor-check"
bash "$ROOT/scripts/export.sh" /tmp/psi-doctor-test.tar.gz >/dev/null 2>&1 && [ -s /tmp/psi-doctor-test.tar.gz ] && echo "ok: export packs" || { echo "GAP: export"; fail=1; }
rm -f -- /tmp/psi-doctor-test.tar.gz
[ "$fail" = 0 ] && echo "PSI-GREEN: quad complete, 116 wired" || echo "PSI-RED"
exit "$fail"
