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
&& code --no-sandbox --user-data-dir="/root/.config/Code" --install-extension "keyhr.42-c-format" --force \
&& python3 -m pip config set global.break-system-packages true \
&& pip3 install c_formatter_42

# Francinette
python3 -m pip config set global.break-system-packages true \
&& bash -c "$(curl -fsSL https://raw.github.com/xicodomingues/francinette/master/bin/install.sh)"

# Norminette
pipx install norminette \
&& pipx ensurepath

# Brave
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"| tee /etc/apt/sources.list.d/brave-browser-release.list \
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
' | tee /etc/apt/preferences.d/mozillateamppa \
&& apt install thunderbird -y

# Chrome
wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub \
&& gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub \
&& echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list \
&& apt update \
&& apt install google-chrome-stable -y

# Libre Office
apt install libreoffice -y

# Gimp
apt install gimp -y

# Minecraft
mkdir -p "$HOME/Minecraft" \
&& curl https://dl2.tlauncher.org/f.php?f=files%2FTLauncher.v11.zip -o "$HOME/Minecraft/TLauncher.v11.zip" \
&& mkdir -p "$HOME/.local/share/icons" \
&& curl https://raw.githubusercontent.com/yzeybek/BeRoot/refs/heads/main/assets/icons/minecraft.png -o "$HOME/Minecraft/minecraft.png" \
&& unzip "$HOME/Minecraft/TLauncher.v11.zip" -d "$HOME/Minecraft" \
&& rm -rf "$HOME/Minecraft/TLauncher.v11.zip" "$HOME/Minecraft/README-EN.txt" "$HOME/Minecraft/README-RUS.txt" \
&& echo "[Desktop Entry]
Name=Minecraft TLauncher
Comment=Launch Minecraft via TLauncher
Exec=sudo java -jar $HOME/Minecraft/TLauncher.jar
Icon=$HOME/Minecraft/minecraft.png
Terminal=false
Type=Application
Categories=Game;" > "$HOME/.local/share/applications/minecraft.desktop" \
&& update-desktop-database ~/.local/share/applications

# Spotify

# Slack
