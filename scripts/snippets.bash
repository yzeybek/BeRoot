#!/usr/bin/bash

mkdir -p "$HOME/.config/Code/User/snippets"

GITIGNORE="$HOME/.config/Code/User/snippets/gitignore.code-snippets"
cat << 'EOF' > "$GITIGNORE"
{
  "Gitignore custom template": {
    "prefix": "gitignore",  // Trigger for the snippet
    "body": [
      "# Add Yours here",
      "",
      "# General",
      "a.out",
      "",
      "test/",
      "tests/",
      "data/",
      "build/",
      "dist/",
      ".vscode/",
      "",
      ".DS_Store",
      ".gitignore",
      "",
      "**/*.o",
      "*.o",
      "",
      "**/*.swp",
      "*.swp",
      "",
      "**/*.swo",
      "*.swo",
      "",
      "**/*.tmp",
      "*.tmp",
      "",
      "**/*.d",
      "*.d",
      "",
      "**/*.bak",
      "*.bak",
      "",
      "**/*.log",
      "*.log"
    ],
    "description": "Custom .gitignore template for general use"
  }
}
EOF
