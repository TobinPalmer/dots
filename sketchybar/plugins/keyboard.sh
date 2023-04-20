#!/usr/bin/env bash

SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)

case ${SOURCE} in
'com.apple.keylayout.US') LABEL='EN' ;;
'com.apple.keylayout.USInternational-PC') LABEL='IN' ;;
esac

sketchybar --set $NAME label="$LABEL"
