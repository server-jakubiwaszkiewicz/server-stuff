#!/bin/bash
echo "This script is prepared for Ubuntu 20.04 LTS"
echo "Do you want to install Docker? (y/n)"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "Installing Docker..."

    # Update the package list
    sudo apt update

    # Install required dependencies
    sudo apt install apt-transport-https ca-certificates curl software-properties-common

    # Add Docker GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # Add Docker repository
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Update the package list (again)
    sudo apt update

    # Check Docker version and installation candidates
    apt-cache policy docker-ce

    # Install Docker
    sudo apt install docker-ce

    # Check the status of the Docker service
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
    echo "Exiting..."
fi

