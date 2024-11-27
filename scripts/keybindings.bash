#!/usr/bin/bash

KEYBINDINGS_FILE="$HOME/.config/Code/User/keybindings.json"
mkdir -p "$(dirname "$keybindings_file")"
touch "$KEYBINDINGS_FILE"

add_keybinding() {
    local new_keybinding=$1

    if [ ! -s "$KEYBINDINGS_FILE" ]; then
        echo -e "[\n    $new_keybinding\n]" > "$KEYBINDINGS_FILE"
        return
    fi

    local current_content
    current_content=$(cat "$KEYBINDINGS_FILE" | jq .)

    if [ "$current_content" == "null" ]; then
        echo -e "[\n    $new_keybinding\n]" > "$KEYBINDINGS_FILE"
        return
    fi

    local updated_content
    updated_content=$(echo "$current_content" | jq ". + [$new_keybinding]")

    echo "$updated_content" | jq . > "$KEYBINDINGS_FILE"
}

add_keybinding "'{"key": "meta+g","command": "workbench.action.tasks.runTask","args": "Add .gitignore"}'"
