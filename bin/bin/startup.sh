#!/usr/bin/env sh

function is_linux {
  [[ $(uname) == 'Linux' ]] && return 0 || return 1
}

function is_def {
  command -v "$1" >/dev/null 2>&1 && return 0 || return 1
}

function start_app {
	app_name=$1
	running=$(ps aux | grep -v grep | grep -q "${app_name}")
	[[ $running != "" ]] || eval "${app_name}" &
}

function start_tmux_dotfiles {
	dotfiles_session="dotfiles"
	dotfiles_exist=$(tmux list-sessions | grep -q "${dotfiles_session}")
	$dotfiles_exist || tmux new -s "${dotfiles_session}" -c "$HOME/sandbox/nathanlc/dotfiles"
}

function linux_sway_startup {
	sway 'workspace z'; sleep 0.2s
	start_tmux_dotfiles
	sway 'workspace e'; sleep 0.2s
	start_app zen-browser; sleep 1s
	sway 'workspace x'; sleep 0.2s
	start_app 1password; sleep 1s
	sway 'workspace z'
}

is_def 'sway' && is_linux && linux_sway_startup
