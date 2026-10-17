# Dependency watch (tweak 73) — external facts re-verified on TTL expiry.
Tool versions, registry reachability, binary paths (/tmp/cuni-target), peer
liveness: each carries its TTL (tweak 30). On expiry, one live probe with a
receipt refreshes the date or demotes the entry to a surprise.
