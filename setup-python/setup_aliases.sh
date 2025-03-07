#!/bin/bash

# ANSI color codes
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

echo "${GREEN}✓ Setting up Python & Pip aliases...${RESET}"

# Check if aliases already exist
if grep -q 'alias python="python3"' ~/.bashrc && grep -q 'alias pip="pip3"' ~/.bashrc; then
  echo "${GREEN}✓ Aliases already set in ~/.bashrc.${RESET}"
else
  echo 'alias python="python3"' >> ~/.bashrc
  echo 'alias pip="pip3"' >> ~/.bashrc
  echo "${GREEN}✓ Aliases added to ~/.bashrc.${RESET}"
fi

# Ensure changes apply to all new shells
echo 'alias python="python3"' >> ~/.profile
echo 'alias pip="pip3"' >> ~/.profile

# Reload the shell configuration properly
if [[ $SHELL == *"bash"* ]]; then
  source ~/.bashrc
elif [[ $SHELL == *"zsh"* ]]; then
  source ~/.zshrc
else
  echo "${RED}✗ Could not determine shell type, please restart your terminal.${RESET}"
fi

echo "${GREEN}✓ Aliases set successfully! Please restart your terminal to apply changes.${RESET}"