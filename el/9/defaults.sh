#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/defaults.sh | bash
dnf install -y epel-release
dnf install -y vim htop nmap wget openssh-server tar unzip
timedatectl set-timezone Europe/Berlin
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/id_rsa.pub >> ~/.ssh/authorized_keys
systemctl enable --now sshd

dnf upgrade -y

dnf autoremove -y
dnf clean all
