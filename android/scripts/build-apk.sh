#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# AGP 8.5/Kotlin tooling in this repo works reliably with JDK 17.
JAVA17="/root/.local/share/mise/installs/java/17.0.2"
if [[ -d "$JAVA17" ]]; then
  export JAVA_HOME="$JAVA17"
  export PATH="$JAVA_HOME/bin:$PATH"
fi

cd "$ROOT_DIR"
./gradlew :app:assembleDebug

echo
find "$ROOT_DIR/app/build/outputs/apk" -type f -name "*.apk" -print
