#!/usr/bin/env python3
"""savings.py: overall savings meter for psi (token-economy plan 22).

Reads metered actuals via usage-line.py's scanner and priced avoid
entries from the observatory, then prints two readings:

  plan22  savings% = avoided / (actual + avoided)   (input tokens)
  cost    savings% = 1 - cost_with / cost_without   (stated assumptions)

Avoid entries price themselves inline: "~N tokens" / "~Nk" / "~NM".
Entries without a number are listed as UNPRICED and never summed.

Usage: python savings.py
"""
import glob
import importlib.util
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location(
    "usage_line", os.path.join(HERE, "usage-line.py"))
usage_line = importlib.util.module_from_spec(spec)
spec.loader.exec_module(usage_line)

OBS = os.path.join(os.path.expanduser("~"), "psi", "observatory.jsonl")
PRICE = re.compile(r"~(\d+(?:\.\d+)?)\s*([kKmM]?)\s*tokens?\b")
MULT = {"": 1, "k": 1e3, "m": 1e6}

# Stated cost assumptions (printed with every reading).
CACHED_X = 0.1   # cached input costs a tenth of fresh input
OUTPUT_X = 3.0   # output costs three times fresh input
AVOIDED_X = 1.0  # avoided work would have run uncached


def main():
    tin = tout = tcached = 0
    for fp in glob.glob(os.path.join(usage_line.STORE, "*", "*", "*",
                                     "*", "session.jsonl")):
        i, o, c, _, _, _ = usage_line.scan(fp)
        tin += i
        tout += o
        tcached += c

    avoided = 0.0
    unpriced = []
    if os.path.exists(OBS):
        with open(OBS, encoding="utf-8", errors="replace") as fh:
            for line in fh:
                line = line.strip()
                if not line:
                    continue
                try:
                    rec = json.loads(line)
                except Exception:
                    continue
                if rec.get("c") != "avoid":
                    continue
                m = PRICE.search(rec.get("o", ""))
                if m:
                    avoided += float(m.group(1)) * MULT[m.group(2).lower()]
                else:
                    unpriced.append(rec.get("o", "")[:100])

    plan22 = avoided / (tin + avoided) if (tin + avoided) else 0.0
    cost_without = tin * 1.0 + tout * OUTPUT_X
    cost_with = ((tin - tcached) * 1.0 + tcached * CACHED_X
                 + tout * OUTPUT_X - avoided * AVOIDED_X)
    cost = 1.0 - cost_with / cost_without if cost_without else 0.0

    print("actual  in=%d out=%d cached=%d" % (tin, tout, tcached))
    print("avoided tokens=%d across priced entries" % avoided)
    print("plan22  savings=%.2f%% (avoided/(actual+avoided))"
          % (100 * plan22))
    print("cost    savings=%.2f%% (assumptions: cached=%.2gx "
          "output=%.gx avoided=%.gx)" % (100 * cost, CACHED_X,
                                         OUTPUT_X, AVOIDED_X))
    for u in unpriced:
        print("UNPRICED avoid (not summed): %s" % u)
    for target in (0.51, 0.55):
        need = target / (1 - target) * tin - avoided
        print("to reach %d%% plan22: %s%d more avoided tokens"
              % (int(target * 100), "" if need > 0 else "already past by ",
                 abs(int(need))))


if __name__ == "__main__":
    sys.exit(main())
