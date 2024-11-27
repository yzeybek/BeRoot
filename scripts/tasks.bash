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
        }
    ]
}
EOF
