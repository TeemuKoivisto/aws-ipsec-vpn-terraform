#!/bin/bash
set -e

# Update and install WireGuard
apt-get update && apt-get install -y wireguard iptables

# Enable IP forwarding
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

# Create WireGuard keys
umask 077
wg genkey | tee /etc/wireguard/privatekey | wg pubkey > /etc/wireguard/publickey

# Read keys
PRIVATE_KEY=$(cat /etc/wireguard/privatekey)

# Set interface and peer IPs (adjust as needed)
VPN_INTERFACE_IP="10.0.0.1/24"
CLIENT_ALLOWED_IP="10.0.0.2/32"
LISTEN_PORT=51820
ETH_INTERFACE=$(ip route get 8.8.8.8 | awk '{print $5; exit}')

# Create wg0.conf
cat > /etc/wireguard/wg0.conf <<EOF
[Interface]
Address = $VPN_INTERFACE_IP
ListenPort = $LISTEN_PORT
PrivateKey = $PRIVATE_KEY
PostUp = iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o $ETH_INTERFACE -j MASQUERADE
PostDown = iptables -t nat -D POSTROUTING -s 10.0.0.0/24 -o $ETH_INTERFACE -j MASQUERADE

[Peer]
PublicKey = $CLIENT_PUBLIC_KEY
AllowedIPs = $CLIENT_ALLOWED_IP 
EOF

# Enable and start WireGuard
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0
