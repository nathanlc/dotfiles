#!/bin/bash
# Claude Code statusline: model + effort, context window usage, session cost, session time

input=$(cat)

model_name=$(echo "$input" | jq -r '.model.display_name // "unknown"')
effort=$(echo "$input" | jq -r '.effort.level // empty')

model_str="$model_name"
if [ -n "$effort" ]; then
  model_str="$model_str $effort"
fi

# Context window: used tokens (input+output of current context) and percent used
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

ctx_tokens=$(( total_input + total_output ))

# Format token counts as k when large
fmt_tokens() {
  local n=$1
  if [ "$n" -ge 1000 ]; then
    awk -v n="$n" 'BEGIN { printf "%.1fk", n/1000 }'
  else
    echo "$n"
  fi
}

ctx_str=""
if [ "$ctx_size" -gt 0 ] 2>/dev/null; then
  ctx_str="$(fmt_tokens "$ctx_tokens")/$(fmt_tokens "$ctx_size")"
  if [ -n "$used_pct" ]; then
    ctx_str="$ctx_str ($(printf '%.0f' "$used_pct")%)"
  fi
fi

# Session cost: compute from transcript by summing token usage per model turn
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')

cost_str=""
if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
  cost=$(jq -s '
    def price:
      {
        "claude-opus-4-1": {input: 15, output: 75, cache_write: 18.75, cache_read: 1.5},
        "claude-opus-4": {input: 15, output: 75, cache_write: 18.75, cache_read: 1.5},
        "claude-sonnet-4-5": {input: 3, output: 15, cache_write: 3.75, cache_read: 0.3},
        "claude-sonnet-4-1": {input: 3, output: 15, cache_write: 3.75, cache_read: 0.3},
        "claude-sonnet-4": {input: 3, output: 15, cache_write: 3.75, cache_read: 0.3},
        "claude-3-7-sonnet": {input: 3, output: 15, cache_write: 3.75, cache_read: 0.3},
        "claude-3-5-sonnet": {input: 3, output: 15, cache_write: 3.75, cache_read: 0.3},
        "claude-3-5-haiku": {input: 0.8, output: 4, cache_write: 1, cache_read: 0.08},
        "claude-haiku-4-5": {input: 1, output: 5, cache_write: 1.25, cache_read: 0.1},
        "claude-3-opus": {input: 15, output: 75, cache_write: 18.75, cache_read: 1.5},
        "default": {input: 3, output: 15, cache_write: 3.75, cache_read: 0.3}
      };
    def rate($id):
      price as $p
      | ($p | keys[] | select($id | test("^" + . ))) as $k
      | $p[$k] // $p["default"];
    [ .[] | select(.message.usage != null) ] as $msgs
    | reduce $msgs[] as $m (0;
        . + (
          ($m.message.model // "default") as $mid
          | rate($mid) as $r
          | ( ($m.message.usage.input_tokens // 0) * $r.input
            + ($m.message.usage.output_tokens // 0) * $r.output
            + ($m.message.usage.cache_creation_input_tokens // 0) * $r.cache_write
            + ($m.message.usage.cache_read_input_tokens // 0) * $r.cache_read
            ) / 1000000
        )
      )
  ' "$transcript_path" 2>/dev/null)

  if [ -n "$cost" ]; then
    cost_str=$(awk -v c="$cost" 'BEGIN { printf "$%.2f", c }')
  fi
fi

# Session time: elapsed time from first to last transcript timestamp
time_str=""
if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
  read -r first_ts last_ts <<EOF
$(jq -s -r '
    [ .[] | select(.timestamp != null) | .timestamp ] as $ts
    | if ($ts | length) > 0 then ($ts[0] + " " + $ts[-1]) else "" end
  ' "$transcript_path" 2>/dev/null)
EOF

  if [ -n "$first_ts" ] && [ -n "$last_ts" ]; then
    first_epoch=$(date -j -f "%Y-%m-%dT%H:%M:%S" "${first_ts%%.*}" "+%s" 2>/dev/null)
    last_epoch=$(date -j -f "%Y-%m-%dT%H:%M:%S" "${last_ts%%.*}" "+%s" 2>/dev/null)

    if [ -n "$first_epoch" ] && [ -n "$last_epoch" ]; then
      diff=$(( last_epoch - first_epoch ))
      hours=$(( diff / 3600 ))
      mins=$(( (diff % 3600) / 60 ))
      secs=$(( diff % 60 ))
      if [ "$hours" -gt 0 ]; then
        time_str=$(printf "%dh%02dm" "$hours" "$mins")
      elif [ "$mins" -gt 0 ]; then
        time_str=$(printf "%dm%02ds" "$mins" "$secs")
      else
        time_str=$(printf "%ds" "$secs")
      fi
    fi
  fi
fi

# Assemble output with dim colors (statusline is rendered dimmed by the terminal)
parts=()
[ -n "$model_str" ] && parts+=("$model_str")
[ -n "$ctx_str" ] && parts+=("ctx: $ctx_str")
[ -n "$cost_str" ] && parts+=("cost: $cost_str")
[ -n "$time_str" ] && parts+=("time: $time_str")

out=""
for p in "${parts[@]}"; do
  if [ -z "$out" ]; then
    out="$p"
  else
    out="$out | $p"
  fi
done

printf '\033[2m%s\033[0m\n' "$out"
