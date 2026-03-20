#!/usr/bin/env bash

WEATHER_CONFIG="$HOME/.config/sketchybar/plugins/weather_config.json"
APPLE_WEATHER_HELPER="$HOME/.config/sketchybar/plugins/apple_weather.sh"
LATITUDE=$(jq -r '.weathergov.latitude' "$WEATHER_CONFIG")
LONGITUDE=$(jq -r '.weathergov.longitude' "$WEATHER_CONFIG")
WEATHER=$("$APPLE_WEATHER_HELPER" "$LATITUDE" "$LONGITUDE") || exit 0
TEMP=$(echo "$WEATHER" | jq -r '"\(.temperature)° \(.condition)"')

sketchybar --set $NAME label="${TEMP}"
