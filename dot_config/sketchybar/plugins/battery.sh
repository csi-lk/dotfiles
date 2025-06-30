#!/usr/bin/env bash

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

# Nerd Font icons for battery levels
if [[ $CHARGING != "" ]]; then
  ICON="󰂄"
elif [ $PERCENTAGE -gt 90 ]; then
  ICON="󰁹"
elif [ $PERCENTAGE -gt 70 ]; then
  ICON="󰂁"
elif [ $PERCENTAGE -gt 50 ]; then
  ICON="󰁿"
elif [ $PERCENTAGE -gt 30 ]; then
  ICON="󰁽"
elif [ $PERCENTAGE -gt 10 ]; then
  ICON="󰁻"
else
  ICON="󰂎"
fi

sketchybar --set $NAME icon="$ICON" label="${PERCENTAGE}%"