#!/bin/bash

# ANSI color codes
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

echo "${GREEN}✓ Setting up Python & Pip aliases...${RESET}"

# Add aliases
echo 'alias python="python3"' >> ~/.bashrc
echo 'alias pip="pip3"' >> ~/.bashrc

# Apply changes
source ~/.bashrc

echo "${GREEN}✓ Aliases set successfully!${RESET}"