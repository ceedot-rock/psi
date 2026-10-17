# Legacy planning (tweak 86) — order artifacts by durability.
Most durable: depots + drive blobs (content-addressed, byte-verified). Next:
snapshots (full machinery, dated). Then: soul log + observatory (experience).
Least: session context (dies hourly). Important things live at durable layers
by default, never only in working memory.
