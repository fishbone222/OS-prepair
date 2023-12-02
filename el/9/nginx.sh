#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/nginx.sh | bash
dnf install -y nginx php php-fpm php-gd php-mysqlnd
systemctl enable --now php-fpm nginx
