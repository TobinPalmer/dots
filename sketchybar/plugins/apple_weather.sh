#!/usr/bin/env bash

set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$PLUGIN_DIR/apple_weather.swift"
CACHE_DIR="$HOME/Library/Caches/sketchybar"
BINARY="$CACHE_DIR/apple_weather.bin"

mkdir -p "$CACHE_DIR"

build_binary() {
    SDKROOT=$(xcrun --show-sdk-path --sdk macosx)

    env -u CPATH -u C_INCLUDE_PATH -u CPLUS_INCLUDE_PATH \
        xcrun swiftc -sdk "$SDKROOT" "$SOURCE" -o "$BINARY"
}

if [[ ! -x "$BINARY" || "$SOURCE" -nt "$BINARY" ]]; then
    build_binary
fi

if output=$("$BINARY" "$@" 2>/dev/null); then
    printf '%s\n' "$output"
    exit 0
fi

build_binary
exec "$BINARY" "$@"
