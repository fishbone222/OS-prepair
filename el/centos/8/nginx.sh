dnf install nginx -y
dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
dnf module reset php -y
dnf module enable php:remi-8.0 -y
dnf install php php-fpm  php-gd php-mysqlnd -y
systemctl enable --now php-fpm
systemctl enable --now nginx
