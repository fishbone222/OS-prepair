#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/defaults.sh | bash
dnf install -y epel-release
dnf install -y 'dnf-command(config-manager)'
dnf config-manager --set-enabled crb
dnf install -y vim htop nmap wget openssh-server tar unzip bash-completion
timedatectl set-timezone Europe/Berlin
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/id_rsa.pub >> ~/.ssh/authorized_keys
systemctl enable --now sshd
echo 'alias ls="ls -hal --color=auto"'>>~/.bashrc

dnf upgrade -y

dnf autoremove -y
dnf clean all
