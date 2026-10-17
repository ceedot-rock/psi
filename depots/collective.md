# Collective depots (tweak 24) — shared persistent memory across agents.
- GitDepot Hub depots hold announcements + provenance (awlpay, l33tverse live).
- Drive blobs hold the artifacts (tarballs, byte-verified on write).
- Convention: every cross-agent handoff lands in a depot with sha + size, so any
  agent can rebuild without asking the author.
