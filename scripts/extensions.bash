#!/usr/bin/bash

add_extension() {
    local extension=$1

    if ! command -v code &> /dev/null; then
        echo "Error: 'code' command is not available. Ensure VSCode is installed and 'code' is added to PATH."
        return 1
    fi

    if code --list-extensions | grep -q "^${extension}$"; then
        echo "Extension '${extension}' is already installed."
        return 0
    fi

    echo "Installing extension '${extension}'..."
    code --install-extension "$extension" --force

    if code --list-extensions | grep -q "^${extension}$"; then
        echo "Extension '${extension}' installed successfully."
    else
        echo "Error: Failed to install extension '${extension}'."
        return 1
    fi
}

EXT_C="ms-vscode.cpptools"
EXT_MAKE="ms-vscode.makefile-tools"
EXT_DOCKER="ms-azuretools.vscode-docker"
EXT_CONTAINER="ms-vscode-remote.remote-containers"
EXT_TODO="gruntfuggly.todo-tree"
EXT_COUNT="dokca.42-ft-count-line"
EXT_NORM="evilcat.norminette-42"
EXT_HEAD="kube.42header"
EXT_FORMAT="keyhr.42-c-format"
EXT_LAUNCH='arturodent.launch-config'

add_extension "$EXT_C"
add_extension "$EXT_MAKE"
add_extension "$EXT_DOCKER"
add_extension "$EXT_CONTAINER"
add_extension "$EXT_TODO"
add_extension "$EXT_COUNT"
add_extension "$EXT_NORM"
add_extension "$EXT_HEAD"
add_extension "$EXT_FORMAT"
add_extension "$EXT_LAUNCH"
