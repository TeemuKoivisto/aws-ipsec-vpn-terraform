#!/usr/bin/env bash

if [ -f .env ]; then
  export $(cat .env | xargs)
fi

sync() {
  local ip=$(terraform output -raw ec2_ip)
  echo "EC2 ip is $ip"
  SSH_PATH="$HOME/.ssh/$TF_VAR_ssh_key_name"
  if [ ! -f $SSH_PATH ]; then
    echo -e "\033[41mSSH key not found at: $SSH_PATH\033[0m"
    exit 1
  fi
  ssh -o "IdentitiesOnly=yes" -i $SSH_PATH ubuntu@$ip "sudo cat /etc/wireguard/publickey" > ./publickey
  echo -e "Copied /etc/wireguard/publickey from $ip to ./publickey"
  PUBLIC_KEY=$(cat ./publickey)
  WG_CONF="/opt/homebrew/etc/wireguard/wg0.conf"
  if [ ! -f $WG_CONF ]; then
    echo -e "\033[41mWireGuard config not found at: $WG_CONF\033[0m"
    exit 1
  fi
  sed -i '' "s|PublicKey = .*|PublicKey = $PUBLIC_KEY|" $WG_CONF
  sed -i '' "s|Endpoint = .*|Endpoint = $ip:51820|" $WG_CONF
  echo "Update $WG_CONF"
  echo "PublicKey = $PUBLIC_KEY"
  echo "Endpoint = $ip"
}

case "$1" in
ssh)
  shift
  SSH_PATH="$HOME/.ssh/$TF_VAR_ssh_key_name"
  if [[ -z $1 ]]; then
    echo -e "Usage: ./ex.sh ssh <ipv4>"
    exit 1
  fi
  if [ ! -f $SSH_PATH ]; then
    echo -e "\033[41mSSH key not found at: $SSH_PATH\033[0m"
    exit 1
  fi
  ssh -o "IdentitiesOnly=yes" -i $SSH_PATH ubuntu@$1
  ;;
sync)
  shift
  sync
  ;;
tf)
  shift
  terraform $@
  ;;
wup)
  sudo wg-quick up wg0
  ;;
wdown)
  sudo wg-quick down wg0
  ;;
*)
  echo $"Usage: $0 ssh <ip>|wup|wdown|tf <commands>|conf <public_key> <allowed_ips>"
  exit 1
  ;;
esac
