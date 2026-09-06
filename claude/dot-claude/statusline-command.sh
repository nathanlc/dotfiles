#!/bin/bash
# Claude Code statusline: model + effort, context window usage, session cost, plan usage

# Single jq pass over the statusline JSON: one value per line, blank when absent
{
  read -r model_name
  read -r effort
  read -r ctx_tokens
  read -r ctx_size
  read -r ctx_pct
  read -r five_pct
  read -r five_resets_at
  read -r week_pct
  read -r cost_usd
} < <(jq -r '[
  .model.display_name // "unknown",
  .effort.level // "",
  ((.context_window.total_input_tokens // 0) + (.context_window.total_output_tokens // 0)),
  .context_window.context_window_size // 0,
  .context_window.used_percentage // "",
  .rate_limits.five_hour.used_percentage // "",
  .rate_limits.five_hour.resets_at // "",
  .rate_limits.seven_day.used_percentage // "",
  .cost.total_cost_usd // ""
] | .[]')

fmt_tokens() {
  awk -v n="$1" 'BEGIN {
    if (n >= 1000000) printf "%.1fM", n / 1000000
    else if (n >= 1000) printf "%.1fk", n / 1000
    else printf "%d", n
  }'
}

# Local wall-clock time for an epoch, GNU date first then BSD date
fmt_time() {
  date -d "@$1" +%H:%M 2>/dev/null || date -r "$1" +%H:%M 2>/dev/null
}

parts=("$model_name${effort:+ $effort}")

# Context window: tokens in context out of the model's window, plus percent used
if [ "$ctx_size" -gt 0 ] 2>/dev/null; then
  ctx="ctx: $(fmt_tokens "$ctx_tokens")/$(fmt_tokens "$ctx_size")"
  [ -n "$ctx_pct" ] && ctx="$ctx ($(printf '%.0f' "$ctx_pct")%)"
  parts+=("$ctx")
fi

[ -n "$cost_usd" ] && parts+=("cost: $(printf '$%.2f' "$cost_usd")")

# Plan usage: 5-hour and 7-day subscription limits (absent outside subscription sessions)
usage=""
[ -n "$five_pct" ] && usage="5h:$(printf '%.0f' "$five_pct")%"
[ -n "$usage" ] && [ -n "$five_resets_at" ] && usage="$usage ($(fmt_time "$five_resets_at"))"
[ -n "$week_pct" ] && usage="${usage:+$usage }7d:$(printf '%.0f' "$week_pct")%"
[ -n "$usage" ] && parts+=("usage: $usage")

out="${parts[0]}"
for p in "${parts[@]:1}"; do out="$out | $p"; done

# Statusline is rendered dimmed by the terminal
printf '\033[2m%s\033[0m\n' "$out"
