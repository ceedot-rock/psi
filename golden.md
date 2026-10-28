# Golden files — proven numbers and where they were proven.
# Challenge a number: cite its path or re-run its proof. Never memory.

- CESD Silesia 0.6491 (211938580 -> 137563131): ces.exe selftest, CES_CORPUS
- CESD enwik8 0.6350 (100M -> 63503074): ces.exe selftest, CES_ENWIK8
- CESD agent-corpus 0.6861 (57546 -> 39481): ces.exe selftest, CES_AGENT
- LZ matcher 12/12 match=1, 25-111 MB/s parse: t_lz.exe sweep Silesia
- LZ sao byte-identical to matcher.py (10223114): fc.exe vs sao.pylzt
- matcher.py window fix 2026-10-28 (dist>=window): sao byte-identical pre/post fix; xml 359196 toks roundtrip True in pure Python; crashes over
- Hub endpoints: health/members/401/400s/blob-exact: gdtest sandbox runs
- Hub fixes live: traversal 400, neg-length 400 not hang, 64MB cap
- intune regression: test_entity.py fails 0 (with matcher.py dispatcher edit)
- TNSSRC board 0.2063 / local 0.2290 / box 0.2454 / ledger 0.2136 (reconciled)
- Pulsar Silesia subset 0.2722 (211938580 -> 55745438, H100 box ledger)
- RunPod: 6 pods all EXITED $0/hr (v2 API list, 2026-10-28)
- M10 terminated 2026-10-28 after 6-doc export (depot: m10-lab_memory-export)
- Hub live: t4g.micro us-east-2 (Elastic IP in DEPLOY.md), 15+ depots post-audit
