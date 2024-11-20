#!/usr/bin/bash

add_setting() {
    local new_setting="$1"
    local settings_file="deneme.json"

    # Ensure the settings file exists
    if [[ ! -f "$settings_file" ]]; then
        echo "{}" > "$settings_file"
    fi

    # Read the current content, removing comments and unnecessary newlines
    local content
    content=$(grep -v '^//' "$settings_file" | tr -d '\n' | tr -d '\r')

    # Ensure the content starts with '{' and ends with '}' (valid JSON object)
    if [[ "$content" != \{* ]]; then
        content="{$content"
    fi
    if [[ "$content" != *\} ]]; then
        content="${content}}"
    fi

    # Remove the trailing brace to prepare for adding new settings
    content="${content%}}"

    # If the content is just `{`, it's empty; add the new setting directly
    if [[ "$content" == "{" ]]; then
        echo "{$new_setting}" > "$settings_file"
    else
        # Otherwise, append the new setting with a comma
        echo "${content},${new_setting}}" > "$settings_file"
    fi
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

# add_setting "$SET_EMAIL"
# add_setting "$SET_USERNAME"
add_setting "$SET_SAVE"
# add_setting "$SET_SPACE"
# add_setting "$SET_WHITESPACE"
# add_setting "$SET_NEWLINE"
# add_setting "$SET_TRIM"
# add_setting "$SET_MAKE"
# add_setting "$SET_FORMAT"
# add_setting "$SET_TERMINAL"
