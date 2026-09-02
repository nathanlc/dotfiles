#!/usr/bin/env bash
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

cd "${HERDR_ACTIVE_PANE_CWD:-.}"

branch=$(git branch --show-current 2>/dev/null)
if [[ -z ${branch} ]]; then
	exit 0
fi

nice_branch=$''" ${branch}"
printf '%s\n' "${nice_branch}"
