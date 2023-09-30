#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/zoneminder.sh | bash
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/defaults.sh | bash
dnf install dnf-plugins-core -y
dnf config-manager --set-enabled crb
dnf install --nogpgcheck https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %rhel).noarch.rpm -y
dnf install --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm -y
dnf install zoneminder-nginx -y
