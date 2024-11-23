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

KEY_C='{"key": "meta+c","command": "workbench.action.terminal.copySelection","when": "terminalTextSelectedInFocused || terminalFocus && terminalHasBeenCreated && terminalTextSelected || terminalFocus && terminalProcessSupported && terminalTextSelected || terminalFocus && terminalTextSelected && terminalTextSelectedInFocused || terminalHasBeenCreated && terminalTextSelected && terminalTextSelectedInFocused || terminalProcessSupported && terminalTextSelected && terminalTextSelectedInFocused"}'
KEY_C_REMOVE='{"key": "ctrl+shift+c","command": "-workbench.action.terminal.copySelection","when": "terminalTextSelectedInFocused || terminalFocus && terminalHasBeenCreated && terminalTextSelected || terminalFocus && terminalProcessSupported && terminalTextSelected || terminalFocus && terminalTextSelected && terminalTextSelectedInFocused || terminalHasBeenCreated && terminalTextSelected && terminalTextSelectedInFocused || terminalProcessSupported && terminalTextSelected && terminalTextSelectedInFocused"}'
KEY_V='{"key": "meta+v","command": "workbench.action.terminal.paste","when": "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported"}'
KEY_V_REMOVE='{"key": "ctrl+shift+v","command": "-workbench.action.terminal.paste","when": "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported"}'
KEY_GITIGNORE='{"key": "meta+shift+g","command": "workbench.action.tasks.runTask","args": "Add .gitignore"}'
KEY_C_DEBUG='{"key": "meta+shift+d","command": "launches.C_Debug"}'

add_keybinding "$KEY_C"
add_keybinding "$KEY_C_REMOVE"
add_keybinding "$KEY_V"
add_keybinding "$KEY_V_REMOVE"
add_keybinding "$KEY_GITIGNORE"
add_keybinding "$KEY_C_DEBUG"
