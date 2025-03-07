#!/bin/bash

# ANSI color codes
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

echo "${GREEN}✓ Tailscale Setup Script${RESET}"

# Check if Tailscale is already installed
if command -v tailscale &>/dev/null; then
  echo "${GREEN}✓ Tailscale is already installed.${RESET}"
  read -rp "Do you want to reinstall Tailscale? (y/N): " REINSTALL
  if [[ "$REINSTALL" != "y" && "$REINSTALL" != "Y" ]]; then
    echo "Skipping installation."
  else
    echo "Reinstalling Tailscale..."
    sudo systemctl stop tailscaled
    sudo apt purge -y tailscale && sudo apt autoremove -y
  fi
fi

# Install Tailscale
echo "${GREEN}✓ Installing Tailscale...${RESET}"
if ! curl -fsSL https://tailscale.com/install.sh | sudo sh; then
  echo "${RED}✗ Tailscale installation failed!${RESET}"
  exit 1
fi

# Enable and start Tailscale service
echo "${GREEN}✓ Starting Tailscale service...${RESET}"
sudo systemctl enable --now tailscaled || { echo "${RED}✗ Failed to start tailscaled!${RESET}"; exit 1; }

# Authenticate with Tailscale
echo "${GREEN}✓ Please authenticate Tailscale in your web browser.${RESET}"
if ! sudo tailscale up; then
  echo "${RED}✗ Tailscale authentication failed!${RESET}"
  exit 1
fi

# Show Tailscale status
echo "${GREEN}✓ Tailscale Status:${RESET}"
tailscale status || { echo "${RED}✗ Failed to retrieve Tailscale status!${RESET}"; exit 1; }

# Display the Tailscale IP
echo "${GREEN}✓ Your Tailscale IP:${RESET}"
tailscale ip -4 || { echo "${RED}✗ Failed to retrieve Tailscale IP!${RESET}"; exit 1; }

echo "${GREEN}✓ Tailscale setup completed successfully!${RESET}"