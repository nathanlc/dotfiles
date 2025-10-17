#!/usr/bin/env bash

set -e

results=()
while IFS= read -r line; do
    results+=("$line")
done < <(/opt/homebrew/bin/op item list --format json | /opt/homebrew/bin/jq -r '.[] | select(has("urls")) | {id, title} + (.urls[]) | "\(.id):\(.title):\(.href)"' | grep "github.com") || $(echo "message-error 'No entry found for $URL'" >> $QUTE_FIFO)

echo -e "Results:\n${results[@]}"

result_list=$(printf '"%s", ' "${results[@]}")
result_list=${result_list%, }  # Remove trailing comma

result=$(osascript <<EOF
set optionsList to {${result_list}}
set selectedOption to choose from list optionsList with prompt "Choose a file:" default items {"${results[0]}"}
if selectedOption is false then
    return "CANCELLED"
else
    return selectedOption as string
end if
EOF
)

echo "Selected: $result"
