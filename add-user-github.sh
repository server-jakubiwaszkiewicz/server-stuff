#!/bin/bash

# Set the username and password
USERNAME="Github"
PASSWORD="RyOhdhKA1"

if id "$USERNAME" &>/dev/null; then
    echo "User '$USERNAME' already exists."
else
    sudo useradd -m "$USERNAME"
    echo "$USERNAME:$PASSWORD" | sudo chpasswd
    sudo usermod -aG sudo "$USERNAME"
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

echo "Your public key is located at: $SSH_DIR/id_ed25519"
echo "You can copy it and add it to your GitHub or other services."
echo "or copy it to your clipboard with the following command:"
echo "sudo -u $USERNAME cat $SSH_DIR/id_ed25519 | xclip -selection clipboard"
