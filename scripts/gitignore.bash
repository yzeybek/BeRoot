#!/usr/bin/bash

GITIGNORE_SCRIPT="$HOME/.config/Code/User/gitignore.bash"
mkdir -p "$(dirname "$GITIGNORE_SCRIPT")"

cat << 'EOF' > "$GITIGNORE_SCRIPT"
#!/usr/bin/bash

gitignore_file=\".gitignore\"
gitignore_content=\"# Add Yours here

# General
a.out

test
data
.vscode

.DS_Store
.gitignore

**/*.o
*.o

**/*.swp
*.swp

**/*.d
*.d

*.bak
**/*.bak
"

echo "$gitignore_content" > "$gitignore_file"
EOF

chmod +x "$GITIGNORE_SCRIPT"
