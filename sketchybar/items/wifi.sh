#!/bin/bash

sketchybar --add alias  "Control Center,WiFi" right                      \
    --rename     "Control Center,WiFi" wifi.alias                 \
    --set        wifi.alias    icon.drawing=off                   \
    alias.color="$BLUE"                \
    background.padding_right=-8        \
    background.padding_left=-10        \
    script="$PLUGIN_DIR/wifi.sh"       \
    align=right                        \
    update_freq=3                      \
    --subscribe  wifi.alias    mouse.entered                      \
    mouse.exited                       \
    mouse.exited.global                \
    \
    --add       item          wifi.details popup.wifi.alias      \
    --set       wifi.details  background.corner_radius=12        \
    background.padding_left=10         \
    background.padding_right=10        \
    icon.background.height=2           \
    icon.background.y_offset=-12       \
    label.align=center                 \
    click_script="sketchybar --set wifi.alias popup.drawing=off"
