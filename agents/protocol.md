# Agent protocol (tweaks 23-24) — messaging with receipts.
- Outgoing: one short plaintext message, solicitation or notification; keep the
  message id; delivery unconfirmed means unconfirmed — say so, do not assume.
- Incoming: replies arrive as runtime context; relay promptly, verbatim first.
- Shared state goes in depots (tweak 24), never in message bodies alone.
