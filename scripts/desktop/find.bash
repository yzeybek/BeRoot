#!/usr/bin/bash

DIR="/usr/share/applications"
SCRIPT="$HOME/BeRoot/scripts/desktop/converter.bash"

FILE=$(find "$DIR" -name -type f -exec ls -lt --time-style=+%s {} + | sort -k6,6nr | head -n 1)
if [ -n "${FILE}" ]; then
   bash $SCRIPT ${FILE}
fi
    
