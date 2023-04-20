#!/usr/bin/env bash

LOCATION="Santa%Monica,%California"
TEMP=$(curl -s "https://wttr.in/${LOCATION}?format=3" |gsed 's|  *| |g')

sketchybar --set $NAME label="${TEMP}"

