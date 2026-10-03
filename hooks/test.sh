#!/bin/sh
# Self-check for session-start.sh stack detection. Run: sh hooks/test.sh
set -eu
H="$(cd "$(dirname "$0")" && pwd)/session-start.sh"
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT

check() {
  got=$(CLAUDE_PROJECT_DIR="$T/$1" sh "$H" | head -1 | sed -n 's/^Mobile project detected (\(.*\))\..*/\1/p')
  [ "$got" = "$2" ] || { echo "FAIL $1: got '$got', want '$2'"; exit 1; }
}

mkdir -p "$T/flutter/ios" "$T/rn/android" "$T/ios/App.xcodeproj" "$T/spm" "$T/android" "$T/none"
touch "$T/flutter/pubspec.yaml" "$T/spm/Package.swift" "$T/android/gradlew"
echo '{"dependencies":{"react-native":"0.80.0"}}' > "$T/rn/package.json"

check flutter flutter
check rn react-native
check ios ios
check spm ios
check android android
check none ""
echo "ok"
