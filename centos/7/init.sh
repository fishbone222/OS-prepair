yum install -y wget epel-release
yum install -y nmap htop vim openssh-server dnf dnf-automatic
yum upgrade -y
systemctl enable --now sshd
echo "export TERM=xterm" >> /etc/bashrc
useradd -m fishbone222
passwd fishbone222
