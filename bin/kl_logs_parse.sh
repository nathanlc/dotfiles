YELLOW='\033[0;33m'
LIGHT_GRAY='\033[0;37m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

trap "echo Running: 'mutagen-compose stop mutagen-web'; mutagen-compose stop mutagen-web" SIGINT SIGTERM
while IFS= read -r line; do
  formatted_line=$(printf '%s\n' "$line" | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g' | jq -r '[.ts, (.l | ascii_upcase), .msg] | join(" | ")' 2>/dev/null || printf '%s\n' "$line")
  colored_line="$formatted_line"
  if [[ $formatted_line == *"ERROR"* ]] || [[ $formatted_line == *"FATAL"* ]]; then
    colored_line="${RED}$formatted_line${NC}"
  elif [[ $formatted_line == *"WARN"* ]]; then
    colored_line="${YELLOW}$formatted_line${NC}"
  elif [[ $formatted_line == *"DEBUG"* ]]; then
    colored_line="${BLUE}$formatted_line${NC}"
  fi
  echo "$colored_line" | sed -E 's/ \| (DEBUG|INFO|WARN|ERROR|FATAL)//'
done
