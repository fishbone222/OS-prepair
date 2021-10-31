echo '[mongodb-org]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.6/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc' > /etc/yum.repos.d/mongodb-org.repo
dnf install mongodb-org-server -y

rpm -i http://repo.iotti.biz/CentOS/8/noarch/lux-release-8-1.noarch.rpm
dnf install -y apache-commons-daemon-jsvc

echo "%_netsharedpath /sys:/proc" >> /etc/rpm/macros.dist
dnf install -y nmap openssh-server vim java-1.8.0-openjdk wget tar
dnf upgrade -y

cd /tmp/
curl https://static.tp-link.com/upload/software/2021/202110/20211011/Omada_SDN_Controller_v4.4.6_Linux_x64.tar.gz | tar xvz
./install.sh
