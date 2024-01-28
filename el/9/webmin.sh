cat << EOF > /etc/yum.repos.d/webmin.repo
[Webmin]
name=Webmin  
mirrorlist=https://download.webmin.com/download/yum/mirrorlist
enabled=1
gpgkey=http://www.webmin.com/jcameron-key.asc
EOF
dnf update -y
dnf install -y webmin
