#!/usr/bin/env bash

CPU=$(top -l 2 -n 0 -F | egrep -o ' \d*\.\d+% idle' | tail -1 | awk '{print 100-$1}' | cut -d. -f1)

sketchybar --set $NAME label="$CPU%"