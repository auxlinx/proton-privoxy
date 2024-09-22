#!/bin/bash

# Connect to a random ProtonVPN server
protonvpn-cli c -r

# Check if the VPN connection was successful
if ! ip link show proton0 > /dev/null; then
    echo "Failed to bring up VPN :("
    exit 1
fi

# Restart Privoxy to apply the new VPN connection
echo "Restarting Privoxy"
systemctl restart privoxy

echo "Proton-Privoxy server changed successfully"
