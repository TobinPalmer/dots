#!/bin/sh

POPUP_QUERY_BIN="${JQ_BIN:-$(command -v jq || echo /opt/homebrew/bin/jq)}"

close_all_popups() {
    sketchybar --set '/.*/' popup.drawing=off
}

popup_is_open() {
    name="$1"

    [ -x "$POPUP_QUERY_BIN" ] || return 1

    sketchybar --query "$name" 2>/dev/null \
        | "$POPUP_QUERY_BIN" -r '.popup.drawing // "off"' 2>/dev/null \
        | grep -qx "on"
}

open_popup_exclusive() {
    name="$1"

    close_all_popups
    sketchybar --set "$name" popup.drawing=on
}

toggle_popup_exclusive() {
    name="$1"

    if popup_is_open "$name"; then
        sketchybar --set "$name" popup.drawing=off
        return 0
    fi

    open_popup_exclusive "$name"
}
