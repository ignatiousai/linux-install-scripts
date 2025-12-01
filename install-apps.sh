#!/bin/bash

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "🎬 Installing VLC..."
sudo apt install -y vlc

echo "🖥️ Installing AnyDesk..."
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk.list
sudo apt update
sudo apt install -y anydesk

echo "📥 Downloading Rustdesk latest .deb package..."
cd ~/Downloads
LATEST_DEB=$(curl -s https://api.github.com/repos/rustdesk/rustdesk/releases/latest \
  | grep browser_download_url \
  | grep '.deb"' \
  | cut -d '"' -f 4)

wget "$LATEST_DEB"

echo "📦 Installing Rustdesk..."
sudo apt install -y ./*.deb

echo "✅ All apps installed successfully!"
