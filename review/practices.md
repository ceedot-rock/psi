# Field practices — loop-proofing, box hygiene, paths, triage, decisions.

- (159) Prove loops with throwaway peers before touching real seats.
  Tonight: MuseTestPeer verified the handshake loop end-to-end, so no
  real seat was spammed while the protocol was still unproven.
- (161) Boxes must be entered or deleted; an unused box rots.
  Tonight: an un-entered bump box sat with a branch attached, blocking
  the real handoff until it was entered and cleared.
- (162) Selftest paths resolve from the test's own directory, asserted once.
  Tonight: resolving from its own directory kept the selftest green no
  matter which working directory invoked it.
- (163) Failure triage order: mine-first (8-char floor), then theirs, then environment.
  Tonight: own diffs were checked against the 8-char floor first, then stale
  engine paths on their side, then environment — in that order.
- (164) Flip decision entries when verification lands (hit:false to hit:true).
  Tonight: the entry flipped to hit:true only after the run confirmed it,
  keeping the decision log honest about what was proven.
