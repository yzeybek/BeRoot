#!/usr/bin/bash

add_setting() {
    local new_setting=$1
    local settings_file="settings.json"

    mkdir -p "$(dirname "$settings_file")"
    touch "$settings_file"

    if [ ! -s "$settings_file" ]; then
        echo -e "{\n    ${new_setting}\n}" > "$settings_file"
        return
    fi

    local current_content
    current_content=$(cat "$settings_file" | jq .)

    local updated_content
    updated_content=$(echo "$current_content" | jq --argjson new_setting "{${new_setting}}" '. + $new_setting')

    echo "$updated_content" | jq . > "$settings_file"
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
