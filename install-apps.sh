#!/bin/bash

set -e  # stop on first error
DOWNLOAD_DIR="$HOME/Downloads"
mkdir -p "$DOWNLOAD_DIR"

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "🔧 Ensuring wget & curl are installed..."
sudo apt install -y wget curl

echo "🎬 Installing VLC..."
sudo apt install -y vlc

echo "🖥️ Installing AnyDesk..."
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo gpg --dearmor -o /etc/apt/keyrings/anydesk.gpg

echo "deb [signed-by=/etc/apt/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main" | \
  sudo tee /etc/apt/sources.list.d/anydesk.list

sudo apt update
sudo apt install -y anydesk

echo "📥 Downloading Rustdesk latest .deb package..."
cd "$DOWNLOAD_DIR"

LATEST_DEB=$(curl -s https://api.github.com/repos/rustdesk/rustdesk/releases/latest \
  | grep browser_download_url \
  | grep '.deb"' \
  | head -n 1 \
  | cut -d '"' -f 4)

if [ -z "$LATEST_DEB" ]; then
  echo "❌ Failed to find Rustdesk .deb URL — aborting."
  exit 1
fi

echo "📥 Downloading: $LATEST_DEB"
wget -O rustdesk.deb "$LATEST_DEB"

echo "📦 Installing Rustdesk..."
sudo apt install -y ./rustdesk.deb

echo "✅ All apps installed successfully!"


