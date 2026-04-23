#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SRC="$ROOT_DIR/releases/mhrv-rs-android-universal-v1.1.0.apk"
OUT_DIR="$ROOT_DIR/android/app/build/outputs/apk/bundled"
OUT="$OUT_DIR/mhrv-rs-android-universal-v1.1.0.apk"

mkdir -p "$OUT_DIR"
cp -f "$SRC" "$OUT"

sha256sum "$OUT"
echo "$OUT"
