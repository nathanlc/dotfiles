#!/usr/bin/env bash

set -o errexit
set -o pipefail

# Identify agent type from pane title.
# Each tool sets a distinctive title prefix:
#   opencode → "OC | <topic>"
#   pi       → "π - <project>"
#   claude   → "✳ <topic>"
agent_from_title() {
  local title="$1"
  if   [[ "$title" == "OC | "* ]]; then echo "opencode"
  elif [[ "$title" == "π - "* ]];  then echo "pi"
  elif [[ "$title" == "✳ "* ]];    then echo "claude"
  else echo ""
  fi
}

topic_from_title() {
  local agent="$1" title="$2"
  case "$agent" in
    opencode) echo "${title#OC | }" ;;
    pi)       echo "${title#π - }"  ;;
    claude)   echo "${title#✳ }"   ;;
    *)        echo "$title"         ;;
  esac
}

agent_badge() {
  case "$1" in
    opencode) echo "[opencode]" ;;
    pi)       echo "[pi]"       ;;
    claude)   echo "[claude]"   ;;
  esac
}

panes=$(tmux list-panes -a \
  -F "#{session_name}:#{window_index}.#{pane_index}	#{session_name}	#{pane_title}")

entries=""
while IFS=$'\t' read -r target session title; do
  agent=$(agent_from_title "$title")
  [[ -z "$agent" ]] && continue

  topic=$(topic_from_title "$agent" "$title")
  badge=$(agent_badge "$agent")

  entries+="${target}	${badge}	${session}	${topic}"$'\n'
done <<< "$panes"

if [[ -z "$entries" ]]; then
  echo "No agent instances running"
  sleep 1
  exit 0
fi

selected=$(printf "%s" "$entries" | fzf \
  --delimiter=$'\t' \
  --with-nth=2.. \
  --header="Agent Instances" \
  --preview='tmux capture-pane -t {1} -p | tail -n $FZF_PREVIEW_LINES' \
  --preview-window=bottom,60%)

[[ -z "$selected" ]] && exit 0

target=$(printf "%s" "$selected" | cut -f1)
session="${target%%:*}"

tmux switch-client -t "$session" \; \
  select-window -t "$target" \; \
  select-pane -t "$target"
