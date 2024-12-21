#!/usr/bin/bash

# Variables
IMAGE_REPO="yzeybek/beroot"
IMAGE_DIR="$HOME/BeRoot"
CONTAINER_NAME="BeRoot"

function banner {
	echo "
	██████╗ ███████╗██████╗  ██████╗  ██████╗ ████████╗
	██╔══██╗██╔════╝██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝
	██████╔╝█████╗  ██████╔╝██║   ██║██║   ██║   ██║
	██╔══██╗██╔══╝  ██╔══██╗██║   ██║██║   ██║   ██║
	██████╔╝███████╗██║  ██║╚██████╔╝╚██████╔╝   ██║
	╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝    ╚═╝

	"
}

function setup {
	# Setup Config Updater
	cat <<EOL > ~/.config/autostart/update-docker-config.desktop
[Desktop Entry]
Type=Application
Exec=$HOME/BeRoot/docker_config_updater.bash
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Update Docker Config
Comment=Updates Docker daemon.json at login
EOL

	# Pull Image
	docker pull $IMAGE_REPO

	# Run Container
	docker run -dit --restart=always --name $CONTAINER_NAME --privileged --device /dev/dri --env DISPLAY=$DISPLAY \
	-v $HOME:/root \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $HOME/.local/share/icons:/usr/share/icons \
	-v $HOME/.local/share/applications:/usr/share/applications \
	-v /goinfre/$USER:/goinfre/root \
	$IMAGE_REPO

	# Install norminette and francinette
	docker exec -it $CONTAINER_NAME bash -c 'pipx install norminette \
											&& pipx ensurepath \
											&& python3 -m pip config set global.break-system-packages true \
											&& echo "APT::Get::Assume-Yes "true";" > /etc/apt/apt.conf.d/BeRoot_yes \
											&& curl -fsSL https://raw.github.com/xicodomingues/francinette/master/bin/install.sh | sed "$d;$d;$d" | bash \
											&& rm -f /etc/apt/apt.conf.d/BeRoot_yes'

	# Setup Terminal
	profile_id="${gsettings get org.gnome.Terminal.ProfilesList default | sed "s/'//g"}"
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile_id/ use-custom-command true
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile_id/ custom-command 'docker exec -it BeRoot bash'

	# Setup Converter
	gnome-extensions enable ubuntu-dock@ubuntu.com
	gnome-extensions enable dash-to-dock@micxgx.gmail.com
	wget https://raw.githubusercontent.com/yzeybek/BeRoot/refs/heads/main/scripts/converter.bash -P $HOME/
	docker exec -dit $CONTAINER_NAME bash -c 'echo "DPkg::Post-Invoke { \"/root/converter.bash\"; };" > /etc/apt/apt.conf.d/BeRoot_convert'
}

function menu {
  echo
  echo -e "\t\t\t Download Menu:\n"
  echo -e "\t1. VSCode"
  echo -e "\t2. Brave Browser"
  echo -e "\t3. Firefox"
  echo -e "\t3. Thunderbird"
  echo -e "\t3. Google Chrome"
  echo -e "\t3. LibreOffice"
  echo -e "\t3. GIMP"
  echo -e "\t3. Minecraft"
  echo -e "\t0. Exit menu."
  echo -en "\t\t Enter option: "

  read -n 1 option
}

function vscode {
	docker exec -it $CONTAINER_NAME bash -c "wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
											&& install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \
											&& echo 'deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' | tee /etc/apt/sources.list.d/vscode.list > /dev/null \
											&& rm -f packages.microsoft.gpg \
											&& apt install apt-transport-https -y \
											&& apt update -y \
											&& apt install code -y \
											&& code --no-sandbox --user-data-dir='/root/.config/Code' --install-extension 'ms-vscode.cpptools' --force \
											&& code --no-sandbox --user-data-dir='/root/.config/Code' --install-extension 'ms-vscode.makefile-tools' --force \
											&& code --no-sandbox --user-data-dir='/root/.config/Code' --install-extension 'ms-azuretools.vscode-docker' --force \
											&& code --no-sandbox --user-data-dir='/root/.config/Code' --install-extension 'ms-vscode-remote.remote-containers' --force \
											&& code --no-sandbox --user-data-dir='/root/.config/Code' --install-extension 'gruntfuggly.todo-tree' --force \
											&& code --no-sandbox --user-data-dir='/root/.config/Code' --install-extension 'dokca.42-ft-count-line' --force \
											&& code --no-sandbox --user-data-dir='/root/.config/Code' --install-extension 'evilcat.norminette-42' --force \
											&& code --no-sandbox --user-data-dir='/root/.config/Code' --install-extension 'kube.42header' --force \
											&& code --no-sandbox --user-data-dir='/root/.config/Code' --install-extension 'keyhr.42-c-format' --force \
											&& python3 -m pip config set global.break-system-packages true \
											&& pip3 install c_formatter_42"
}

function brave {
	docker exec -it $CONTAINER_NAME bash -c "curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
											&& echo 'deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main'| tee /etc/apt/sources.list.d/brave-browser-release.list \
											&& apt update \
											&& apt install brave-browser -y"
}

function firefox {
	docker exec -it $CONTAINER_NAME bash -c "install -d -m 0755 /etc/apt/keyrings \
											&& wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null \
											&& gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,\"\"); if(\$0 == \"35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3\") print \"\nThe key fingerprint matches (\"\$0\").\n\"; else print \"\nVerification failed: the fingerprint (\"\$0\") does not match the expected one.\n\"}' \
											&& echo 'deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main' | tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null \
&& echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | tee /etc/apt/preferences.d/mozilla \
											&& apt update \
											&& apt install firefox -y"
}

function thunderbird {
	docker exec -it $CONTAINER_NAME bash -c "add-apt-repository ppa:mozillateam/ppa \
&& echo '
Package: thunderbird*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | tee /etc/apt/preferences.d/mozillateamppa \
											&& apt install thunderbird -y"
}

function chrome {
	docker exec -it $CONTAINER_NAME bash -c "wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub \
											&& gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub \
											&& echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list \
											&& apt update \
											&& apt install google-chrome-stable -y"
}

function libreoffice {
	docker exec -it $CONTAINER_NAME bash -c "apt install libreoffice -y"
}

function gimp {
	docker exec -it $CONTAINER_NAME bash -c "apt install gimp -y"
}

function minecraft {
	docker exec -it $CONTAINER_NAME bash -c "mkdir -p '$\HOME/Minecraft' \
											&& curl https://dl2.tlauncher.org/f.php?f=files%2FTLauncher.v11.zip -o '\$HOME/Minecraft/TLauncher.v11.zip' \
											&& mkdir -p '\$HOME/.local/share/icons' \
											&& curl https://raw.githubusercontent.com/yzeybek/BeRoot/refs/heads/main/assets/minecraft.png -o '\$HOME/Minecraft/minecraft.png' \
											&& unzip '\$HOME/Minecraft/TLauncher.v11.zip' -d '\$HOME/Minecraft' \
											&& rm -rf '\$HOME/Minecraft/TLauncher.v11.zip' '\$HOME/Minecraft/README-EN.txt' '\$HOME/Minecraft/README-RUS.txt' \
&& echo '[Desktop Entry]
Name=Minecraft TLauncher
Comment=Launch Minecraft via TLauncher
Exec=bash -c 'docker exec -dit BeRoot java -jar \$HOME/Minecraft/TLauncher.jar'
Icon=\$HOME/Minecraft/minecraft.png
Terminal=false
Type=Application
Categories=Game;' > '\$HOME/.local/share/applications/minecraft.desktop' \
											&& update-desktop-database ~/.local/share/applications"
}

banner
setup
while [ 1 ]
do
  menu
  case $option in
    0)
      break ;;
    1)
      vscode ;;
    2)
      brave ;;
    3)
      firefox ;;
	4)
	  thunderbird ;;
	5)
      chrome ;;
	6)
      libreoffice ;;
	7)
      gimp ;;
	8)
      minecraft ;;
    *)
      clear
      echo "That isn't a valid option."
  esac
  echo -en "\n\n\t\t Hit any key to continue..."
  read -n 1 line
done
clear
