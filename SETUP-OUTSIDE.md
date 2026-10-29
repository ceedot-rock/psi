# SETUP-OUTSIDE — run psi outside the lab, mirror the full process

You hold a psi commercial seat. This file takes you from zero to the
same loop the lab runs: boot, log, index your docs, query by prompt.
No lab infrastructure needed — only Python 3 and git
(Windows: Git Bash).

## 1. Get access

Buying a seat grants private-repo access (invite follows payment).
Then:

```sh
git clone <your-psi-repo-url> psi && cd psi
```

## 2. Boot every session (read-only, in order)

1. `identity.md` — who the agent is that day.
2. `observatory.jsonl` — newest 20 lines (append-only experience log).
3. `goals.md` — standing direction.
4. `env-model.json` — copy the shape, rewrite it for YOUR machine
   (shell, toolchains, limits). The shipped one describes ours.

## 3. Log as you work

One line per lesson, JSON, appended to `observatory.jsonl`:

```json
{"d": "2026-10-28", "c": "avoid", "o": "[runaway-kill] killed the duplicate sweep early; ~500k tokens"}
```

Categories are free text (`ship`, `fix`, `avoid`, `meter`, `tooling` …).
Price `avoid` lines inline (`~N tokens`) — `scripts/savings.py`
reads them for the savings meter. Never edit old lines; supersede
with new ones.

## 4. Mirror the research loop (prompts kick keywords up)

Lay out a corpus next to your docs and index it:

```sh
mysite/
  docs/     # your notes, specs, manuals (any text files)
  corpus/   # the queryable mirror (generated files live here)

python psi/retrieval/index.py mysite/docs mysite/corpus mydocs
python psi/retrieval/query.py mysite/corpus "your prompt text here"
```

`query.py` scores every record against your prompt's keywords
(stop-words out, exact beats substring, multi-word phrases float
highest) and prints best-first. Re-run `index.py` when docs change.
Drop web-research notes in as `corpus/*.md` — short excerpts in your
own words, never full article text.

## 5. Daily rites (5 minutes)

- Open: state one goal and one stop condition before any tool call.
- Close: promote repeated context to memory, snapshot decisions,
  demote stale notes, clean scratch.
- The full checklists live in `thrift/RITES.md`; the reasons in
  `thrift/PRINCIPLES.md`.

## 6. Prove it stayed green

```sh
bash scripts/psi-doctor.sh   # PSI-GREEN or the first gap, loudly
python scripts/savings.py    # plan-22 ratio + cost-basis savings
```

Terms: commercial seat, per LICENSE. One product, one term.
Support scope is fixed in your invoice before work starts.
Enterprise (10+ seats, private deploy, SLA): corey@slidphilabs.com.
