#!/usr/bin/env bash                                                                       
if [ -z "$1" ] || [ -z "$2" ]; then
       	echo "Usage: $0 <dirlist> <contents> "
  	exit 1
fi

file="$1"
contents="$2"

> "$contents"

while IFS= read -r dir; do
	if [ -d "$dir" ]; then
		for dir_file in "$dir"/*; do
	        	if [ -f "$dir_file" ]; then
				file_path="$(readlink -f "$dir_file")"
				echo "$file_path" >> "$contents"
			fi
		done 
	else
		echo "'$line' is not a directory"
	fi
done < "$file"

