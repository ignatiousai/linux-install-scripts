#!/bin/bash

set -e  # stop on first error

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "🎬 Installing VLC..."
sudo apt install -y vlc

echo "🖥️ Installing AnyDesk..."
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk.list
sudo apt update
sudo apt install -y anydesk

echo "🔧 Ensuring curl is installed..."
if ! command -v curl >/dev/null 2>&1; then
  sudo apt install -y curl
fi

echo "📥 Downloading Rustdesk latest .deb package..."
# Download into your user's home downloads folder
DOWNLOAD_DIR="$HOME/Downloads"
mkdir -p "$DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR"

LATEST_DEB=$(curl -s https://api.github.com/repos/rustdesk/rustdesk/releases/latest \
  | grep browser_download_url \
  | grep '.deb"' \
  | cut -d '"' -f 4)

if [ -z "$LATEST_DEB" ]; then
  echo "❌ Failed to find Rustdesk .deb URL — aborting."
  exit 1
fi

wget "$LATEST_DEB" -O rustdesk.deb

echo "📦 Installing Rustdesk..."
sudo apt install -y ./rustdesk.deb

echo "✅ All apps installed successfully!"

