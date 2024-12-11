#!/usr/bin/bash

# Clean Up
rm -rf "$HOME/BeRoot"

# Variables
IMAGE_REPO="yzeybek/beroot:1.0.0"
IMAGE_DIR="$HOME/BeRoot"
CONTAINER_NAME="BeRoot"

# Pull Image
docker pull $IMAGE_REPO

# Run Container
docker run -dit --restart=always --name $CONTAINER_NAME --privileged --device /dev/dri --env DISPLAY=$DISPLAY \
-v $HOME:/root \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v $HOME/.local/share/icons:/usr/share/icons \
-v $HOME/.local/share/applications:/usr/share/applications \
$IMAGE_REPO

# Install norminette and francinette
docker exec -it $CONTAINER_NAME bash -c 'pipx install norminette \
										&& pipx ensurepath \
										&& python3 -m pip config set global.break-system-packages true \
										&& bash -c "$(curl -fsSL https://raw.github.com/xicodomingues/francinette/master/bin/install.sh)"'

# Setup Terminal
profile_id=${gsettings get org.gnome.Terminal.ProfilesList default | sed "s/'//g"}
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile_id/ use-custom-command true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile_id/ custom-command 'docker exec -it BeRoot bash'

# Setup Converter
gnome-extensions enable ubuntu-dock@ubuntu.com
gnome-extensions enable dash-to-dock@micxgx.gmail.com
docker exec -dit $CONTAINER_NAME bash -c 'echo "DPkg::Post-Invoke { \"/root/BeRoot/scripts/converter.bash\"; };" > /etc/apt/apt.conf.d/BeRoot_convert'

# Download Apps
docker exec -it $CONTAINER_NAME bash -c 'bash /root/BeRoot/scripts/downloads.bash'
