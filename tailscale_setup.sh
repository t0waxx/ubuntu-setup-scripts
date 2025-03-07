#!/bin/bash

echo "Tailscale Setup Script"

# Check if Tailscale is already installed
if command -v tailscale &>/dev/null; then
  echo "Tailscale is already installed."
  read -rp "Do you want to reinstall Tailscale? (y/N): " REINSTALL
  if [[ "$REINSTALL" != "y" && "$REINSTALL" != "Y" ]]; then
    echo "Skipping installation."
  else
    echo "Reinstalling Tailscale..."
    sudo apt remove -y tailscale
  fi
fi

# Install Tailscale
echo "Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sudo sh

# Enable and start Tailscale service
echo "Starting Tailscale service..."
sudo systemctl enable --now tailscaled

# Authenticate with Tailscale
echo "Please authenticate Tailscale in your web browser."
sudo tailscale up

# Show Tailscale status
echo "Tailscale Status:"
tailscale status

# Display the Tailscale IP
echo "Your Tailscale IP:"
tailscale ip -4

echo "Tailscale setup completed successfully!"