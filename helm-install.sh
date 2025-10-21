#!/bin/bash

# Install Helm from Official Repository
# Helm is the package manager for Kubernetes

set -e

echo "📦 Starting Helm Installation from Official Repository..."

# Step 1: Download Helm installation script from official repository
echo "⬇️  Downloading Helm installation script from official repository..."
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

# Step 2: Make the script executable
echo "🔐 Making script executable..."
chmod 700 get_helm.sh

# Step 3: Run the installation script
echo "🚀 Running Helm installation..."
./get_helm.sh

# Step 4: Cleanup - remove the installation script
echo "🧹 Cleaning up installation script..."
rm -f get_helm.sh

# Step 5: Verify Helm installation
echo "✅ Verifying Helm installation..."
helm version

# Step 6: Add Helm bash completion (optional but recommended)
echo "⚡ Setting up Helm bash completion..."
helm completion bash | sudo tee /etc/bash_completion.d/helm > /dev/null
echo "source /etc/bash_completion.d/helm" >> ~/.bashrc

# Step 7: Test Helm
echo "🧪 Testing Helm..."
helm help | head -20

echo ""
echo "✨ Helm installation complete!"
echo ""
echo "📝 Summary:"
echo "   ✅ Helm (latest) installed from official repository"
echo "   ✅ Bash completion configured"
echo ""
echo "🎯 Verify installation:"
echo "   helm version"
echo "   helm repo list"
echo "   helm search repo"
