#!/bin/sh
# Self-check for verify's stack detection. Run: sh harness/test.sh
set -eu
V="$(cd "$(dirname "$0")" && pwd)/verify"
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT

check() { got=$(sh "$V" --detect-only "$T/$1"); [ "$got" = "$2" ] || { echo "FAIL $1: got $got, want $2"; exit 1; }; }

mkdir -p "$T/flutter/ios" "$T/rn/android" "$T/ios/App.xcodeproj" "$T/spm" "$T/android" "$T/none"
touch "$T/flutter/pubspec.yaml" "$T/spm/Package.swift" "$T/android/gradlew"
echo '{"dependencies":{"react-native":"0.80.0"}}' > "$T/rn/package.json"

check flutter flutter
check rn react-native
check ios ios
check spm ios
check android android
check none unknown
echo "ok"
