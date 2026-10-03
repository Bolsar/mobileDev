#!/bin/sh
# SessionStart hook: in a mobile project, put AGENTS.md into context so the
# agent is always on instead of waiting for Claude to pick the skill.
# ponytail: checks the project root only; monorepos with the app in a subfolder fall back to the mobile-dev skill.
root="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0

# Order matters: Flutter and React Native projects also contain ios/ and android/.
if [ -f pubspec.yaml ]; then stack=flutter
elif [ -f package.json ] && grep -q '"react-native"' package.json; then stack=react-native
elif [ -f Package.swift ] || [ -n "$(find . -maxdepth 1 \( -name '*.xcodeproj' -o -name '*.xcworkspace' \))" ]; then stack=ios
elif [ -f gradlew ] || [ -f build.gradle ] || [ -f build.gradle.kts ]; then stack=android
else exit 0
fi

echo "Mobile project detected ($stack). Follow the Mobile Developer Agent below for all work in this session. Agent root: $root"
echo "Stack Pack: load the mobile-dev-$stack skill. If it isn't installed, tell the Requester once: claude plugin install mobile-dev-$stack@bolsar"
echo
cat "$root/AGENTS.md"
