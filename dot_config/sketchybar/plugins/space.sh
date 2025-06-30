#!/usr/bin/env bash

SPACE_ID=$(echo "$NAME" | cut -d'.' -f2)
SELECTED=$(yabai -m query --spaces --space $SPACE_ID | jq -r '.["has-focus"]')

if [[ $SELECTED == "true" ]]; then
  sketchybar --set $NAME background.drawing=on
else
  sketchybar --set $NAME background.drawing=off
fi