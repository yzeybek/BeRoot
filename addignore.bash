#!/usr/bin/bash

echo "alias addignore=\"echo '# Add Yours here


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
**/*.swp
' > .gitignore\"" >> ~/.bashrc

echo "alias addignore=\"echo '# Add Yours here


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
**/*.swp
' > .gitignore\"" >> ~/.zshrc

source ~/.bashrc
source ~/.zshrc
