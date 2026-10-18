# Deploys (tweaks 147-150) — depot builders are unreachable from the sandbox.
CI builds the image; `fly deploy --image` ships it. No depot, no remote build.
A release counts only with a release-must-move receipt: `fly releases` shows
a new version after the deploy. Confirm with sleep-then-content-probe (not
status alone): wait, then probe served content for the change. Schema moves
by hand: migrations ship with an open apply-me flag, never silent auto-apply.
