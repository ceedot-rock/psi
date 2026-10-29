#!/usr/bin/env python3
"""index.py: build corpora/manifest.jsonl for query.py.

Usage: index.py <docs-dir> <corpus-root> [role]
Walks <docs-dir> for text files, writes one {"bytes","path","role",
"sha256"} line per file to <corpus-root>/corpora/manifest.jsonl.
Paths are stored relative to the PARENT of <corpus-root>, so keep
both trees side by side:

  mysite/            <- parent (paths are relative to here)
    docs/            <- <docs-dir>
    corpus/          <- <corpus-root> (query.py reads it)
      corpora/manifest.jsonl

Role defaults to the docs-dir name. Re-run to refresh; it rewrites
the manifest from scratch (the manifest is derived, not precious).
Stdlib only.
"""
import hashlib
import json
import os
import sys

TEXT_EXT = (".md", ".txt", ".json", ".jsonl", ".mjs", ".js",
            ".py", ".html", ".yaml", ".yml", ".toml", ".cfg")


def main(docs, root, role):
    docs = os.path.abspath(docs)
    root = os.path.abspath(root)
    base = os.path.abspath(os.path.join(root, ".."))
    outdir = os.path.join(root, "corpora")
    os.makedirs(outdir, exist_ok=True)
    n = 0
    with open(os.path.join(outdir, "manifest.jsonl"), "w", encoding="utf-8") as fh:
        for dirpath, _, files in os.walk(docs):
            for fn in sorted(files):
                if not fn.lower().endswith(TEXT_EXT):
                    continue
                fp = os.path.join(dirpath, fn)
                try:
                    if os.path.getsize(fp) >= 200000:
                        continue
                    with open(fp, "rb") as f:
                        b = f.read()
                except OSError:
                    continue
                rel = os.path.relpath(fp, base).replace(os.sep, "/")
                fh.write(json.dumps({
                    "bytes": len(b),
                    "path": rel,
                    "role": role,
                    "sha256": hashlib.sha256(b).hexdigest(),
                }) + "\n")
                n += 1
    print("indexed %d files -> %s" % (n, os.path.join(outdir, "manifest.jsonl")))


docs = sys.argv[1] if len(sys.argv) > 1 else None
root = sys.argv[2] if len(sys.argv) > 2 else None
if not docs or not root:
    sys.exit("usage: index.py <docs-dir> <corpus-root> [role]")
main(docs, root, sys.argv[3] if len(sys.argv) > 3 else os.path.basename(os.path.abspath(docs)))
