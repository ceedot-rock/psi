#!/usr/bin/env python3
"""usage-line.py: standing token meter over the local Muse session store.

Reads every session.jsonl (main logs only) and prints one line per
session with provider-reported tokens: input, output, cached, model
steps, plus an error-batch share as a waste proxy.

Error heuristic (documented, trend-grade not audit-grade): a tool
result batch counts as errored when its JSON carries an explicit error
marker (isError, status error, traceback, cmdlet failure). Benign
mentions of the word "error" in prose do not match.

Usage:
  python usage-line.py [--log]
--log appends one meter entry per session to ~/psi/observatory.jsonl
in {"d","c","o"} shape. Run it at session end; the current session's
line is partial by construction.
"""
import glob
import json
import os
import sys
from datetime import date

STORE = os.path.join(os.path.expanduser("~"), ".local", "share",
                     "muse", "sessions")
OBS = os.path.join(os.path.expanduser("~"), "psi", "observatory.jsonl")

MARKERS = ('"isError": true', '"isError":true', '"status":"error"',
           '"status": "error"', 'Traceback (most recent call last)',
           'CommandNotFoundException', 'NativeCommandError',
           'FullyQualifiedErrorId')


def scan(fp):
    tin = tout = tcached = 0
    steps = 0
    batches = errs = 0
    with open(fp, encoding="utf-8", errors="replace") as fh:
        for line in fh:
            if "goal_usage_attribution" in line:
                try:
                    rec = json.loads(line)
                    q = rec["payload"]["event"]["record"]["quantity"]
                    tin += q.get("input_tokens", 0)
                    tout += q.get("output_tokens", 0)
                    tcached += q.get("cached_tokens", 0)
                    steps += 1
                except Exception:
                    pass
            elif "tool_result_batch_committed" in line:
                batches += 1
                if any(m in line for m in MARKERS):
                    errs += 1
    return tin, tout, tcached, steps, errs, batches


def main():
    rows = []
    for fp in sorted(glob.glob(os.path.join(STORE, "*", "*", "*", "*",
                                            "session.jsonl"))):
        sid = fp.split(os.sep)[-2]
        tin, tout, tcached, steps, errs, batches = scan(fp)
        if not steps:
            continue
        rows.append((sid, tin, tout, tcached, steps, errs, batches))
        share = (errs / batches) if batches else 0.0
        print("%s in=%d out=%d cached=%d steps=%d err=%d/%d (%.2f)" %
              (sid[:8], tin, tout, tcached, steps, errs, batches, share))
    tin = sum(r[1] for r in rows)
    tout = sum(r[2] for r in rows)
    print("TOTAL sessions=%d in=%d out=%d" % (len(rows), tin, tout))
    if "--log" in sys.argv[1:]:
        with open(OBS, "a", encoding="utf-8") as fh:
            for sid, i, o, c, s, e, b in rows:
                fh.write(json.dumps({
                    "d": str(date.today()),
                    "c": "meter",
                    "o": ("tokens session %s in=%d out=%d cached=%d "
                          "steps=%d err=%d/%d" % (sid[:8], i, o, c, s,
                                                 e, b)),
                }) + "\n")
        print("logged %d meter entries to %s" % (len(rows), OBS))


if __name__ == "__main__":
    main()
