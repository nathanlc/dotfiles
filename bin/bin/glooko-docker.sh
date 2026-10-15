#!/usr/bin/env sh

if [[ "$1" == "stop" ]]; then
	echo "Stopping glooko docker containers..."
	docker ps -f "network=glooko" |\
		grep -v CONTAINER |\
		awk '{print $1}' |\
		xargs -I {} docker stop {}
	echo "Done"
	exit 0
fi
