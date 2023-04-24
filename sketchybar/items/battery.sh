#!/bin/bash

sketchybar -m --add item battery right \
              --set battery update_freq=3 \
              --set battery script="$PLUGIN_DIR/battery.sh" \
              --set battery padding_right=3 \
              --set battery icon=
