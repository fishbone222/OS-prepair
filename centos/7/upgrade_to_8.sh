yum update -y
yum install epel-release -y
yum install dnf -y
dnf -y remove yum yum-metadata-parser
dnf install yum-utils -y
dnf install rpmconf -y
rpmconf -a
package-cleanup --leaves
package-cleanup --orphans
dnf upgrade
dnf install -y http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/{centos-linux-repos-8-2.el8.noarch.rpm,centos-linux-release-8.4-1.2105.el8.noarch.rpm,centos-gpg-keys-8-2.el8.noarch.rpm}
dnf -y upgrade https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf clean all
rpm -e `rpm -q kernel`
rpm -e --nodeps sysvinit-tools
dnf -y --releasever=8 --allowerasing --setopt=deltarpm=false distro-sync
dnf -y install kernel-core
dnf -y groupupdate "Core" "Minimal Install"