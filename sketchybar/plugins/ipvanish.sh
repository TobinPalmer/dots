#!/usr/bin/env bash

source "$HOME/.config/sketchybar/plugins/popup.sh"

PREFS_FILE="$HOME/Library/Preferences/com.ipvanish.IPVanish.plist"
BUNDLE_ID="com.ipvanish.IPVanish"
OPENVPN_PID_FILE="/tmp/ipvanish3-openvpn.pid"
IKEV2_PROVIDER="/System/Library/Frameworks/NetworkExtension.framework/PlugIns/NEIKEv2Provider.appex/Contents/MacOS/NEIKEv2Provider"
DEFAULT_UPDATE_FREQ=15
HOVER_UPDATE_FREQ=1

is_ipvanish_running() {
  launchctl print "gui/$(id -u)" 2>/dev/null | grep -q "application.${BUNDLE_ID}."
}

openvpn_pid() {
  local pid

  [[ -f "$OPENVPN_PID_FILE" ]] || return 1

  pid="$(<"$OPENVPN_PID_FILE")"
  [[ "$pid" =~ ^[0-9]+$ ]] || return 1
  ps -p "$pid" >/dev/null 2>&1 || return 1

  printf '%s\n' "$pid"
}

ikev2_pid() {
  local pid

  pid="$(pgrep -f "$IKEV2_PROVIDER" 2>/dev/null | tail -n 1)"
  [[ -n "$pid" ]] || return 1

  printf '%s\n' "$pid"
}

active_vpn_pid() {
  local pid

  is_ipvanish_running || return 1

  pid="$(openvpn_pid)" && {
    printf '%s\n' "$pid"
    return 0
  }

  pid="$(ikev2_pid)" && {
    printf '%s\n' "$pid"
    return 0
  }

  return 1
}

current_country_code() {
  [[ -f "$PREFS_FILE" ]] || return 1

  plutil -extract VPNCurrentCountry raw -o - "$PREFS_FILE" 2>/dev/null \
    | tr '[:lower:]' '[:upper:]'
}

country_flag() {
  local country_code="$1"

  [[ "$country_code" =~ ^[A-Z]{2}$ ]] || return 1

  perl -CS -e '
    my $code = shift;
    print chr(0x1F1E6 + ord(substr($code, 0, 1)) - 65);
    print chr(0x1F1E6 + ord(substr($code, 1, 1)) - 65);
  ' "$country_code"
}

hide_item() {
  sketchybar --set "$NAME" drawing=off label="" popup.drawing=off update_freq="$DEFAULT_UPDATE_FREQ"
  sketchybar --set ipvanish.location drawing=off label=""
  sketchybar --set ipvanish.duration drawing=off label=""
}

current_location() {
  local city_id history location

  [[ -f "$PREFS_FILE" ]] || return 1

  city_id="$(plutil -extract VPNCurrentCity raw -o - "$PREFS_FILE" 2>/dev/null)"
  [[ -n "$city_id" ]] || return 1

  history="$(plutil -extract history raw -o - "$PREFS_FILE" 2>/dev/null)"
  if [[ -n "$history" ]]; then
    location="$(printf '%s' "$history" \
      | jq -r --arg city_id "$city_id" 'map(select(.cityID == $city_id))[0].name // empty' 2>/dev/null)"
  fi

  if [[ -n "$location" ]]; then
    printf '%s\n' "$location"
    return 0
  fi

  printf '%s\n' "${city_id%:*}"
}

connection_started_epoch() {
  local pid start_time

  pid="$(active_vpn_pid)" || return 1
  start_time="$(ps -o lstart= -p "$pid" 2>/dev/null | sed 's/^ *//')"
  [[ -n "$start_time" ]] || return 1

  date -j -f "%a %b %e %T %Y" "$start_time" "+%s" 2>/dev/null
}

format_duration() {
  local total_seconds="$1"
  local days hours minutes seconds

  days=$(( total_seconds / 86400 ))
  hours=$(( (total_seconds % 86400) / 3600 ))
  minutes=$(( (total_seconds % 3600) / 60 ))
  seconds=$(( total_seconds % 60 ))

  if (( days > 0 )); then
    printf '%dd %dh %dm' "$days" "$hours" "$minutes"
  elif (( hours > 0 )); then
    printf '%dh %dm' "$hours" "$minutes"
  elif (( minutes > 0 )); then
    printf '%dm %ds' "$minutes" "$seconds"
  else
    printf '%ds' "$seconds"
  fi
}

render_popup() {
  local location connected_for

  location="$(current_location)" || return 1
  connected_for="$(format_duration "$1")"

  sketchybar --set ipvanish.location drawing=on label="Connected to $location"
  sketchybar --set ipvanish.duration drawing=on label="Connected for $connected_for"
}

update() {
  local country_code flag location started_at now elapsed

  active_vpn_pid >/dev/null || {
    hide_item
    return 0
  }

  country_code="$(current_country_code)"
  location="$(current_location)"
  [[ -n "$country_code" && -n "$location" ]] || {
    hide_item
    return 0
  }

  flag="$(country_flag "$country_code")" || {
    hide_item
    return 0
  }

  started_at="$(connection_started_epoch)" || {
    hide_item
    return 0
  }

  now="$(date +%s)"
  elapsed=$(( now - started_at ))
  (( elapsed >= 0 )) || elapsed=0

  sketchybar --set "$NAME" drawing=on label="$flag"
  render_popup "$elapsed" || hide_item
}

popup() {
  if [[ "$1" == "on" ]]; then
    active_vpn_pid >/dev/null || {
      sketchybar --set "$NAME" popup.drawing=off
      return 0
    }
  fi

  case "$1" in
    on) open_popup_exclusive "$NAME" ;;
    toggle) toggle_popup_exclusive "$NAME" ;;
    *) sketchybar --set "$NAME" popup.drawing="$1" ;;
  esac
}

set_update_freq() {
  sketchybar --set "$NAME" update_freq="$1"
}

main() {
  case "$SENDER" in
    "routine"|"forced")
      update
      ;;
    "mouse.entered")
      set_update_freq "$HOVER_UPDATE_FREQ"
      update
      popup on
      ;;
    "mouse.exited"|"mouse.exited.global")
      set_update_freq "$DEFAULT_UPDATE_FREQ"
      popup off
      ;;
    *)
      update
      ;;
  esac
}

main
