#!/bin/bash

codex_item=(
  icon.drawing=off
  label="--%"
  label.font="$FONT:Semibold:11.0"
  label.padding_left=-1.5
  label.padding_right=10
  padding_left=1
  padding_right=1
  update_freq=30
  script="$PLUGIN_DIR/codex.sh"
)

sketchybar --add item codex right \
  --set codex "${codex_item[@]}"
