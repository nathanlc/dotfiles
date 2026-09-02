#!/usr/bin/env bash
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

workspace_id=${HERDR_ACTIVE_WORKSPACE_ID:-}
if [[ -z ${workspace_id} ]]; then
	exit 0
fi

label=$(herdr workspace list | jq -r --arg id "${workspace_id}" \
	'.result.workspaces[] | select(.workspace_id == $id) | .label' 2>/dev/null)

if [[ -z ${label} ]]; then
	exit 0
fi

printf ' %s\n' "${label}"
