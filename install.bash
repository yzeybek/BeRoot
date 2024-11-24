#!/usr/bin/bash

# Variables
IMAGE_NAME="wroot"

# Setup Docker
docker build -t $IMAGE_NAME .

docker run -it --restart=always -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME:/root --device /dev/dri $IMAGE_NAME bash -c "

  GITIGNORE_SCRIPT=\"/root/.config/Code/User/gitignore.bash\"
  mkdir -p \"\$(dirname \"\$GITIGNORE_SCRIPT\")\"

  cat << 'EOF' > \"\$GITIGNORE_SCRIPT\"
#!/usr/bin/bash

gitignore_file=\".gitignore\"
gitignore_content=\"# Add Yours here

# General
a.out
.vscode
.DS_Store
main.c
test
data
.gitignore
**/*.o
*.o
*.swp
**/*.swp\"

echo \"\$gitignore_content\" > \"\$gitignore_file\"
EOF

  chmod +x \"\$GITIGNORE_SCRIPT\"

  bash /root/Wroot/scripts/extensions.bash
  bash /root/Wroot/scripts/settings.bash
  bash /root/Wroot/scripts/tasks.bash
  bash /root/Wroot/scripts/launchs.bash
  bash /root/Wroot/scripts/keybindings.bash
"

