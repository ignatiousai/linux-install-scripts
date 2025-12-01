#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y vlc
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk.list
sudo apt update
sudo apt install -y anydesk
cd ~/Downloads
wget https://github.com/rustdesk/rustdesk/releases/latest/download/rustdesk.deb
sudo apt install -y ./rustdesk.deb
