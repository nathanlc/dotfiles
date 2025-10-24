set -o errexit   # abort on nonzero exitstatus
# set -o nounset   # abort on unbound variable which we don't want because of $TMUX
set -o pipefail  # don't hide errors within pipes

if [[ $1 ]]; then
	project_path=$1
else
	# Use sed to replace the home directory with ~ for shorter line.
	project_path=$(find ~/sandbox -type d -mindepth 2 -maxdepth 2 | sed "s#${HOME}#~#" | fzf)
fi

# If no project was selected with fzf, don't exit with error
if [[ -z "${project_path}" ]]; then
	exit 0
fi

# Replace ~ with $HOME so tmux opens the correct directory.
project_full_path=$(echo "${project_path}" | sed "s#~#${HOME}#")
session_name=$(basename "${project_full_path}")

tmux_running=$(pgrep tmux)

if [[ -z "${tmux_running}" ]]; then
	tmux new-session -s "${session_name}" -c "${project_full_path}"
	exit 0
fi

if ! tmux has-session -t "${session_name}" 2>/dev/null; then
	tmux new-session -d -s "${session_name}" -c "${project_full_path}"
fi

if [[ -z "${TMUX}" ]]; then
	tmux attach-session -t "${session_name}"
	exit 0
fi

tmux switch-client -t "${session_name}"
