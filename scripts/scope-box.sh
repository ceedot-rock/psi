#!/usr/bin/env bash
# scope-box.sh — one-command sparse worktree box + scope card.
# Usage: scope-box.sh <branch> <dir> <paths...>
# Run from inside the main checkout; the box narrows what is on disk
# (clean diffs, no collateral edits), not what tools can reach.
set -uo pipefail

[[ "${1:-}" == "-h" || "${1:-}" == "--help" ]] && {
  echo "usage: scope-box.sh <branch> <dir> <paths...>"
  echo "example: scope-box.sh ship/npm-bump /tmp/scope/npm-bump package.json packages/phi-rest"
  exit 0
}
[[ $# -ge 3 ]] || { echo "usage: scope-box.sh <branch> <dir> <paths...>" >&2; exit 2; }
branch="$1"; dir="$2"; shift 2
main="$(git rev-parse --show-toplevel)"
name="$(basename -- "$dir")"

if git rev-parse --verify --quiet "$branch" >/dev/null; then
  git worktree add "$dir" "$branch"
else
  git worktree add -b "$branch" "$dir"
fi
git -C "$dir" sparse-checkout init --no-cone 2>/dev/null || true
git -C "$dir" sparse-checkout set "$@"

mkdir -p /tmp/scope
card="/tmp/scope/SCOPE.$name.md"
{
  echo "# Scope box: $name"
  echo ""
  echo "Box: $dir (branch $branch, sparse checkout)"
  echo "Main checkout: $main (untouched, keeps its own uncommitted files)"
  echo "Task: $name"
  echo ""
  echo "Window (all work happens inside the box, only these paths exist there):"
  for p in "$@"; do echo "- $p"; done
  echo ""
  echo "Rules:"
  echo "- Edit only inside the box. Read outside only to confirm a cross-reference, never to edit."
  echo "- Commit on $branch from inside the box; merge/push/tag from the main checkout after review."
  echo "- New task = new box (scope-box.sh ship/<name> /tmp/scope/<name> <paths...>), new card."
  echo "- If /tmp is ever wiped: git worktree prune in the main checkout; the branch survives."
  echo ""
  echo "Limit (honest): the box narrows what is on disk, not what tools can reach."
  echo "It guarantees clean diffs and no collateral edits, not confinement."
  echo "Hard isolation exists only for subagents (worktree_isolation)."
} > "$card"
echo "ok: box $dir (branch $branch)"
echo "ok: card $card"
