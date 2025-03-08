#!/usr/bin/env bash

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage: $0 <baseline> <periodic>"
	exit 1
fi

baseline="$1"
periodic="$2"

diff_result=$(diff "$baseline" "$periodic")

if [ -z "$diff_result" ]; then
	echo "No Difference Detected"
	exit 0
else
	echo "Difference Detected" | systemd-cat -t filechecker -p warning
	diff -y "$baseline" "$periodic" | systemd-cat -t filechecker -p warning
	notify-send "CRITICAL" "A file in your system has been compromised. Check system logs with: journalctl -t file_integirty_checker "
	exit 0
fi
