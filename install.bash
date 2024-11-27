#!/usr/bin/bash

# Variables
IMAGE_NAME="beroot"
IMAGE_DIR="$HOME/beroot"
CONTAINER_NAME="BeRoot"

# Build Docker
docker build -t $IMAGE_NAME $IMAGE_DIR

docker run -dit --restart=always --name $CONTAINER_NAME --privileged --device /dev/dri --env DISPLAY=$DISPLAY \
-v $HOME:/root \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v $HOME/.local/share/icons:/usr/share/icons \
-v $HOME/.local/share/applications:/usr/share/applications \
$IMAGE_NAME

docker exec -it $CONTAINER_NAME bash -c 'bash $HOME/BeRoot/scripts/downloads.bash'

bash $IMAGE_DIR/scripts/basics.bash
bash $IMAGE_DIR/scripts/gitignore.bash
bash $IMAGE_DIR/scripts/settings.bash
bash $IMAGE_DIR/scripts/tasks.bash
bash $IMAGE_DIR/scripts/keybindings.bash

