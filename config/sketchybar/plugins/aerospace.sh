#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    # sketchybar --set $NAME background.drawing=on
    sketchybar --set $NAME drawing=on background.drawing=on
else
    # sketchybar --set $NAME background.drawing=off
    sketchybar --set $NAME drawing=off
fi
