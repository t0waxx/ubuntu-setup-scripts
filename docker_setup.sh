#!/bin/bash

# ANSI color codes
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

echo "${GREEN}✓ Docker Setup Script${RESET}"

# Update package lists and upgrade system
echo "Updating system..."
sudo apt-get update && sudo apt-get upgrade -y

# Check if Docker is installed
if command -v docker &>/dev/null; then
  echo "${GREEN}✓ Docker is already installed.${RESET}"
  read -rp "Do you want to reinstall Docker? (y/N): " REINSTALL_DOCKER
  if [[ "$REINSTALL_DOCKER" != "y" && "$REINSTALL_DOCKER" != "Y" ]]; then
    echo "Skipping Docker installation."
  else
    echo "Reinstalling Docker..."
    sudo apt remove -y docker docker.io containerd runc
    curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
    echo "${GREEN}✓ Docker reinstalled successfully.${RESET}"
  fi
else
  echo "Installing Docker..."
  curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
  echo "${GREEN}✓ Docker installed successfully.${RESET}"
fi

# Ensure the user is added to the Docker group
if groups $USER | grep -q "\bdocker\b"; then
  echo "${GREEN}✓ User is already in the Docker group.${RESET}"
else
  echo "Adding user to the Docker group..."
  sudo usermod -aG docker $USER
  echo "${GREEN}✓ User added to the Docker group.${RESET}"
  echo "You may need to log out and log back in for Docker group changes to take effect."
fi

# Check if Docker Compose is installed
if command -v docker-compose &>/dev/null; then
  echo "${GREEN}✓ Docker Compose is already installed.${RESET}"
  read -rp "Do you want to reinstall Docker Compose? (y/N): " REINSTALL_COMPOSE
  if [[ "$REINSTALL_COMPOSE" != "y" && "$REINSTALL_COMPOSE" != "Y" ]]; then
    echo "Skipping Docker Compose installation."
  else
    echo "Reinstalling Docker Compose..."
    sudo apt remove -y docker-compose
    sudo apt update
    sudo apt install -y docker-compose
    echo "${GREEN}✓ Docker Compose reinstalled successfully.${RESET}"
  fi
else
  echo "Installing Docker Compose..."
  sudo apt update
  sudo apt install -y docker-compose
  echo "${GREEN}✓ Docker Compose installed successfully.${RESET}"
fi

# Display installed versions
echo "Docker Version:"
docker --version

echo "Docker Compose Version:"
docker-compose --version

echo "${GREEN}✓ Docker setup completed successfully!${RESET}"