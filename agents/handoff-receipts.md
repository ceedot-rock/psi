# Handoff receipts (tweak 44) — transfers need acknowledgment payloads.
A send without a confirmed receipt is unconfirmed: say so, keep owning it, and
never build on assumed delivery. Receipts wanted: transport handoff, durable
custody, read. Missing all three after one window = treat as unsent.
