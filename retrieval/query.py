#!/usr/bin/env python3
"""query.py: prompt keywords kick matching corpus records to the top.

The outside-lab mirror of the Slidphiclepedia ranker. Works over any
corpus root laid out as:

  <root>/pulls.jsonl             (optional; {"q","title","snippet","note"} per line)
  <root>/*.md                    (optional notes/cheatsheets, ranked full-text)
  <root>/corpora/manifest.jsonl  ({"bytes","path","role","sha256"} per line;
                                  paths resolve against <root>’s parent...
                                  see index.py, which builds it for you)

Usage: query.py [corpus-root] "your prompt text..."
Defaults to ./corpus. Stdlib only.

Scoring: stop-words removed; each distinct query token pays +2 exact /
+1 substring once (long files cannot spam); each exact query bigram +3.
Prints best-first: score, source, text.
"""
import json
import os
import re
import sys

STOP = set("a an the to of in on for with and or is are was were be by at as it its this that these those how what when which who will would can could should have has had do does did not no yes if then than so such via per my our your".split())
TEXT_EXT = (".md", ".txt", ".json", ".jsonl", ".mjs", ".js",
            ".py", ".html", ".yaml", ".yml", ".toml", ".cfg")


def toks(s):
    return [w for w in re.findall(r"[a-z0-9]+", s.lower()) if w not in STOP]


def bigrams(q):
    return [" ".join(q[i:i + 2]) for i in range(len(q) - 1)]


def score_doc(q, bigr, text):
    words = toks(text)
    wset = set(words)
    blob = " ".join(words)
    s = 0
    for w in set(q):
        if w in wset:
            s += 2
        elif any(w != v and (w in v or v in w) for v in wset):
            s += 1
    s += sum(3 for b in set(bigr) if b in blob)
    return s


def main(root, query):
    q = toks(query)
    bigr = bigrams(q)
    rows = []

    def add(score, tag, text):
        if score > 0:
            rows.append((score, tag, text[:220]))

    pulls = os.path.join(root, "pulls.jsonl")
    if os.path.exists(pulls):
        for line in open(pulls, encoding="utf-8", errors="replace"):
            line = line.strip()
            if not line.startswith("{"):
                continue
            try:
                r = json.loads(line)
            except ValueError:
                continue
            text = " ".join(str(r.get(k, "")) for k in ("q", "title", "snippet", "note"))
            add(score_doc(q, bigr, text), "pull",
                "%s | %s" % (r.get("title", "?"), r.get("note", "")))

    for fn in sorted(os.listdir(root)):
        fp = os.path.join(root, fn)
        if not (os.path.isfile(fp) and fn.endswith(".md")):
            continue
        try:
            body = open(fp, encoding="utf-8", errors="replace").read()
        except OSError:
            continue
        first = body.strip().split("\n")[0] if body.strip() else fn
        add(score_doc(q, bigr, fn + " " + body), "note", "%s: %s" % (fn, first))

    base = os.path.abspath(os.path.join(root, ".."))
    man = os.path.join(root, "corpora", "manifest.jsonl")
    if os.path.exists(man):
        for line in open(man, encoding="utf-8", errors="replace"):
            line = line.strip()
            if not line.startswith("{"):
                continue
            try:
                r = json.loads(line)
            except ValueError:
                continue
            rel = str(r.get("path", ""))
            text = "%s %s" % (r.get("role", ""), rel)
            fp = os.path.join(base, *rel.split("/"))
            try:
                if (os.path.isfile(fp) and fp.lower().endswith(TEXT_EXT)
                        and os.path.getsize(fp) < 200000):
                    with open(fp, encoding="utf-8", errors="replace") as fh:
                        text += " " + fh.read()
            except OSError:
                pass
            add(score_doc(q, bigr, text), "corpus:" + str(r.get("role", "?")), rel)

    rows.sort(key=lambda x: -x[0])
    if not rows:
        print("no keyword hits for: %s" % query)
        return
    for score, tag, text in rows[:8]:
        print("%d [%s] %s" % (score, tag, text))


args = sys.argv[1:]
root = "corpus"
if args and os.path.isdir(args[0]):
    root = args.pop(0)
main(root, " ".join(args) or input("prompt: "))
