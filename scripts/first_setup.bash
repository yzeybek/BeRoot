#!/usr/bin/bash

gnome-extensions enable ubuntu-dock@ubuntu.com
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com                         
gsettings set org.gnome.desktop.interface icon-theme 'Yaru'
PROFILE_ID=${gsettings get org.gnome.Terminal.ProfilesList default | sed "s/'//g"}
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ use-custom-command true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ custom-command '/usr/bin/bash'
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true
nmcli connection down "Wired connection 2"

