#!/bin/bash
echo "This script is prepared for Ubuntu 20.04 LTS"
echo "Do you want to install Docker? (y/n)"
read answer

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "Installing Docker..."
    sudo apt update
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    apt-cache policy docker-ce
    sudo apt install docker-ce
    sudo systemctl status docker
else
    echo "Ok..."
fi

echo "Do you want to install net-tools? (y/n)"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "Installing net-tools..."
    sudo apt install net-tools
else
    echo "Ok..."
fi

echo "Do you want to install Caddy v2? (y/n)"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "Installing Caddyv2..."
    sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
    sudo apt update
    sudo apt install caddy
else
    echo "Ok..."
fi

echo "Do you want to add user called github? (y/n)"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    username = "github"
    password = "RyOhdhKA1"
	useradd -m -p "$pass" "$username"
    usermod -aG sudo github
    echo "Adding SSH key..."
    mkdir /home/github/.ssh && touch /home/github/.ssh/authorized_keys && chmod 700 /home/github/.ssh && chmod 600 /home/github/.ssh/authorized_keys
    ssh-keygenm -t ed25519 -C "kkubaiwaszkiewicz@gmail.com"
    cat /home/github/.ssh/id_ed25519.pub >> /home/github/.ssh/authorized_keys
    cat /home/github/.ssh/id_ed25519
else
    echo "Exiting..."
fi

echo "Download "