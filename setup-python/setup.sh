#!/bin/bash

# ANSI color codes
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

# Set the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "${GREEN}✓ Starting Python environment setup...${RESET}"

# Move to the script directory
cd "$SCRIPT_DIR" || { echo "${RED}✗ Failed to change directory!${RESET}"; exit 1; }

# Execute each setup script
bash "$SCRIPT_DIR/install_python.sh"
bash "$SCRIPT_DIR/setup_aliases.sh"
bash "$SCRIPT_DIR/install_uv.sh"

echo "${GREEN}✓ Python environment setup completed successfully!${RESET}"