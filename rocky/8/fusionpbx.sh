read -n1 -p "Postgresql(1) or mysql(2) ?" sql
case $sql in
  p|P|1) sql=pgsql;;
  m|M|2) sql=mysql;;
  *)  sql=mysql;;
esac

curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/rocky/8/defaults.sh | bash
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/rocky/8/dnf_auto.sh | bash
sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
dnf install epel-release -y
rpm -ivh http://repo.okay.com.mx/centos/8/x86_64/release/okay-release-1-5.el8.noarch.rpm?
if [[ sql==pgsql ]] then
  dnf module enable postgresql:13 -y
  dnf install postgresql-server php-pgsql -y
  postgresql-setup --initdb
  systemctl enable --now postgresql
fi
systemctl stop firewalld
dnf -y  install nginx fusionpbx-all fusionpbx-fail2ban-rules freeswitch-fail2ban-rules fail2ban-server fail2ban-systemd
cat /usr/share/doc/fusionpbx-fail2ban-rules/README.fusionpbx-fail2ban-rules.txt /usr/share/doc/freeswitch-fail2ban-rules/README.freeswitch-fail2ban-rules.txt > /etc/fail2ban/jail.local
systemctl enable --now httpd
systemctl enable --now php-fpm
systemctl enable --now freeswitch
systemctl enable --now memcached
if [[ sql==mysql ]] then
  systemctl enable --now mariadb
fi
systemctl enable --now fail2ban
