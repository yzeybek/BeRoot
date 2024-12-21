#!/usr/bin/bash

# Path to the Docker daemon.json file
DAEMON_CONFIG_FILE="$HOME/.config/docker/daemon.json"

# Check if the file exists
if [ ! -f "$DAEMON_CONFIG_FILE" ]; then
    echo "File $DAEMON_CONFIG_FILE does not exist."
    exit 1
fi

# Use sed to replace the data-root value in the JSON file without creating a backup
sed -i "s|\"data-root\": \"/goinfre/$USER/docker/\"|\"data-root\": \"/sgoinfre/$USER/docker/\"|" "$DAEMON_CONFIG_FILE"

# Check if sed ran successfully
if [ $? -eq 0 ]; then
    echo "Updated data-root path in $DAEMON_CONFIG_FILE."
else
    echo "Failed to update $DAEMON_CONFIG_FILE"
    exit 1
fi

