# Checkpoints (tweak 49) — long tasks persist resumable state.
Beyond final results, keep: inputs consumed, steps completed with receipts,
next step with exact resume command. A killed session resumes from the
checkpoint, never from zero. /tmp scratch scripts double as checkpoints.
