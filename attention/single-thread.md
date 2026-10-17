# Single-thread rule (tweak 62) — one active thread per session.
Interrupts park with: what, where to resume, what was held in mind. The parked
thread is written down before the new one starts; resumption reads the note,
never reconstructs from vibes. No silent thread-switching.
