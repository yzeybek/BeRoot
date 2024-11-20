#!/usr/bin/bash

docker build -t Wroot .

docker run -it --restart-always \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $HOME:/root \
    Wroot

