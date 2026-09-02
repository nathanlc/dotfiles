#!/usr/bin/env bash
set -o errexit   # abort on nonzero exitstatus
set -o pipefail  # don't hide errors within pipes

label="A24006-medical_data_service"
mds_path="$HOME/sandbox/glooko/${label}"

existing_id=$(herdr workspace list | jq -r --arg label "${label}" \
	'.result.workspaces[] | select(.label == $label) | .workspace_id' | head -n1)

if [[ -n "${existing_id}" ]]; then
	herdr workspace focus "${existing_id}"
	exit 0
fi

created=$(herdr workspace create --cwd "${mds_path}" --label "${label}" --focus)
workspace_id=$(echo "${created}" | jq -r '.result.workspace.workspace_id')
root_tab_id=$(echo "${created}" | jq -r '.result.tab.tab_id')

herdr tab rename "${root_tab_id}" nvim >/dev/null
herdr tab create --workspace "${workspace_id}" --cwd "${mds_path}" --label mds-logs --no-focus >/dev/null
