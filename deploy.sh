#!/bin/bash
# AirSnap — build + upload to Firebase App Distribution
# Usage: ./deploy.sh "release notes"

set -e

NOTES="${1:-Bug fixes and improvements}"
APP_ID="${FIREBASE_APP_ID:-}"  # set in .env or export before running

if [ -z "$APP_ID" ]; then
  echo "ERROR: FIREBASE_APP_ID not set. Run: export FIREBASE_APP_ID=1:xxx:android:xxx"
  exit 1
fi

echo "▶ Building APK..."
cd "$(dirname "$0")"
flutter build apk --debug --android-skip-build-dependency-validation

APK="build/app/outputs/flutter-apk/app-debug.apk"

echo "▶ Uploading to Firebase App Distribution..."
firebase appdistribution:distribute "$APK" \
  --app "$APP_ID" \
  --release-notes "$NOTES" \
  --groups "testers"

echo "✓ Done. Testers will receive a notification."
cp "$APK" ~/Desktop/AirSnap.apk
echo "✓ APK also copied to Desktop."
