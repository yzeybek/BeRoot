#!/usr/bin/bash

PROFILE_ID=${gsettings get org.gnome.Terminal.ProfilesList default | sed "s/'//g"}

gnome-extensions enable ubuntu-dock@ubuntu.com
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com

#gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
#gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
#gsettings set org.gnome.desktop.interface icon-theme 'Yaru'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ use-custom-command true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ custom-command 'docker exec -it BeRoot /usr/bin/bash'
#gsettings set org.gnome.shell.extensions.ding show-home false
#gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true

#echo 'xrandr --output eDP --mode 3200x1800' > ~/.profile
