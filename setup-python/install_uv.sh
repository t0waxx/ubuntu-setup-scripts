#!/bin/bash

# ANSI color codes
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

echo "${GREEN}✓ Installing UV (Ultra-fast Python package manager)...${RESET}"

# Install UV
if curl -LsSf https://astral.sh/uv/install.sh | sh; then
  echo "${GREEN}✓ UV installed successfully!${RESET}"
else
  echo "${RED}✗ Failed to install UV!${RESET}"
  exit 1
fi

# Verify installation
echo "${GREEN}✓ UV Version:${RESET}"
uv --version