#!/bin/bash

USERNAME="Github"
PASSWORD="RyOhdhKA1"

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with root privileges (sudo)."
    exit 1
fi

if id "$USERNAME" &>/dev/null; then
    echo "User '$USERNAME' already exists."
else
    adduser -m "$USERNAME"
    echo "$USERNAME:$PASSWORD" | chpasswd
    usermod -aG sudo "$USERNAME"
    echo "User '$USERNAME' created and added to the sudoers group."
fi

SSH_DIR="/home/$USERNAME/.ssh"

if [ ! -d "$SSH_DIR" ]; then
    sudo -u "$USERNAME" mkdir "$SSH_DIR"
    sudo -u "$USERNAME" chmod 700 "$SSH_DIR"
fi

if [ ! -f "$SSH_DIR/id_ed25519" ]; then
    sudo -u "$USERNAME" ssh-keygen -t ed25519 -f "$SSH_DIR/id_ed25519" -N ""
    echo "Generated SSH key for user '$USERNAME'."
fi

if [ ! -f "$SSH_DIR/authorized_keys" ]; then
    sudo -u "$USERNAME" touch "$SSH_DIR/authorized_keys"
    sudo -u "$USERNAME" chmod 600 "$SSH_DIR/authorized_keys"
    echo "Created authorized_keys file for user '$USERNAME'."
    sudo -u "$USERNAME" cat "$SSH_DIR/id_ed25519.pub" >> "$SSH_DIR/authorized_keys"
fi