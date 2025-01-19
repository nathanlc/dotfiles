#!/usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

function fetch_prs ()
{
	prs=$(gh search prs \
		--state=open \
		--involves=@me \
		--json title,number,repository \
		-- -author:@me \
		| jq -r '.[] | "\(.repository.name)\t\(.number)\t\(.title)"')

	echo "${prs}"
}

function pr_to_worktree ()
{
	pr="${1}"
	IFS=$'\t' read -r repo number pr_title <<< "${pr}"
	title=$(echo "${pr_title}" | tr ' ' '_')
	echo "${repo}_pr-${number}_${title}"
}

function worktree_to_repo ()
{
	worktree="${1}"
	repo=$(echo "${worktree}" | gsed -E 's/(.*)_pr-.*/\1/')
	echo "${repo}"
}

function worktree_to_pr_number ()
{
	worktree="${1}"
	number=$(echo "${worktree}" | gsed -E 's/.*_pr-([0-9]+)_.*/\1/')
	echo "${number}"
}

while :
do
	# Setup
	## Handle only glooko prs
	cd "${HOME}/sandbox/glooko"
	existing_worktrees=$(ls -d *_pr-*)
	prs=$(fetch_prs)
	fetched_worktrees=()

	IFS=$'\n'
	for pr in ${prs}; do
		worktree_name=$(pr_to_worktree $pr)
		fetched_worktrees+=("${worktree_name}")
	done

	# Create new worktrees
	echo 'Creating new worktrees'
	for worktree in ${fetched_worktrees[@]}; do
		if [[ "${existing_worktrees}" =~ "$worktree" ]]; then
			echo "  Skipping existing worktree: ${worktree}"
			continue
		fi
		echo "  Creating new worktree: ${worktree}"
		repo=$(worktree_to_repo "${worktree}")
		pr_number=$(worktree_to_pr_number "${worktree}")
		git -C "${repo}" worktree add "../${worktree}"
		cd "${worktree}"
		gh pr checkout "${pr_number}"
		cd ..
	done

	# Cleanup old worktrees
	# echo 'Deleting old worktrees'
	# for worktree in ${existing_worktrees}; do
	# 	if [[ "${fetched_worktrees}" =~ "$worktree" ]]; then
	# 		echo "  Keeping used worktree: ${worktree}"
	# 		continue
	# 	fi
	# 	echo "  Deleting old worktree: ${worktree}"
	# 	repo=$(worktree_to_repo "${worktree}")
	# 	git -C "${repo}" worktree remove -f "../${worktree}"
	# done
	echo '------'

	sleep 5m
done
