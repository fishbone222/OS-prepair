dnf install -y epel-release
dnf install -y vim htop nmap wget openssh-server tar unzip
timedatectl set-timezone Europe/Berlin
systemctl enable --now sshd

dnf upgrade -y
