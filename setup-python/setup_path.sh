#!/bin/bash

# ANSI color codes
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

echo "${GREEN}✓ Adding \$HOME/.local/bin to PATH...${RESET}"

# Define shell profile files
SHELL_PROFILES=("$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile")

# Check if already in PATH
if echo "$PATH" | grep -q "$HOME/.local/bin"; then
  echo "${GREEN}✓ \$HOME/.local/bin is already in PATH.${RESET}"
else
  # Add to each shell profile
  for PROFILE in "${SHELL_PROFILES[@]}"; do
    if [[ -f "$PROFILE" ]]; then
      echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$PROFILE"
      echo "${GREEN}✓ Added to $PROFILE${RESET}"
    fi
  done
fi

# Apply changes to the current shell
if [[ -f "$HOME/.local/bin/env" ]]; then
  source "$HOME/.local/bin/env"
  echo "${GREEN}✓ Sourced \$HOME/.local/bin/env${RESET}"
else
  echo "${RED}✗ \$HOME/.local/bin/env not found! Restart your shell manually.${RESET}"
fi

echo "${GREEN}✓ PATH setup completed! Restart your shell to apply changes.${RESET}"