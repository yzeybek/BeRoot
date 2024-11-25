#!/bin/bash

# Check if the user provided a .desktop file
if [ -z "$1" ]; then
    echo "Usage: $0 <path-to-desktop-file>"
    exit 1
fi

# The .desktop file passed as argument
desktop_file="$1"

# Check if the file exists
if [ ! -f "$desktop_file" ]; then
    echo "Error: File '$desktop_file' not found!"
    exit 1
fi

# Process the .desktop file and modify the Exec lines
while IFS= read -r line; do
    # Check if the line starts with "Exec="
    if [[ "$line" =~ ^Exec=(.*) ]]; then
        # Extract the original command from the Exec line
        original_exec="${BASH_REMATCH[1]}"
        
        # Modify the Exec line to use the docker exec command
        modified_exec="Exec=bash -c \"docker exec -dit Wroot $original_exec --no-sandbox\""
        
        # Print the modified Exec line
        echo "$modified_exec"
    else
        # If it's not an Exec line, keep it unchanged
        echo "$line"
    fi
done < "$desktop_file" > "$desktop_file.tmp"

# Replace the original file with the modified one
mv "$desktop_file.tmp" "$desktop_file"

echo "File '$desktop_file' has been updated successfully."

