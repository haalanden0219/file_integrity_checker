#!/usr/bin/env bash

file="/opt/filechecker/paths.conf"
file_database="/opt/filechecker/baseline.hash"

if [[ ! -f "$file" ]]; then
	echo "Error: File '$file' does not exist."
	exit 1
fi

while IFS= read -r line; do
	if [ -d "$line" ]; then
		ls "$line"
	elif [ -f "$line" ]; then
		md5_result="$(md5sum "$line")"
		if ! grep -q "$md5_result" "$file_database"; then
			echo "$md5_result" >> "$file_database"
		fi
	else 
		echo "'$line' is not a file/directory"
	fi
done < "$file"
