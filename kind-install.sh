#!/usr/bin/env bash
# ============================================================
# ⚙️ install-kind.sh
# Installs the latest Kind (v0.30.0) on Ubuntu (AMD64 or ARM64)
# Automatically detects architecture and moves binary to /usr/local/bin
# ============================================================

set -e

KIND_VERSION="v0.30.0"
INSTALL_DIR="/usr/local/bin"
TMP_FILE="./kind"

echo "🔹 Detecting system architecture..."
ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
  echo "✅ AMD64 detected. Downloading Kind $KIND_VERSION..."
  curl -Lo "$TMP_FILE" "https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-amd64"
elif [ "$ARCH" = "aarch64" ]; then
  echo "✅ ARM64 detected. Downloading Kind $KIND_VERSION..."
  curl -Lo "$TMP_FILE" "https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-arm64"
else
  echo "❌ Unsupported architecture: $ARCH"
  exit 1
fi

echo "🔹 Making Kind binary executable..."
chmod +x "$TMP_FILE"

echo "🔹 Moving Kind to $INSTALL_DIR ..."
sudo mv "$TMP_FILE" "$INSTALL_DIR/kind"

echo "✅ Kind installation complete!"
echo
kind --version
echo
echo "🎯 You can now create a cluster with:"
echo "   kind create cluster --name demo-cluster"
echo "============================================================"
