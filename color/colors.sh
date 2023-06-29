#!/bin/bash

export FLOATING_BAR=false

# Color Palette (Dracula Theme)
# export BLACK=0xff181926
# export WHITE=0xfff8f8f2
# export RED=0xffff5555
# export BLUE=0xff8be9fd
# export GREEN=0xff50fa7b
# export YELLOW=0xfff1fa8c
# export ORANGE=0xffffb86c
# export MAGENTA=0xffbd93f9
# export GREY=0xff44475a
# export TRANSPARENT=0x00000000

export BLACK=0xff11111b
export WHITE=0xfff8f8f2
export RED=0xfff38ba8
export BLUE=0xff74c7ec
export GREEN=0xffa6e3a1
export YELLOW=0xfff9e2af
export ORANGE=0xfffab387
export MAGENTA=0xffcba6f7
export GREY=0xffa6adc8
export TEAL=0xff89b4fa
export TRANSPARENT=0x00000000

# Yabai colors
export ACTIVE_WINDOW_BORDER_COLOR=0xff1e1d2c
export NORMAL_WINDOW_BORDER_COLOR=0xff2a2f38
export INSERT_FEEDBACK_COLOR=0xff9dd274

# Sketchybar

# export BAR_BORDER_COLOR=0xffbd93f9
export BAR_COLOR
[[ $FLOATING_BAR = false ]] && BAR_COLOR="0xf51E1E2E" || BAR_COLOR="0xff1E1E2E"

export ICON_COLOR=$WHITE # Color of all icons
export LABEL_COLOR=$WHITE # Color of all labels
export BACKGROUND_1=0x603c3e4f
export BACKGROUND_2=0x60494d64

export POPUP_BACKGROUND_COLOR=0xff1e1e2e
export POPUP_BORDER_COLOR=$WHITE

export SHADOW_COLOR=$BLACK

# Weather colors
export VERY_COLD=0xff8aadf4
export COLD=0xff5689f0
export COOL=0xff45c9f5
export NICE=0xff0fdb8a
export WARM=0xffeefa14
export HOT=0xfff5b00f
export VERY_HOT=0xfff5130f
