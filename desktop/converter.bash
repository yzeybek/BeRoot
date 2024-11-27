#!/usr/bin/bash

FILE="$1"

while IFS= read -r line; do
    if [[ "$line" =~ ^Exec=(.*) ]]; then
        original_exec="${BASH_REMATCH[1]}"
        
        modified_exec="Exec=bash -c \"docker exec -dit BeRoot $original_exec --no-sandbox\""
        
        echo "$modified_exec"
    else
        echo "$line"
    fi
done < "$FILE" > "$FILE.tmp"

mv "$FILE.tmp" "$FILE"
