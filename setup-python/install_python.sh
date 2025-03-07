#!/bin/bash

# ANSI color codes
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

echo "${GREEN}✓ Installing Python3 & Pip...${RESET}"

# Install Python3 & Pip
if sudo apt -y install python3 python3-pip; then
  echo "${GREEN}✓ Python3 & Pip installed successfully!${RESET}"
else
  echo "${RED}✗ Failed to install Python3 & Pip!${RESET}"
  exit 1
fi

# Verify installation
echo "${GREEN}✓ Python Version:${RESET}"
python3 --version

echo "${GREEN}✓ Pip Version:${RESET}"
pip3 --version