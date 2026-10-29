# Thrift principles — 50 token-saving laws, enacted 2026-10-28

Distilled from the 100-item token-economy survey (items 1-100). Each law has
an ID (T01-T50). The gate (`scripts/thrift-check.sh`) verifies all 50 IDs
are present exactly once. Laws are binding on agent sessions in this repo.

## A. Context and session (T01-T11)

- T01: pin prompt-prefix order (system, skills, memory fixed) so cache blocks hit.
- T02: one goal per session; topic swerves re-send full context for nothing.
- T03: cap shell output at the source (First/head/tail), never dump-then-trim.
- T04: read file windows, never whole files; never re-read in-context files.
- T05: shrink tool results before returning (grep/filter first).
- T06: no status polling; one check only when it gates substantive work.
- T07: batch independent calls per turn; each turn re-sends everything.
- T08: resume from log summaries, never by replaying transcripts.
- T09: split multi-goal work; restart wedged sessions instead of debugging inside bloat.
- T10: keep the working directory tight; broad listings are token waste.
- T11: archive old session logs out of the live sessions directory.

## B. Prompts (T12-T18)

- T12: instructions before context; state the stop condition up front.
- T13: forbid exploratory narration; report deltas only.
- T14: give file paths, not descriptions of locations.
- T15: paste error text once; never re-paste in follow-ups.
- T16: "no explanation needed" on mechanical tasks.
- T17: reference prior conclusions by name instead of re-deriving them.
- T18: pre-answer the obvious follow-up in the same message.

## C. Tools (T19-T31)

- T19: `git diff --stat` before full diff; full diffs only when stat justifies.
- T20: tight globs per search; cap matches; files_with_matches to locate.
- T21: one discovery pass per task; never re-scan the same tree.
- T22: combine status checks into one command per turn.
- T23: quiet flags on installs/builds; logs to files, grep them.
- T24: never cat binaries, lockfiles, or generated bundles into context.
- T25: exclude node_modules/dist/vendor from every operation by default.
- T26: read diffs after an edit, not whole files.
- T27: verify edits by running, not by re-reading.
- T28: kill runaway commands fast; wedged processes stream tokens till stopped.
- T29: link files instead of quoting them.
- T30: report deltas (files changed, tests green), not play-by-plays.
- T31: tables over prose for comparisons; verdicts in chat, bulk in files.

## D. Code changes (T32-T39)

- T32: fix root causes; symptom patches spawn follow-up sessions.
- T33: smallest diff that closes the issue; refactors are separate sessions.
- T34: reproduce before fixing so the fix lands on attempt one.
- T35: read the test file before the source; tests state the contract faster.
- T36: focused test file during iteration, never the full suite.
- T37: no re-runs of green suites "to be sure"; trust the last green.
- T38: typecheck/lint the touched package only.
- T39: one behavior per change; bundled changes multiply review turns.

## E. Memory (T40-T45)

- T40: promote repeated context into memory files once, reference forever.
- T41: demote stale memory; outdated notes cause correction spirals.
- T42: atomic memory entries; one fact per line.
- T43: snapshot decisions with reasons; re-deciding is pure burn.
- T44: expire time-bound notes (prices, versions, statuses) on a schedule.
- T45: keep a do-not-re-derive list for settled questions.

## F. Multi-agent (T46-T49)

- T46: fan out with one-line briefs; details live in files, not prompts.
- T47: cap parallel agents; each carries its own full context copy.
- T48: read-only scopes for children so shared state never dirties.
- T49: pipelines with handoffs, not round-tables; merge results once.

## G. Output (T50)

- T50: answer in final form first pass; rewrites double output burn.
## H. Retrieval and hearts, continued (T51-T58)

- T51: lean slices everywhere; fragments stay zipped.
- T52: cap bible chapters per slice at 6, ranked by overlap plus usage.
- T53: retire zero-hit shards monthly.
- T54: narrow-to-wide retrieval; wide context only on miss.
- T55: deduplicate shards; matching beat baselines by 24x measured.
- T56: fold session residue into the heart at session end.
- T57: cache the observatory tail instead of re-reading the whole log.
- T58: run the usage meter weekly; cache-share collapse is an incident.

## I. Agent behavior (T59-T64)

- T59: one-shot commands; combine probe chains so fixes land first try.
- T60: single blocking wait for builds and tests, never status loops.
- T61: delegate wide fan-out with narrow briefs, not giant contexts.
- T62: kill dead-end threads fast; timebox spikes.
- T63: short answers by default; expand only on ask.
- T64: route trivial tasks to the cheapest capable model.

## J. Model and format pipeline (T65-T70)

- T65: compress before generating: summarize-then-answer.
- T66: strip images, PDFs, HTML to text before context entry.
- T67: reuse plans and scaffolds across sessions, never re-derive.
- T68: draft with cheap, verify with strong; never strong for both.
- T69: frontier for judgment calls, cache-friendly models for repetition.
- T70: reasoning effort off on deterministic tasks.

## K. Session lifecycle (T71-T76)

- T71: end sessions instead of letting them idle-accumulate context.
- T72: delete scratch branches and temp files so listings stay short.
- T73: keep one session per repo; cross-repo context doubles everything.
- T74: descriptive filenames so future greps hit first try.
- T75: close finished todo lists instead of carrying them turn to turn.
- T76: never run a second session against a question the first settled.

## L. Questions and answers (T77-T79)

- T77: one question per turn, not five.
- T78: single-word answers to clarifying questions where possible.
- T79: pre-answer the obvious follow-up in the same message.

## M. Dependencies and models, advanced (T80-T84)

- T80: quiet flags everywhere; already covered in T23, enforced twice.
- T81: reuse existing helpers instead of importing new dependencies to learn.
- T82: commit messages short; changelogs generated, not hand-written in chat.
- T83: batch classifications into one call, not one call each.
- T84: pre-filter candidates with rules before spending model calls.

## N. Memory, advanced (T85-T88)

- T85: index memory by filename convention; lookups are single reads.
- T86: fold tool outputs into notes immediately instead of re-running tools.
- T87: share one heart across seats instead of one each.
- T88: version memory; diff it instead of re-reading it whole.

## O. Multi-agent, advanced (T89-T92)

- T89: merge child results once; never re-ask a finished child.
- T90: one strong agent over three weak ones re-doing each other.
- T91: kill duplicate spawns the moment overlap is spotted.
- T92: synthesize from result refs, never by re-running child work.

## P. Similarity routing (T93-T94)

- T93: embeddings for similarity, generation only for decisions.
- T94: retire prompts that need two tries; fix the prompt instead.

## Q. Reporting and repo (T95-T98)

- T95: tables over prose is T31; this law covers figures: compress charts to deltas.
- T96: move long outputs to files; chat carries the verdict only.
- T97: generated artifacts stay out of git so diffs stay small forever.
- T98: ignore build outputs in every listing and search by default.

## R. Meta (T99-T100)

- T99: review this registry quarterly; every technique decays as tools change.
- T100: the registry itself stays lean; a law needing paragraphs is two laws.
