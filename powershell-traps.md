# PowerShell 5.1 traps (this box, paid for in tokens)

- No `&&` — use `;` (each command its own check).
- `fc` is Format-Custom: binary compare needs `fc.exe /b`.
- `curl` is Invoke-WebRequest: pass `-UseBasicParsing` or expect IE-engine errors.
- `Get-ChildItem` has no `-MaxDepth`: use `muse.search` or recurse manually.
- `Select-Object -First N` closes the stream: writers die of SIGPIPE, exit code lies.
- Piped python output block-buffers: silence until exit is normal, not stuck.
- Quoting: single quotes inside `--parameters`/heredocs break AWS CLI parsing;
  ship scripts as base64 blobs (alphabet has no quotes).
- `Start-Sleep` + long job in one managed call can wedge: keep sleeps short.
- Orphaned children hold build outputs (t_lz.exe lock): kill by PID before rebuild.
- `int()` around argv: garbage crashes at boot are fine (fail fast), garbage in
  requests must 400, never hang (negative Content-Length reads to EOF).
- python block-buffers stdout under pipes: tool output can show stderr first; always run scripts with python -u.
