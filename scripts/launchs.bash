#!/usr/bin/bash

LAUNCHS_FILE="$HOME/.config/Code/User/launch.json"
mkdir -p "$(dirname "$LAUNCHS_FILE")"

cat << 'EOF' > "$LAUNCHS_FILE"
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Debug C Files",
            "type": "cppdbg",
            "request": "launch",
            "program": "${workspaceFolder}/debug/debug",
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
            "miDebuggerPath": "/usr/bin/gdb"
        }
    ]
}
EOF
