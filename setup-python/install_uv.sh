#!/bin/bash

# ANSI color codes
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

echo "${GREEN}✓ Installing UV (Ultra-fast Python package manager)...${RESET}"

# Install UV
if curl -LsSf https://astral.sh/uv/install.sh | sh; then
  echo "${GREEN}✓ UV installed successfully!${RESET}"
else
  echo "${RED}✗ Failed to install UV!${RESET}"
  exit 1
fi

# Ensure UV is in PATH
export PATH="$HOME/.local/bin:$PATH"

# Verify installation
if command -v uv &>/dev/null; then
  echo "${GREEN}✓ UV Version:$(uv --version)${RESET}"
else
  echo "${YELLOW}⚠ UV is installed, but may not be in your PATH. Try running: source ~/.bashrc${RESET}"
fi