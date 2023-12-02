#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/dolibarr.sh | bash
#LXC unpreviliged, nesting
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/defaults.sh | bash
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/dnf_auto.sh | bash
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/nginx.sh | bash
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/mariadb.sh | bash
dnf install -y php-gd php-zip php-intl php-mysqli
