#!/bin/bash

echo "Docker Setup Script"

# Update package lists and upgrade system
echo "Updating system..."
sudo apt-get update && sudo apt-get upgrade -y

# Check if Docker is installed
if command -v docker &>/dev/null; then
  echo "Docker is already installed."
  read -rp "Do you want to reinstall Docker? (y/N): " REINSTALL_DOCKER
  if [[ "$REINSTALL_DOCKER" != "y" && "$REINSTALL_DOCKER" != "Y" ]]; then
    echo "Skipping Docker installation."
  else
    echo "Reinstalling Docker..."
    sudo apt remove -y docker docker.io containerd runc
    curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
  fi
else
  echo "Installing Docker..."
  curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
fi

# Ensure the user is added to the Docker group
if groups $USER | grep -q "\bdocker\b"; then
  echo "User is already in the Docker group."
else
  echo "Adding user to the Docker group..."
  sudo usermod -aG docker $USER
  echo "You may need to log out and log back in for Docker group changes to take effect."
fi

# Check if Docker Compose is installed
if command -v docker-compose &>/dev/null; then
  echo "Docker Compose is already installed."
  read -rp "Do you want to reinstall Docker Compose? (y/N): " REINSTALL_COMPOSE
  if [[ "$REINSTALL_COMPOSE" != "y" && "$REINSTALL_COMPOSE" != "Y" ]]; then
    echo "Skipping Docker Compose installation."
  else
    echo "Reinstalling Docker Compose..."
    sudo apt remove -y docker-compose
    sudo apt update
    sudo apt install -y docker-compose
  fi
else
  echo "Installing Docker Compose..."
  sudo apt update
  sudo apt install -y docker-compose
fi

# Display installed versions
echo "Docker Version:"
docker --version

echo "Docker Compose Version:"
docker-compose --version

echo "Docker setup completed successfully!"