#!/bin/bash -l

# ANSI color codes
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
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
bash "$SCRIPT_DIR/setup_path.sh"

# Display instruction to manually apply changes
echo "${YELLOW}⚠ To apply changes, please run: source ~/.bashrc${RESET}"

echo "${GREEN}✓ Python environment setup completed successfully!${RESET}"