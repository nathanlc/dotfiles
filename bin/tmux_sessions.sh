#!/usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
# set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

exec 3>&1

function debug {
	message=$1
    echo "${message}" 1>&3
}

function get_letter {
	word=$1
	index=$2
	echo "${word:${index}:1}"
}

function session_shortcut {
	session=$1
	index=0
	shortcut="NOPE"
	while [[ $shortcut == "NOPE" ]] || [[ " ${reserved_shortcuts[@]} " =~ " ${shortcut} " ]]; do
		shortcut=$(get_letter $session $index)
		index=$((index + 1))
	done
	echo $shortcut
}

function format_prompt {
	shortcut=$1
	text=$2
	echo "[${shortcut}] ${text}"
}

tmux_running=$(pgrep tmux)

if [[ -z "${tmux_running}" ]]; then
	echo "tmux is not running"
	exit 1
fi

sessions_list=$(tmux list-sessions -F '#{session_name}')

# Build the list of sessions and their shortcuts
sessions=()
reserved_shortcuts=(q 0 1 2 3 4 5 6 7 8 9 A - _) # Reserve "q" for "quit"
session_shortcuts=()
for session in ${sessions_list}; do
	shortcut=$(session_shortcut $session $session_shortcuts)
	sessions+=(${session})
	reserved_shortcuts+=(${shortcut})
	session_shortcuts+=(${shortcut})
done

# Display the session prompt
for index in ${!sessions[@]}; do
	shortcut=${session_shortcuts[$index]}
	session=${sessions[$index]}
	format_prompt $shortcut $session
done
format_prompt "q" "quit"

# Get user choice and handle it
selected_session="NOPE"
while [[ "${selected_session}" == "NOPE" ]]; do
	read -s -n1 choice

	if [[ $choice == "q" ]]; then
		exit 0
	fi

	if [[ " ${session_shortcuts[@]} " =~ " ${choice} " ]]; then
		for index in ${!session_shortcuts[@]}; do
			shortcut=${session_shortcuts[$index]}
			if [[ "${choice}" == "${shortcut}" ]]; then
				selected_session=${sessions[$index]}
				break
			fi
		done
	fi
done

tmux switch-client -t "${selected_session}"
