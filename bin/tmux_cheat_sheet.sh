#!/usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

exec 3>&1

function debug {
	message=$1
    echo "${message}" 1>&3
}

input="NOPE"
if [[ -z $@ ]]; then
	read -p "Cheat sheet query: " input
else
	input=$@
fi

# Transform "cmd some query" into "cmd/some+query"
query=$(echo "${input}" | gsed 's/ /\//')
query=$(echo "${query}" | gsed 's/ /+/g')

# Open in new tmux window and keep open
tmux new-window bash -c "curl \"cht.sh/${query}\"; while [ : ]; do sleep 1; done"
