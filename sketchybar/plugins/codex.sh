#!/bin/bash

STATE_FILE="/tmp/sketchybar_codex_state.env"

load_state() {
  if [[ -f "$STATE_FILE" ]]; then
    # shellcheck disable=SC1090
    source "$STATE_FILE"
  fi
}

save_state() {
  cat > "$STATE_FILE" <<EOF
FAIL_COUNT=${FAIL_COUNT:-0}
NEXT_ATTEMPT=${NEXT_ATTEMPT:-0}
LAST_LABEL="${LAST_LABEL:-}"
LAST_STATUS="${LAST_STATUS:-ok}"
EOF
}

next_delay() {
  local failures="$1"
  if (( failures <= 4 )); then
    echo 30
  elif (( failures <= 8 )); then
    echo 60
  elif (( failures <= 12 )); then
    echo 120
  elif (( failures <= 16 )); then
    echo 300
  elif (( failures <= 20 )); then
    echo 900
  else
    echo 3600
  fi
}

find_codex_bin() {
  local bin=""
  bin="$(command -v codex 2>/dev/null || true)"
  if [[ -n "$bin" && -x "$bin" ]]; then
    echo "$bin"
    return
  fi

  for candidate in /opt/homebrew/bin/codex /usr/local/bin/codex /usr/bin/codex; do
    if [[ -x "$candidate" ]]; then
      echo "$candidate"
      return
    fi
  done
}

fetch_weekly_percent() {
  local codex_bin="$1"
  local output line

  output="$({
    printf '%s\n' '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"clientInfo":{"name":"SketchyBar","version":"1.0"}}}'
    sleep 0.25
    printf '%s\n' '{"jsonrpc":"2.0","id":2,"method":"account/rateLimits/read","params":null}'
    sleep 1
  } | "$codex_bin" app-server --listen stdio:// 2>/dev/null | head -n 16)"

  line="$(printf '%s\n' "$output" | grep '"id":2' | tail -n1)"
  [[ -z "$line" ]] && return 1

  printf '%s' "$line" | jq -e '.error == null' >/dev/null 2>&1 || return 1

  printf '%s' "$line" | jq -r '
    def all_windows:
      [ .result.rateLimits.primary?, .result.rateLimits.secondary? ] +
      ((.result.rateLimitsByLimitId // {}) | to_entries | map(.value.primary?, .value.secondary?));
    [ all_windows[] | select(. != null) | {mins:(.windowDurationMins // 0), used:(.usedPercent // 0)} ]
    | if length == 0 then empty else (max_by(.mins).used | tostring) end
  '
}

update_item() {
  local label="$1"
  local status="$2"
  local label_color percent_value

  if [[ "$status" == "error" ]]; then
    sketchybar --set "$NAME" label="$label" label.color=0xffff6b6b
  else
    percent_value="${label%\%}"
    if [[ "$percent_value" =~ ^[0-9]+$ ]]; then
      if (( percent_value < 50 )); then
        label_color=0xffa6da95
      elif (( percent_value < 75 )); then
        label_color=0xffeed49f
      elif (( percent_value < 90 )); then
        label_color=0xfff5a97f
      else
        label_color=0xffed8796
      fi
    else
      label_color=0xffcad3f5
    fi
    sketchybar --set "$NAME" label="$label" label.color="$label_color"
  fi
}

main() {
  load_state

  local now codex_bin percent delay
  now="$(date +%s)"
  FAIL_COUNT="${FAIL_COUNT:-0}"
  NEXT_ATTEMPT="${NEXT_ATTEMPT:-0}"
  LAST_LABEL="${LAST_LABEL:---%}"
  LAST_STATUS="${LAST_STATUS:-ok}"

  if [[ "$SENDER" != "forced" && "$SENDER" != "routine" ]]; then
    update_item "$LAST_LABEL" "$LAST_STATUS"
    exit 0
  fi

  if (( now < NEXT_ATTEMPT )); then
    update_item "$LAST_LABEL" "$LAST_STATUS"
    exit 0
  fi

  codex_bin="$(find_codex_bin)"
  if [[ -z "$codex_bin" ]]; then
    FAIL_COUNT=$((FAIL_COUNT + 1))
    delay="$(next_delay "$FAIL_COUNT")"
    NEXT_ATTEMPT=$((now + delay))
    LAST_LABEL="ERR"
    LAST_STATUS="error"
    save_state
    update_item "$LAST_LABEL" "$LAST_STATUS"
    exit 0
  fi

  percent="$(fetch_weekly_percent "$codex_bin")"
  if [[ -n "$percent" ]]; then
    FAIL_COUNT=0
    NEXT_ATTEMPT=$((now + 120))
    LAST_LABEL="${percent}%"
    LAST_STATUS="ok"
  else
    FAIL_COUNT=$((FAIL_COUNT + 1))
    delay="$(next_delay "$FAIL_COUNT")"
    NEXT_ATTEMPT=$((now + delay))
    LAST_LABEL="ERR"
    LAST_STATUS="error"
  fi

  save_state
  update_item "$LAST_LABEL" "$LAST_STATUS"
}

main
