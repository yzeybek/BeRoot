#!/usr/bin/bash

# Variables
IMAGE_NAME="wroot"

# Setup Docker
docker build -t $IMAGE_NAME $HOME/Wroot

docker run -dit --restart=always -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --name Wroot -v $HOME:/root -v $HOME/.local/share/applications:/usr/share/applications -v $HOME/.local/share/icons:/usr/share/icons --device /dev/dri $IMAGE_NAME 

#docker exec -dit Wroot bash $HOME/Wroot/setup.bash

GITIGNORE_SCRIPT="$HOME/.config/Code/User/gitignore.bash"
mkdir -p "$(dirname "$GITIGNORE_SCRIPT")"

cat << 'EOF' > "$GITIGNORE_SCRIPT"
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

echo "$gitignore_content" > "$gitignore_file"
EOF

chmod +x "$GITIGNORE_SCRIPT"

bash $HOME/Wroot/scripts/settings.bash
bash $HOME/Wroot/scripts/tasks.bash
bash $HOME/Wroot/scripts/launchs.bash
bash $HOME/Wroot/scripts/keybindings.bash

