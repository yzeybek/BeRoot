#!/usr/bin/bash

add_keybinding() {
    local new_keybinding="$1"
    local keybindings_file="~/.config/Code/User/keybindings.json"

    if [[ ! -f "$keybindings_file" ]]; then
        echo "[]" > "$keybindings_file"
    fi

    local content
    content=$(grep -v '^//' "$keybindings_file" | tr -d '\n' | tr -d '\r')

    content=$(echo "$content" | tr -d '\n' | tr -d '\r')

    if [[ "$content" == "[]" ]]; then
        echo "[$new_keybinding]" > "$keybindings_file"
    else
        if [[ "$content" =~ \]$ ]]; then
            content="${content%?}"
            echo "$content,$new_keybinding]" > "$keybindings_file"
        else
            echo "$content$new_keybinding]" > "$keybindings_file"
        fi
    fi
}

KEY_C='{"key": "meta+c","command": "workbench.action.terminal.copySelection","when": "terminalTextSelectedInFocused || terminalFocus && terminalHasBeenCreated && terminalTextSelected || terminalFocus && terminalProcessSupported && terminalTextSelected || terminalFocus && terminalTextSelected && terminalTextSelectedInFocused || terminalHasBeenCreated && terminalTextSelected && terminalTextSelectedInFocused || terminalProcessSupported && terminalTextSelected && terminalTextSelectedInFocused"}'
KEY_C_REMOVE='{"key": "ctrl+shift+c","command": "-workbench.action.terminal.copySelection","when": "terminalTextSelectedInFocused || terminalFocus && terminalHasBeenCreated && terminalTextSelected || terminalFocus && terminalProcessSupported && terminalTextSelected || terminalFocus && terminalTextSelected && terminalTextSelectedInFocused || terminalHasBeenCreated && terminalTextSelected && terminalTextSelectedInFocused || terminalProcessSupported && terminalTextSelected && terminalTextSelectedInFocused"}'

KEY_V='{"key": "meta+v","command": "workbench.action.terminal.paste","when": "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported"}'
KEY_V_REMOVE='{"key": "ctrl+shift+v","command": "-workbench.action.terminal.paste","when": "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported"}'

KEY_ADD='{"key": "meta+g","command": "workbench.action.terminal.sendSequence","args": {"text": "addignore\u000D"}}'

add_keybinding "$KEY_C"
add_keybinding "$KEY_C_REMOVE"
add_keybinding "$KEY_V"
add_keybinding "$KEY_V_REMOVE"
add_keybinding "$KEY_ADD"
