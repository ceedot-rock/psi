# Rollback plans (tweak 51) — every persistent mutation names its undo first.
git checkout -- <file> for tracked edits; rm for scratch; depot state is
append-only (compensate, don't rewrite). No undo named = no mutation executed.
