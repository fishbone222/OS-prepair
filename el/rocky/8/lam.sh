dnf module enable php:7.4 -y
dnf install httpd httpd-tools php php-fpm php-mysqlnd php-opcache php-gd php-xml php-mbstring php-json php-gmp php-zip php-ldap -y
sudo systemctl enable --now php-fpm httpd
wget http://prdownloads.sourceforge.net/lam/ldap-account-manager-7.9-1.fedora.1.noarch.rpm
dnf localinstall ldap-account-manager-*.rpm
echo "http://(server IP or hostname)/lam"
