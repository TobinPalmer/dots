#!/bin/bash

sketchybar --add       event              input_change 'AppleSelectedInputSourcesChangedNotification' \
    --add       item               keyboard right                                              \
    --set       keyboard           script="$PLUGIN_DIR/keyboard.sh"                            \
    width=30                                                    \
    label.padding_right=10                                      \
    label.padding_left=10                                       \
    label.font="$FONT:Bold:12"                                  \
    --subscribe keyboard           input_change
