#!/usr/bin/bash

# Variables
IMAGE_REPO="yzeybek/beroot"
CONTAINER_NAME="BeRoot"
REPO_DIR="$HOME/BeRoot"

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
	# Pull Image
	docker pull $IMAGE_REPO

	# Run Container
	docker run -dit --restart=always --name $CONTAINER_NAME --privileged --device /dev/dri -e DISPLAY=$DISPLAY -e REPO_DIR=$REPO_DIR \
	-v $HOME:/root \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $HOME/.local/share/icons:/usr/share/icons \
	-v $HOME/.local/share/applications:/usr/share/applications \
	-v /goinfre/$USER:/goinfre/root \
	-v /sgoinfre/$USER:/sgoinfre/root \
	-v $HOME/.local/share/icons:/usr/share/pixmaps \
	$IMAGE_REPO

	# Install norminette and francinette
	docker exec -it $CONTAINER_NAME bash -c 'pipx install norminette \
											&& pipx ensurepath \
											&& python3 -m pip config set global.break-system-packages true \
											&& echo "APT::Get::Assume-Yes "true";" > /etc/apt/apt.conf.d/BeRoot_yes \
											&& curl -fsSL https://raw.github.com/xicodomingues/francinette/master/bin/install.sh | sed "$d;$d;$d" | bash \
											&& rm -f /etc/apt/apt.conf.d/BeRoot_yes'

	# Setup Terminal
	profile_id="$(gsettings get org.gnome.Terminal.ProfilesList default | sed "s/'//g")"
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile_id/ use-custom-command true
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile_id/ custom-command 'docker exec -it BeRoot bash'

	# Setup Converter
	gnome-extensions enable ubuntu-dock@ubuntu.com
	gnome-extensions enable dash-to-dock@micxgx.gmail.com

	mkdir -p $REPO_DIR

echo '
#!/usr/bin/bash

APPLICATIONS_DIR="$HOME/.local/share/applications"
FILES_TXT="$APPLICATIONS_DIR/.files.txt"

touch "$FILES_TXT"

if [[ -f "$FILES_TXT" ]]; then
    mapfile -t previous_files < "$FILES_TXT"
else
    previous_files=()
fi

mapfile -t current_files < <(find "$APPLICATIONS_DIR" -maxdepth 1 -name "*.desktop")

new_files=()
for file in "${current_files[@]}"; do
    if [[ ! " ${previous_files[@]} " =~ " $file " ]]; then
        new_files+=("$file")
    fi
done

for file in "${new_files[@]}"; do
    echo "Processing: $file"
    temp_file="${file}.tmp"

    while IFS= read -r line; do
        if [[ "$line" =~ ^Exec=(.*) ]]; then
            original_exec="${BASH_REMATCH[1]}"
            modified_exec="Exec=bash -c \"docker exec -dit BeRoot $original_exec --no-sandbox\""
            echo "$modified_exec" >> "$temp_file"
        else
            echo "$line" >> "$temp_file"
        fi
    done < "$file"

    mv "$temp_file" "$file"
    echo "Updated: $file"
done

find "$APPLICATIONS_DIR" -maxdepth 1 -name "*.desktop" > "$FILES_TXT"
' > "$REPO_DIR/converter.bash"

docker exec -dit $CONTAINER_NAME bash -c 'echo "DPkg::Post-Invoke { \"bash /root/BeRoot/converter.bash\"; };" > /etc/apt/apt.conf.d/BeRoot_convert'
}

function menu {
  echo
  echo -e "Download Menu:\n"
  echo -e "1. VSCode"
  echo -e "2. Brave Browser"
  echo -e "3. Firefox"
  echo -e "4. Thunderbird"
  echo -e "5. Google Chrome"
  echo -e "6. LibreOffice"
  echo -e "7. GIMP"
  echo -e "8. Minecraft"
  echo -e "0. Exit menu."
  echo -en "\nEnter option: "

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
											&& curl https://raw.githubusercontent.com/yzeybek/BeRoot/refs/heads/main/minecraft.png -o '\$HOME/Minecraft/minecraft.png' \
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

clear
banner
setup
while [ 1 ]
do
  clear
  banner
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
  echo -en "\n\nHit any key to continue..."
  read -n 1 line
done
clear
