#!/usr/bin/env bash

WEATHER_CONFIG="$HOME/.config/sketchybar/plugins/weather_config.json"
WEATHER_USER_AGENT="SketchyBar Weather (tobin@localhost)"
LATITUDE=$(jq -r '.weathergov.latitude' "$WEATHER_CONFIG")
LONGITUDE=$(jq -r '.weathergov.longitude' "$WEATHER_CONFIG")
POINTS_URL=$(jq -r '.weathergov.points_url' "$WEATHER_CONFIG")
URL=$(curl -fsSL \
    -H "Accept: application/geo+json" \
    -H "User-Agent: $WEATHER_USER_AGENT" \
    "$POINTS_URL/$LATITUDE,$LONGITUDE" | jq -r '.properties.forecast') || exit 0
WEATHER=$(curl -fsSL \
    -H "Accept: application/geo+json" \
    -H "User-Agent: $WEATHER_USER_AGENT" \
    "$URL") || exit 0
TEMP=$(echo "$WEATHER" | jq -r '.properties.periods[0] | "\(.temperature)° \(.shortForecast)"')

sketchybar --set $NAME label="${TEMP}"
