#!/usr/bin/bash

TASKS_FILE="$HOME/.config/Code/User/tasks.json"
mkdir -p "$(dirname "$TASKS_FILE")"

cat << 'EOF' > "$TASKS_FILE"
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Add .gitignore",
            "type": "shell",
            "command": "~/.config/Code/User/gitignore.bash",
            "presentation": {
                "reveal": "never"
            },
            "problemMatcher": []
        },
        {
            "label": "Setup and Build",
            "type": "shell",
            "command": "bash",
            "args": [
                "-c",
                "mkdir -p .vscode/launch.json \
                && touch .vscode/launch.json \
                && cp ~/.config/Code/User/launch.json .vscode/launch.json \
                && mkdir -p debug \
                && gcc -Wall -Wextra -Werror -g $(find . -type f -name \"*.c\" ! -path \"./test/*\" ! -path \"./data/*\" ! -path \"./Debug/*\" ! -path \"./build/*\") -I . -o debug/debug \
                && code --command launches.C_Debug"
            ],
            "presentation": {
                "reveal": "always",
                "panel": "shared"
            },
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "problemMatcher": "$gcc",
            "detail": "Compiles all C files under the workspace and excludes certain folders."
        }
    ]
}
EOF
