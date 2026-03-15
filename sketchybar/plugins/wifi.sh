#!/usr/bin/env bash

source "$HOME/.config/color/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

SPEEDTEST_BIN="${SPEEDTEST_BIN:-$(command -v speedtest-cli || echo /opt/homebrew/bin/speedtest-cli)}"
JQ_BIN="${JQ_BIN:-$(command -v jq || echo /opt/homebrew/bin/jq)}"
CACHE_DIR="${TMPDIR:-/tmp}"
CACHE_DIR="${CACHE_DIR%/}/sketchybar_wifi"
CACHE_FILE="$CACHE_DIR/speedtest.json"
STAMP_FILE="$CACHE_DIR/last_attempt"
PID_FILE="$CACHE_DIR/speedtest.pid"
TEST_INTERVAL="${WIFI_SPEEDTEST_INTERVAL:-600}"

ensure_cache_dir() {
    mkdir -p "$CACHE_DIR"
}

file_mtime() {
    local path="$1"

    if [ -f "$path" ]; then
        stat -f "%m" "$path"
    else
        echo 0
    fi
}

speedtest_running() {
    [ -f "$PID_FILE" ] || return 1

    local pid
    pid="$(cat "$PID_FILE" 2>/dev/null)"

    [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null
}

should_refresh_speedtest() {
    local now last_attempt

    now="$(date +%s)"
    last_attempt="$(file_mtime "$STAMP_FILE")"

    [ $((now - last_attempt)) -ge "$TEST_INTERVAL" ]
}

start_speedtest() {
    ensure_cache_dir

    [ -x "$SPEEDTEST_BIN" ] || return 1
    speedtest_running && return 0
    should_refresh_speedtest || return 0

    touch "$STAMP_FILE"
    (
        output=""
        output="$("$SPEEDTEST_BIN" --json --secure --timeout 20 2>/dev/null)" || {
            rm -f "$PID_FILE"
            exit 1
        }

        printf '%s\n' "$output" > "$CACHE_FILE.tmp" &&
            mv "$CACHE_FILE.tmp" "$CACHE_FILE"

        rm -f "$PID_FILE"
    ) >/dev/null 2>&1 &

    printf '%s\n' "$!" > "$PID_FILE"
}

format_mbps() {
    awk -v bits="$1" 'BEGIN { printf "%.1f", bits / 1000000 }'
}

load_speedtest() {
    DOWNLOAD_MBPS=""
    UPLOAD_MBPS=""
    PING_MS=""
    ISP=""

    [ -f "$CACHE_FILE" ] || return 1
    [ -x "$JQ_BIN" ] || return 1

    DOWNLOAD_MBPS="$(format_mbps "$("$JQ_BIN" -r '.download // 0' "$CACHE_FILE")")"
    UPLOAD_MBPS="$(format_mbps "$("$JQ_BIN" -r '.upload // 0' "$CACHE_FILE")")"
    PING_MS="$(awk -v ping="$("$JQ_BIN" -r '.ping // 0' "$CACHE_FILE")" 'BEGIN { printf "%.1f", ping }')"
    ISP="$("$JQ_BIN" -r '.client.isp // empty' "$CACHE_FILE")"
}

render_bar_item() {
    args+=(--set "$NAME" label="" \
        label.drawing=off)
}

render_popup() {
    if [ -n "$DOWNLOAD_MBPS" ]; then
        args+=(
            --set wifi.down drawing=on label="Down ${DOWNLOAD_MBPS} Mbps"
            --set wifi.up drawing=on label="Up ${UPLOAD_MBPS} Mbps"
            --set wifi.ping drawing=on label="Ping ${PING_MS} ms"
        )

        if [ -n "$ISP" ]; then
            args+=(--set wifi.isp drawing=on label="$ISP")
        else
            args+=(--set wifi.isp drawing=off label="")
        fi
    elif speedtest_running; then
        args+=(
            --set wifi.down drawing=on label="Running speed test..."
            --set wifi.up drawing=off label=""
            --set wifi.ping drawing=off label=""
            --set wifi.isp drawing=off label=""
        )
    else
        args+=(
            --set wifi.down drawing=on label="No speed test result yet"
            --set wifi.up drawing=off label=""
            --set wifi.ping drawing=off label=""
            --set wifi.isp drawing=off label=""
        )
    fi

    sketchybar -m "${args[@]}" > /dev/null
}

update() {
    args=()

    start_speedtest
    load_speedtest

    render_bar_item
    render_popup

    if [ "$SENDER" = "forced" ]; then
        sketchybar --animate tanh 15 --set "$NAME" label.y_offset=5 label.y_offset=0
    fi
}

popup() {
    sketchybar --set $NAME popup.drawing="$1"
}

case "$SENDER" in
    "routine"|"forced") update
        ;;
    "mouse.entered") update
        popup on
        ;;
    "mouse.exited"|"mouse.exited.global") popup off
        ;;
    "mouse.clicked") popup toggle
        ;;
esac
