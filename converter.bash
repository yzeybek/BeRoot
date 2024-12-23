#!/usr/bin/bash

APPLICATIONS_DIR="$HOME/.local/share/applications"
FILES_TXT="$APPLICATIONS_DIR/files.txt"

touch "$FILES_TXT"

if [[ -f "$FILES_TXT" ]]; then
    mapfile -t previous_files < "$FILES_TXT"
else
    previous_files=()
fi

mapfile -t current_files < <(find "$APPLICATIONS_DIR" -maxdepth 1 -name "*.desktop")

new_files=()
for file in "${current_files[@]}"; do
    if [[ ! " ${previous_files[@]} " =~ " $file " ]]; then
        new_files+=("$file")
    fi
done

for file in "${new_files[@]}"; do
    echo "Processing: $file"
    temp_file="${file}.tmp"

    while IFS= read -r line; do
        if [[ "$line" =~ ^Exec=(.*) ]]; then
            original_exec="${BASH_REMATCH[1]}"
            modified_exec="Exec=bash -c \"docker exec -dit BeRoot $original_exec --no-sandbox\""
            echo "$modified_exec" >> "$temp_file"
        else
            echo "$line" >> "$temp_file"
        fi
    done < "$file"

    mv "$temp_file" "$file"
    echo "Updated: $file"

    name=$(basename "$file")
    current_favorites=$(gsettings get org.gnome.shell favorite-apps)
    current_favorites_cleaned=$(echo "$current_favorites" | sed "s/^\[//" | sed "s/\]//")
    new_favorites="$current_favorites_cleaned, '$name'"
    new_favorites_wrapped="[$new_favorites]"
    gsettings set org.gnome.shell favorite-apps "$new_favorites_wrapped"
done

find "$APPLICATIONS_DIR" -maxdepth 1 -name "*.desktop" > "$FILES_TXT"
