#!/usr/bin/env bash

set -o errexit
set -o pipefail

panes=$(tmux list-panes -a \
  -f "#{==:#{pane_current_command},opencode}" \
  -F "#{session_name}:#{window_index}.#{pane_index}	#{session_name}	#{pane_title}")

if [[ -z "$panes" ]]; then
  echo "No opencode instances running"
  sleep 1
  exit 0
fi

entries=""
while IFS=$'\t' read -r target session title; do
  topic="${title#OC | }"
  entries+="${target}	${session}	${topic}"$'\n'
done <<< "$panes"

selected=$(printf "%s" "$entries" | fzf \
  --delimiter='\t' \
  --with-nth=2.. \
  --header="OpenCode Instances" \
  --preview='tmux capture-pane -t {1} -p | tail -n $FZF_PREVIEW_LINES' \
  --preview-window=bottom,60%)

[[ -z "$selected" ]] && exit 0

target=$(printf "%s" "$selected" | cut -f1)
session="${target%%:*}"

tmux switch-client -t "$session" \; \
  select-window -t "$target" \; \
  select-pane -t "$target"
