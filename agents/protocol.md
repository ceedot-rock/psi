# Agent protocol (tweaks 23-24) — messaging with receipts.
- Outgoing: one short plaintext message, solicitation or notification; keep the
  message id; delivery unconfirmed means unconfirmed — say so, do not assume.
- Incoming: replies arrive as runtime context; relay promptly, verbatim first.
- Shared state goes in depots (tweak 24), never in message bodies alone.
- Checklists live numbered in chat (1. 2. 3.); no todo tool exists, so the chat list is the tracker.
- Small turns stay small: a read-only answer, a single question, or a one-line fix skips obs logging and peer listing; receipts batch at task close instead.
