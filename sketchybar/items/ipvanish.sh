#!/bin/bash

ipvanish_item=(
  updates=on
  drawing=off
  icon.drawing=off
  label=""
  label.font="Apple Color Emoji:Regular:15.0"
  label.padding_left=4
  label.padding_right=2
  padding_left=0
  padding_right=0
  popup.align=right
  update_freq=15
  script="$PLUGIN_DIR/ipvanish.sh"
)

ipvanish_popup_item=(
  drawing=off
  icon.drawing=off
  background.corner_radius=12
  background.padding_left=10
  background.padding_right=10
  label.align=left
  click_script="sketchybar --set ipvanish popup.drawing=off"
)

sketchybar --add item ipvanish right                     \
  --set ipvanish "${ipvanish_item[@]}"                   \
  --subscribe ipvanish mouse.entered                     \
                      mouse.exited                       \
                      mouse.exited.global                \
  --add item ipvanish.location popup.ipvanish           \
  --set ipvanish.location "${ipvanish_popup_item[@]}"   \
  --add item ipvanish.duration popup.ipvanish           \
  --set ipvanish.duration "${ipvanish_popup_item[@]}"
