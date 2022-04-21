dnf install -y epel-release
dnf install -y vim htop nmap wget openssh-server tar unzip
timedatectl set-timezone Europe/Berlin
#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/centos/8/fix-lxc-filesystem.sh | sh
dnf upgrade -y
