run:
	quickshell -p .

start:
	#!/usr/bin/env nu
	if (tmux has-session -t yans err> /dev/null) {
		echo "Session yans already exists"
	} else {
		tmux new-session -d -s yans -c (pwd)
		tmux send-keys -t yans "quickshell -p ." Enter
		echo "Started yans session"
	}

stop:
	tmux kill-session -t yans 2>/dev/null || true

logs:
	tmux capture-pane -t yans -p -S -50

attach:
	tmux attach -t yans

build:
	nix build

update:
	nix flake update