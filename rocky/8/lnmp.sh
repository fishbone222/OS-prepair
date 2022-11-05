dnf module reset php
dnf module enable php:8.0
dnf install nginx mariadb-server mod_ssl -y

dnf install php php-fpm php-gd php-mysqlnd php-mbstring -y

sed -i 's/^user.*=*$/user = nginx/' /etc/php-fpm.d/www.conf
sed -i 's/^group.*=*$/group = nginx/' /etc/php-fpm.d/www.conf
chown -R root:nginx /var/lib/php

systemctl enable --now php-fpm
systemctl enable --now nginx
systemctl enable --now mariadb
chcon -Rt httpd_sys_rw_content_t /var/www
read -p "reboot and run $(pwd)/lnmp-2.sh"
