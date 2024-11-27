#!/usr/bin/bash

# VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
&& install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \
&& echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list > /dev/null \
&& rm -f packages.microsoft.gpg \
&& apt install apt-transport-https -y \
&& apt update -y \
&& apt install code -y

# Extensions
code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "ms-vscode.cpptools" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "ms-vscode.makefile-tools" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "ms-azuretools.vscode-docker" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "ms-vscode-remote.remote-containers" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "gruntfuggly.todo-tree" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "dokca.42-ft-count-line" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "evilcat.norminette-42" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "kube.42header" --force \
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "keyhr.42-c-format" --force

# Brave
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list \
&& apt update \
&& apt install brave-browser -y

# Firefox
install -d -m 0755 /etc/apt/keyrings \
&& wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null \
&& gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}' \
&& echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null \
&& echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | tee /etc/apt/preferences.d/mozilla \
&& apt update \
&& apt install firefox -y

# Thunderbird
add-apt-repository ppa:mozillateam/ppa \
&& echo '
Package: thunderbird*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozillateamppa \
&& apt install thunderbird -y

# Chrome

# Spotify

# Slack

# Libre Office

# Gimp
