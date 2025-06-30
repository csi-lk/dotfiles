#!/usr/bin/env bash

# Check if connected to network
NETWORK=$(ipconfig getifaddr en0 || ipconfig getifaddr en1)

if [[ $NETWORK != "" ]]; then
  ICON="󰖩"
  LABEL="Connected"
else
  ICON="󰖪"
  LABEL="Offline"
fi

sketchybar --set $NAME icon="$ICON" label="$LABEL"