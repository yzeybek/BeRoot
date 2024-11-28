#!/usr/bin/bash

DIR="/usr/share/applications"
SCRIPT="$HOME/BeRoot/desktop/converter.bash"
MTIME=-0.000694

while true; do
    find "$DIR" -name "*.desktop" -mtime $MTIME
    if [ $? -eq 0 ]; then
        bash $SCRIPT
    fi
    sleep 5
done
