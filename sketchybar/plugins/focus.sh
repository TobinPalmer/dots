#!/bin/bash
SOURCE=$(cat ~/Library/DoNotDisturb/DB/Assertions.json | jq '.[][]' | grep assertionDetailsModeIdentifier | tail -1 | cut -d'"' -f4)

sketchybar --set $NAME label="EX"

