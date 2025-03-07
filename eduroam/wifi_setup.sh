#!/bin/bash

CONFIG_FILE="/etc/netplan/50-cloud-init.yaml"

# Prompt the user if environment variables are not set
if [[ -z "$WIFI_IDENTITY" ]]; then
  read -rp "Enter your Wi-Fi identity (e.g., username@domain): " WIFI_IDENTITY
fi

if [[ -z "$WIFI_PASSWORD" ]]; then
  read -rsp "Enter your Wi-Fi password: " WIFI_PASSWORD
  echo
fi

# Confirm the entered credentials
echo "Wi-Fi Identity: $WIFI_IDENTITY"
echo "Wi-Fi Password: [HIDDEN]"
read -rp "Proceed with these credentials? (y/N): " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
  echo "Operation canceled."
  exit 0
fi

# Check if the configuration file already exists
if [[ -f "$CONFIG_FILE" ]]; then
  echo "WARNING: $CONFIG_FILE already exists. Do you want to overwrite it? (y/N)"
  read -r RESPONSE
  if [[ "$RESPONSE" != "y" && "$RESPONSE" != "Y" ]]; then
    echo "Operation canceled."
    exit 0
  fi
fi

# Create the Netplan configuration file
cat <<EOF | sudo tee "$CONFIG_FILE"
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
EOF

echo "Applying the new network configuration..."

# Apply the Netplan settings
sudo netplan apply

# Check Wi-Fi status
sleep 3
ip a | grep wlan0

echo "Wi-Fi setup completed successfully!"