#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

script_name=$(basename "${0}")
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# logs_file="${script_dir}/logs/${script_name:0:-3}.log"
# if [[ ! -f "${logs_file}" ]]; then
# 	touch "${logs_file}"
# fi
# readonly script_name script_dir logs_file
readonly script_name script_dir

log() {
	msg="${1}"
	printf '%s\n' "$(date '+%Y-%m-%d %H:%M:%S') - ${msg}"
	# printf '%s\n' "$(date '+%Y-%m-%d %H:%M:%S') - ${msg}" >> "${logs_file}"
}

meeting_ongoing=false
while :
do
	previous_meeting_ongoing=$meeting_ongoing
	zoom_udps=$(lsof -iUDP | grep -i zoom)
	number_of_zoom_udps=$(echo "$zoom_udps" | wc -l)
	if [[ $number_of_zoom_udps -gt 1 ]]; then
		meeting_ongoing=true
	else
		meeting_ongoing=false
	fi

	if [[ $meeting_ongoing != $previous_meeting_ongoing ]]; then
		if [[ $meeting_ongoing == true ]]; then
		    log "Zoom Meeting Started"
			hs -c 'hs.application.launchOrFocus("zoom.us")'
			hs -c 'WindowRight()'
			hs -c 'hs.application.launchOrFocus("Kitty")'
			hs -c 'WindowLeft()'
			nvr -cc only ~/Dropbox/neorg/meetings.norg
		else
			log "Zoom Meeting Ended"
			hs -c 'hs.application.launchOrFocus("Kitty")'
			hs -c 'WindowMaximize()'
		fi
	fi
	sleep 5s
done
