#!/usr/bin/bash

SETTINGS_FILE="$HOME/.config/Code/User/settings.json"
mkdir -p "$(dirname "$settings_file")"
touch "$SETTINGS_FILE"

add_setting() {
    local new_setting=$1

    if [ ! -s "$SETTINGS_FILE" ]; then
        echo -e "{\n    ${new_setting}\n}" > "$SETTINGS_FILE"
        return
    fi

    local current_content
    current_content=$(cat "$SETTINGS_FILE" | jq .)

    local updated_content
    updated_content=$(echo "$current_content" | jq --argjson new_setting "{${new_setting}}" '. + $new_setting')

    echo "$updated_content" | jq . > "$SETTINGS_FILE"
}

add_setting '"42header.email": ""'
add_setting '"42header.username": ""'
add_setting '"files.autoSave": "afterDelay"'
add_setting '"editor.insertSpaces": false'
add_setting '"editor.renderWhitespace": "all"'
add_setting '"files.insertFinalNewline": true'
add_setting '"files.trimTrailingWhitespace": true'
add_setting '"makefile.configureOnOpen": true'
add_setting '"[c]": {"editor.defaultFormatter": "keyhr.42-c-format"}'
add_setting '"terminal.integrated.defaultProfile.linux": "bash"'
add_setting '"workbench.startupEditor": "none"'
