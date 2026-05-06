#!/bin/bash

source "$HOME/.config/color/colors.sh"

case "$1" in
  default) color="$ACTIVE_WINDOW_BORDER_COLOR" ;;
  command) color="$BLUE" ;;
  spotify) color="$GREEN" ;;
  move) color="$TEAL" ;;
  app) color="$RED" ;;
  firefox) color="$ORANGE" ;;
  drive) color="$MAGENTA" ;;
  restart) color="$GREEN" ;;
  kill) color="$RED" ;;
  *) color="$ACTIVE_WINDOW_BORDER_COLOR" ;;
esac

yabai -m config active_window_border_color "$color"
