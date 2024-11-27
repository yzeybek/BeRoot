#!/usr/bin/bash

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
&& install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \
&& echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list > /dev/null \
&& rm -f packages.microsoft.gpg \
&& apt install apt-transport-https -y \
&& apt update -y \
&& apt install code -y

curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list \
&& apt update \
&& apt install brave-browser -y

code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "ms-vscode.cpptools" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "ms-vscode.makefile-tools" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "ms-azuretools.vscode-docker" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "ms-vscode-remote.remote-containers" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "gruntfuggly.todo-tree" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "dokca.42-ft-count-line" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "evilcat.norminette-42" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "kube.42header" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "keyhr.42-c-format" --force

