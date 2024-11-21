#!/usr/bin/bash

# Setup Docker
docker build -t Wroot .

docker run -it --restart-always \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $HOME:/root \
    Wroot

# Setup Wignore
SCRIPT="$HOME/.config/Code/User/Wignore.bash"
mkdir -p "$(dirname "$SCRIPT")"

cat << 'EOF' > "$SCRIPT"
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

chmod +x "$SCRIPT"
