#!/usr/bin/env bash
set -o errexit   # abort on nonzero exitstatus
set -o pipefail  # don't hide errors within pipes

if [[ $1 ]]; then
	project_path=$1
else
	# Use sed to replace the home directory with ~ for shorter line.
	project_path=$(find ~/sandbox -type d -mindepth 2 -maxdepth 2 | sed "s#${HOME}#~#" | fzf)
fi

# If no project was selected with fzf, don't exit with error
if [[ -z "${project_path}" ]]; then
	exit 0
fi

# Replace ~ with $HOME so herdr opens the correct directory.
project_full_path=$(echo "${project_path}" | sed "s#~#${HOME}#")
label=$(basename "${project_full_path}")

existing_id=$(herdr workspace list | jq -r --arg label "${label}" \
	'.result.workspaces[] | select(.label == $label) | .workspace_id' | head -n1)

if [[ -n "${existing_id}" ]]; then
	herdr workspace focus "${existing_id}"
else
	herdr workspace create --cwd "${project_full_path}" --label "${label}" --focus
fi
