#!/bin/sh

CONFIG="$XDG_CONFIG_HOME/khal/config"

START=$(date '+%d.%m.%Y %H:%M')
END=$(date -d '+3 minutes' '+%d.%m.%Y %H:%M')
EVENT=$(khal --config "${CONFIG}" list "${START}" "${END}" --notstarted -df "")

if [ "$EVENT" != "" ]; then
  sketchybar --set "$NAME" label="$EVENT" drawing=on
else
  sketchybar --set "$NAME" label="" drawing=off
fi
