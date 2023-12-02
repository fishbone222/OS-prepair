#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/dolibarr.sh | bash
#LXC unpreviliged, nesting
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/defaults.sh | bash
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/dnf_auto.sh | bash
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/nginx.sh | bash
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/mariadb.sh | bash
dnf install -y php-gd php-zip php-intl php-mysqli
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/copy-cert.sh > /opt/copy-cert.sh
chmod +x /opt/copy-cert.sh
ssh-keygen -b 4096 -t rsa -f ~/.ssh/id_rsa -q -N ""
cat ~/.ssh/id_rsa.pub
mkdir -p /etc/pki/nginx/private/
echo "@daily /usr/bin/bash /opt/copy-cert.sh" | crontab


/opt/copy-cert.sh
