sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
dnf install epel-release -y
rpm -ivh http://repo.okay.com.mx/centos/8/x86_64/release/okay-release-1-5.el8.noarch.rpm?
service firewalld stop
dnf -y  install fusionpbx-all fusionpbx-fail2ban-rules freeswitch-fail2ban-rules fail2ban-server fail2ban-systemd
cat /usr/share/doc/fusionpbx-fail2ban-rules/README.fusionpbx-fail2ban-rules.txt /usr/share/doc/freeswitch-fail2ban-rules/README.freeswitch-fail2ban-rules.txt > /etc/fail2ban/jail.local
chkconfig httpd on
chkconfig php-fpm on
chkconfig freeswitch on
chkconfig memcached on
chkconfig mariadb on
chkconfig fail2ban on
