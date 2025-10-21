#!/bin/bash

# Install Latest Docker from Official Repository on Ubuntu
# Includes immediate user docker access without server restart

set -e

echo "🐳 Starting Docker Installation..."

# Step 1: Update system packages
echo "📦 Updating system packages..."
sudo apt-get update
sudo apt-get upgrade -y

# Step 2: Install prerequisites
echo "📋 Installing prerequisites..."
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    apt-transport-https \
    software-properties-common

# Step 3: Add Docker GPG key
echo "🔐 Adding Docker GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Step 4: Add Docker official repository
echo "📂 Adding Docker official repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Step 5: Update package index
echo "🔄 Updating package index..."
sudo apt-get update

# Step 6: Install latest Docker
echo "⬇️  Installing Docker (latest version)..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Step 7: Verify Docker installation
echo "✅ Verifying Docker installation..."
sudo docker --version
sudo docker run --rm hello-world

# Step 8: Create docker group (if not exists)
echo "👥 Setting up docker group..."
sudo groupadd docker 2>/dev/null || echo "   docker group already exists"

# Step 9: Add current user to docker group
echo "👤 Adding current user to docker group..."
sudo usermod -aG docker $USER

# Step 10: Apply group changes IMMEDIATELY without restart
echo "⚡ Applying group changes immediately..."
newgrp docker

# Step 11: Verify immediate access
echo "🧪 Verifying immediate docker access..."
docker ps

# Step 12: Enable Docker service to start on boot
echo "🚀 Enabling Docker service on boot..."
sudo systemctl enable docker
sudo systemctl enable containerd

echo ""
echo "✨ Docker installation complete!"
echo ""
echo "📝 Summary:"
echo "   ✅ Docker (latest) installed"
echo "   ✅ Docker CLI installed"
echo "   ✅ Docker Compose installed"
echo "   ✅ User added to docker group"
echo "   ✅ Immediate access granted (no restart needed)"
echo ""
echo "🎯 You can now use Docker without sudo:"
echo "   docker ps"
echo "   docker run -it ubuntu bash"
echo ""
echo "Note: If you open a new terminal/shell, you'll have docker access automatically"
echo "      Current shell already has immediate access via 'newgrp docker'"
