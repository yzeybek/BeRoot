#!/usr/bin/bash

TASKS_FILE=".vscode/launch.json"
mkdir -p "$(dirname "$TASKS_FILE")"

cat << 'EOF' > "$TASKS_FILE"
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Debug C Program",
            "type": "cppdbg",
            "request": "launch",
            "program": "${workspaceFolder}/Debug/debug",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ],
            "preLaunchTask": "Build and Debug C Files",
            "miDebuggerPath": "/usr/bin/gdb"
        }
    ]
}
EOF
