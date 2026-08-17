#!/bin/bash
# AirSnap — build + GitHub Release
# Usage: ./release.sh "1.0.1" "Fix pairing screen crash"

set -e

VERSION="${1:?Usage: ./release.sh <version> <notes>}"
NOTES="${2:-Bug fixes}"
TAG="v$VERSION"

cd "$(dirname "$0")"

# Bump version in pubspec.yaml
sed -i '' "s/^version: .*/version: $VERSION+$(date +%s)/" pubspec.yaml

echo "▶ Building APK $TAG..."
flutter build apk --release --android-skip-build-dependency-validation

APK="build/app/outputs/flutter-apk/app-release.apk"
cp "$APK" ~/Desktop/AirSnap.apk

echo "▶ Committing version bump..."
git add pubspec.yaml
git commit -m "chore: bump version to $VERSION"
git push

echo "▶ Creating GitHub release $TAG..."
gh release create "$TAG" "$APK" \
  --title "AirSnap $TAG" \
  --notes "$NOTES" \
  --repo Carchofo/AirSnap

echo "✓ Release $TAG live. App will prompt update on next launch."
