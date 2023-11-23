dnf install -y nginx php php-fpm php-gd php-mysqlnd
systemctl enable --now php-fpm nginx
