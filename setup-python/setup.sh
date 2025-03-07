#!/bin/bash

# ANSI color codes
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

echo "${GREEN}✓ Starting Python environment setup...${RESET}"

# Execute each setup script
./install_python.sh
./setup_aliases.sh
./install_uv.sh

echo "${GREEN}✓ Python environment setup completed successfully!${RESET}"