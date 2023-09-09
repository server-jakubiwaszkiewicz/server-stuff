echo "Do you want to add user called github? (y/n)"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    username = github
    password = RyOhdhKA1
	useradd -m -p $pass $username
    usermod -aG sudo github
    echo "Adding SSH key..."
    mkdir /home/github/.ssh && touch /home/github/.ssh/authorized_keys && chmod 700 /home/github/.ssh && chmod 600 /home/github/.ssh/authorized_keys
    ssh-keygenm -t ed25519 -C "kkubaiwaszkiewicz@gmail.com"
    cat /home/github/.ssh/id_ed25519.pub >> /home/github/.ssh/authorized_keys
else
    echo "Exiting..."
fi
