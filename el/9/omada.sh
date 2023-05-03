echo "curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/omada.sh | sh -"
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/defaults.sh | bash
echo '[mongodb-org]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releaseverServer/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc' > /etc/yum.repos.d/mongodb-org.repo
dnf install mongodb-org-server -y

rpm -i http://repo.iotti.biz/CentOS/8/noarch/lux-release-8-1.noarch.rpm
dnf install -y apache-commons-daemon-jsvc

echo "%_netsharedpath /sys:/proc" >> /etc/rpm/macros.dist
dnf install -y nmap openssh-server vim java-1.8.0-openjdk wget tar
systemctl enable --now sshd
dnf upgrade -y

dnf autoremove -y
dnf clean all

cd /tmp/
curl https://static.tp-link.com/upload/software/2022/202203/20220322/Omada_SDN_Controller_v5.1.7_Linux_x64.tar.gz | tar xvz
cd Omada*
./install.sh
