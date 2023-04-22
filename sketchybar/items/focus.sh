##!/bin/bash
#sketchybar -m --add item focus right \
#              --set focus update_freq=3 \
#              --set focus script="$PLUGIN_DIR/focus.sh" \
#              --set focus padding_right=-3 \
#              --set focus label.font="$FONT:Bold:12"
#
sketchybar --add       item               focus right                                                 \
           --set       focus              script="$PLUGIN_DIR/focus.sh"                               \
                                          width=30                                                    \
                                          label.padding_left=-10                                      \
                                          label.font="$FONT:Bold:12"                                  \
                                          update_freq=3                                               \

