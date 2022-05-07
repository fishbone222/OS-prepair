#PowerTools
dnf install dnf-plugins-core -y
dnf config-manager --set-enabled powertools
#RPM Fusion
dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm
#CERT Linux Forensics Tools Repository
rpm --import https://www.cert.org/forensics/repository/forensics-expires-2022-04-03.asc
dnf install https://forensics.cert.org/cert-forensics-tools-release-el8.rpm
