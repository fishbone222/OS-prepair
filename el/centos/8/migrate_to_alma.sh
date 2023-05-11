curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/centos/vault-mirros.sh | bash
dnf install git -y
dnf clean all
cd /tmp/
rpm --import https://repo.almalinux.org/almalinux/RPM-GPG-KEY-AlmaLinux
cd /tmp
wget https://raw.githubusercontent.com/AlmaLinux/almalinux-deploy/master/almalinux-deploy.sh
bash almalinux-deploy.sh
