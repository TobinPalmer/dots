#!/bin/bash

sketchybar --add alias  "Control Center,WiFi" right                      \
    --rename     "Control Center,WiFi" wifi.alias                 \
    --set        wifi.alias    icon.drawing=on                    \
    label.drawing=off                   \
    alias.color="$BLUE"                \
    background.padding_right=-3        \
    background.padding_left=-20        \
    script="$PLUGIN_DIR/wifi.sh"       \
    align=right                        \
    update_freq=30                     \
    --subscribe  wifi.alias    mouse.entered                      \
    mouse.exited                       \
    mouse.exited.global                \
    \
    --add       item          wifi.down popup.wifi.alias         \
    --set       wifi.down     background.corner_radius=12        \
    background.padding_left=10         \
    background.padding_right=10        \
    icon.background.height=2           \
    icon.background.y_offset=-12       \
    icon.drawing=off                   \
    label.align=left                   \
    click_script="sketchybar --set wifi.alias popup.drawing=off" \
    \
    --add       item          wifi.up popup.wifi.alias           \
    --set       wifi.up       background.corner_radius=12        \
    background.padding_left=10         \
    background.padding_right=10        \
    icon.background.height=2           \
    icon.background.y_offset=-12       \
    icon.drawing=off                   \
    label.align=left                   \
    click_script="sketchybar --set wifi.alias popup.drawing=off" \
    \
    --add       item          wifi.ping popup.wifi.alias         \
    --set       wifi.ping     background.corner_radius=12        \
    background.padding_left=10         \
    background.padding_right=10        \
    icon.background.height=2           \
    icon.background.y_offset=-12       \
    icon.drawing=off                   \
    label.align=left                   \
    click_script="sketchybar --set wifi.alias popup.drawing=off" \
    \
    --add       item          wifi.isp popup.wifi.alias          \
    --set       wifi.isp      background.corner_radius=12        \
    background.padding_left=10         \
    background.padding_right=10        \
    icon.background.height=2           \
    icon.background.y_offset=-12       \
    icon.drawing=off                   \
    label.align=left                   \
    click_script="sketchybar --set wifi.alias popup.drawing=off"
