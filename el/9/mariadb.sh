#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/mariadb.sh | bash
dnf install -y mariadb-server
systemctl enable --now mariadb
