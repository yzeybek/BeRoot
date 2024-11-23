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

SET_EMAIL='"42header.email": ""'
SET_USERNAME='"42header.username": ""'
SET_SAVE='"files.autoSave": "afterDelay"'
SET_SPACE='"editor.insertSpaces": false'
SET_WHITESPACE='"editor.renderWhitespace": "all"'
SET_NEWLINE='"files.insertFinalNewline": true'
SET_TRIM='"files.trimTrailingWhitespace": true'
SET_MAKE='"makefile.configureOnOpen": true'
SET_FORMAT='"[c]": {"editor.defaultFormatter": "keyhr.42-c-format"}'
SET_TERMINAL='"terminal.integrated.defaultProfile.linux": "bash"'
SET_DEBUG='"launches": {"C_Debug": "Debug C Files"}'

add_setting "$SET_EMAIL"
add_setting "$SET_USERNAME"
add_setting "$SET_SAVE"
add_setting "$SET_SPACE"
add_setting "$SET_WHITESPACE"
add_setting "$SET_NEWLINE"
add_setting "$SET_TRIM"
add_setting "$SET_MAKE"
add_setting "$SET_FORMAT"
add_setting "$SET_TERMINAL"
add_setting "$SET_DEBUG"
