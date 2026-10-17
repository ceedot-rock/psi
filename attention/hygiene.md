# Context hygiene (tweak 64) — prune dead context mid-task.
Dropped context is logged: what was dropped, why it was dead, where the full
text lives. Pruning is a recorded act with a reason, never quiet forgetting.
If the dropped context is needed later, the log says where to refetch it.
