#!/usr/bin/env python3
"""Relevance retrieval (tweak 3): rank observatory lines by fit to a task string.
Stdlib only. Usage: score.py observatory.jsonl "serve a dev server in sandbox"
Prints best-first: score, category, observation."""
import json
import re
import sys

STOP = set("a an the to of in on for with and or is are was were be by at as it its this that these those how what when which who will would can could should have has had do does did not no yes if then than so such via per".split())


def toks(s):
    return [w for w in re.findall(r"[a-z0-9]+", s.lower()) if w not in STOP]


def main(path, query):
    q = toks(query)
    rows = []
    for line in open(path):
        line = line.strip()
        if not line.startswith("{"):
            continue
        try:
            r = json.loads(line)
        except ValueError:
            continue
        if "o" not in r:
            continue
        words = toks(r.get("c", "") + " " + r["o"])
        score = sum(2 for w in q if w in words)
        score += sum(1 for w in q for v in words if w != v and (w in v or v in w))
        rows.append((score, r))
    rows.sort(key=lambda x: -x[0])
    for score, r in rows[:8]:
        print(f"{score} [{r.get('c')}] {r['o']}")


main(sys.argv[1], " ".join(sys.argv[2:]))
