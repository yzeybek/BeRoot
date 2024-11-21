#!/usr/bin/bash

# Setup Docker
docker build -t Wroot .

docker run -it --restart-always \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $HOME:/root \
    Wroot

# Setup .gitignore Script
GITIGNORE_SCRIPT="$HOME/.config/Code/User/gitignore.bash"
mkdir -p "$(dirname "$IGNORE_SCRIPT")"

cat << 'EOF' > "$IGNORE_SCRIPT"
#!/usr/bin/bash

gitignore_file=".gitignore"
gitignore_content="# Add Yours here

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
**/*.swp"

if [ ! -f "$gitignore_file" ]; then
    echo "$gitignore_content" > "$gitignore_file"
fi
EOF

chmod +x "$IGNORE_SCRIPT"
