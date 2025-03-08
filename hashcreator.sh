#!/usr/bin/env bash

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage: $0 <filelist> <hashlist> "
	exit 1
fi

file="$1"
file_database="$2"

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
