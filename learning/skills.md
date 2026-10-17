# Skill graduations (tweak 11) — repeated patterns promoted to tested tooling.
- in-launch serve+verify harness (child process shares netns) — used for Hub, conductor, universimulator. Next: one shared script.
- fork-repo.py pattern (tar, import, fetch, cmp, depot-post) — parameterized, reused for L33tVerse.
- direct-serve worker harness (plain Node in front of a fetch handler) — bypasses broken dev servers.
Rule: third use of a pattern triggers graduation; a graduated pattern gets a test or it stays a pattern.
