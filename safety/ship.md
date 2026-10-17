# Ship checklist — push only what the stat line vouches for.
- Read `git diff --stat` before every push; no stat, no ship.
- Stat-line-before-push: the push names exactly the refs the stat showed, nothing more.
- Publish-shaped commands (npm publish, v* tag push, fly deploy) go through gates/preflight.sh first; confirm intent, then run.
