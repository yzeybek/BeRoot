#!/usr/bin/bash

add_keybinding() {
    local new_keybinding=$1
    local keybindings_file="$HOME/.config/Code/User/keybindings.json"

    mkdir -p "$(dirname "$keybindings_file")"
    touch "$keybindings_file"

    if [ ! -s "$keybindings_file" ]; then
        echo -e "[\n    $new_keybinding\n]" > "$keybindings_file"
        return
    fi

    local current_content
    current_content=$(cat "$keybindings_file" | jq .)

    if [ "$current_content" == "null" ]; then
        echo -e "[\n    $new_keybinding\n]" > "$keybindings_file"
        return
    fi

    local updated_content
    updated_content=$(echo "$current_content" | jq ". + [$new_keybinding]")

    echo "$updated_content" | jq . > "$keybindings_file"
}

KEY_C='{"key": "meta+c","command": "workbench.action.terminal.copySelection","when": "terminalTextSelectedInFocused || terminalFocus && terminalHasBeenCreated && terminalTextSelected || terminalFocus && terminalProcessSupported && terminalTextSelected || terminalFocus && terminalTextSelected && terminalTextSelectedInFocused || terminalHasBeenCreated && terminalTextSelected && terminalTextSelectedInFocused || terminalProcessSupported && terminalTextSelected && terminalTextSelectedInFocused"}'
KEY_C_REMOVE='{"key": "ctrl+shift+c","command": "-workbench.action.terminal.copySelection","when": "terminalTextSelectedInFocused || terminalFocus && terminalHasBeenCreated && terminalTextSelected || terminalFocus && terminalProcessSupported && terminalTextSelected || terminalFocus && terminalTextSelected && terminalTextSelectedInFocused || terminalHasBeenCreated && terminalTextSelected && terminalTextSelectedInFocused || terminalProcessSupported && terminalTextSelected && terminalTextSelectedInFocused"}'

KEY_V='{"key": "meta+v","command": "workbench.action.terminal.paste","when": "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported"}'
KEY_V_REMOVE='{"key": "ctrl+shift+v","command": "-workbench.action.terminal.paste","when": "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported"}'

KEY_WIGNORE='{"key": "meta+g","command": "workbench.action.tasks.runTask","args": "Wignore"}'

KEY_WDEBUG='{"key": "meta+b","command": "workbench.action.tasks.runTask","args": "Wdebug"}'

add_keybinding "$KEY_C"
add_keybinding "$KEY_C_REMOVE"
add_keybinding "$KEY_V"
add_keybinding "$KEY_V_REMOVE"
add_keybinding "$KEY_WIGNORE"
