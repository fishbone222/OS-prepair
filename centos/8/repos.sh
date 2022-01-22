#PowerTools
yum install dnf-plugins-core -y
yum config-manager --set-enabled PowerTools
#RPM Fusion
dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm
