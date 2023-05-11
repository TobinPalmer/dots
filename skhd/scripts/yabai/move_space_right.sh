#!/bin/bash

source "/Users/tobin/.config/skhd/scripts/yabai/util.sh"

if [[ $CURRENT_SPACE_INDEX -eq $DISPLAY_LAST_NUMBER ]]; then
  RIGHT_SPACE_INDEX=$DISPLAY_FIRST_NUMBER
else
  RIGHT_SPACE_INDEX=$((CURRENT_SPACE_INDEX + 1))
fi

yabai -m space --move "$RIGHT_SPACE_INDEX"

sh ~/.config/yabai/create_spaces.sh

