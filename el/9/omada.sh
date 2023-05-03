echo "curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/omada.sh | sh -"
echo "This won't work until Omada accepts MongoDB 6.0 as 4.4 and 5.0 are not working on EL9"
exit 7
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/defaults.sh | bash
echo '[mongodb-org]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releaseverServer/mongodb-org/6.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-6.0.asc' > /etc/yum.repos.d/mongodb-org.repo
dnf install mongodb-org-server -y

rpm -i https://repo.almalinux.org/development/almalinux/9/devel/x86_64/Packages/apache-commons-daemon-jsvc-1.2.4-1.el9.x86_64.rpm
#dnf install -y apache-commons-daemon-jsvc

echo "%_netsharedpath /sys:/proc" >> /etc/rpm/macros.dist
dnf install -y nmap openssh-server vim java-1.8.0-openjdk-headless wget tar nginx
systemctl enable --now sshd
dnf upgrade -y

dnf autoremove -y
dnf clean all

cd /tmp/
curl https://static.tp-link.com/upload/software/2023/202303/20230321/Omada_SDN_Controller_v5.9.31_Linux_x64.tar.gz | tar xvz
cd Omada*
./install.sh
echo 'server{
	listen 80;
	server_name _;
	return 301 https://$host:8043/$request_uri;
}'>>/etc/nginx/conf.d/omada.conf
systemctl enable --now nginx
