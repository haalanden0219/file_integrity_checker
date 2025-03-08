#!/usr/bin/env bash

baseline="/opt/filechecker/baseline.hash"
periodic="/opt/filechecker/updated.hash"

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
