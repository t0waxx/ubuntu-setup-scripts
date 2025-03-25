#!/bin/bash

CONFIG_FILE="/etc/netplan/50-cloud-init.yaml"

# ANSI color codes
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

echo "${GREEN}✓ Wi-Fi Setup Script${RESET}"

# Prompt the user if environment variables are not set
if [[ -z "$WIFI_IDENTITY" ]]; then
  read -rp "Enter your Wi-Fi identity (e.g., username@domain): " WIFI_IDENTITY
fi

if [[ -z "$WIFI_PASSWORD" ]]; then
  read -rsp "Enter your Wi-Fi password: " WIFI_PASSWORD
  echo
fi

# Confirm the entered credentials
echo "${YELLOW}Wi-Fi Identity:${RESET} $WIFI_IDENTITY"
echo "${YELLOW}Wi-Fi Password:${RESET} [HIDDEN]"
read -rp "Proceed with these credentials? (y/N): " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
  echo "${RED}Operation canceled.${RESET}"
  exit 0
fi

# Check if the configuration file already exists
if [[ -f "$CONFIG_FILE" ]]; then
  echo "${YELLOW}WARNING: $CONFIG_FILE already exists. Do you want to overwrite it? (y/N)${RESET}"
  read -r RESPONSE
  if [[ "$RESPONSE" != "y" && "$RESPONSE" != "Y" ]]; then
    echo "${RED}Operation canceled.${RESET}"
    exit 0
  fi
fi

# Create the Netplan configuration file
cat <<EOF | sudo tee "$CONFIG_FILE" >/dev/null
network:
  version: 2
  renderer: networkd
  wifis:
    wlan0:
      optional: true
      dhcp4: true
      dhcp6: true
      access-points:
        "eduroam":
          auth:
            key-management: eap
            method: peap
            identity: "$WIFI_IDENTITY"
            password: "$WIFI_PASSWORD"
        "nw-node1":
          auth:
            key-management: wpa-psk
          password:"password"
EOF

echo "${GREEN}✓ Applying the new network configuration...${RESET}"

# Apply the Netplan settings
if sudo netplan generate && sudo netplan apply; then
  echo "${GREEN}✓ Netplan applied successfully!${RESET}"
else
  echo "${RED}Error applying Netplan configuration.${RESET}"
  exit 1
fi

# Check Wi-Fi status
sleep 3
if ip a | grep -q wlan0; then
  echo "${GREEN}✓ Wi-Fi setup completed successfully!${RESET}"
else
  echo "${RED}Wi-Fi connection failed. Please verify your network settings.${RESET}"
fi
