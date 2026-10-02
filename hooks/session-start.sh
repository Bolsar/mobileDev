#!/bin/sh
# SessionStart hook: in a mobile project, put AGENTS.md into context so the
# agent is always on instead of waiting for Claude to pick the skill.
# ponytail: checks the project root only; monorepos with the app in a subfolder fall back to the mobile-dev skill.
root="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
stack=$(sh "$root/harness/verify" --detect-only "${CLAUDE_PROJECT_DIR:-.}")
[ "$stack" = unknown ] && exit 0
echo "Mobile project detected ($stack). Follow the Mobile Developer Agent below for all work in this session. Agent root: $root"
echo
cat "$root/AGENTS.md"
