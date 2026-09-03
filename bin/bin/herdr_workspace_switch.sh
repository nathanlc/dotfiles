#!/usr/bin/env bash
set -o errexit   # abort on nonzero exitstatus
set -o pipefail  # don't hide errors within pipes

# Show only the label in fzf but keep the workspace id in a hidden column.
selected=$(herdr workspace list | jq -r \
	'.result.workspaces | sort_by(.label | ascii_downcase)[] | "\(.workspace_id)\t\(.label)"' \
	| fzf --delimiter='\t' --with-nth=2..)

# If no workspace was selected with fzf, don't exit with error
if [[ -z "${selected}" ]]; then
	exit 0
fi

herdr workspace focus "${selected%%$'\t'*}"
