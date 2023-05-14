#!/bin/bash

source "/Users/tobin/.config/skhd/scripts/yabai/util.sh"

# yabai -m space --create && \
#                    index="$(yabai -m query --spaces --display | jq 'map(select(."is-native-fullscreen" == false))[-1].index')" && \
#                    yabai -m window --space "${index}" && \
#                    yabai -m space --focus "$CURRENT_SPACE_INDEX"

yabai -m space --create &&
yabai -m window --space last

# wallpaper set ~/.config/wallpapers/Arch.jpg
sh ~/.config/yabai/create_spaces.sh
