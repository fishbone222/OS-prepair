yum update -y
yum install epel-release -y
yum install dnf -y
dnf install yum-utils -y
dnf install rpmconf epel-release -y
yes|rpmconf -a
package-cleanup --leaves
package-cleanup --orphans
dnf update -y
FREE=`df -k --output=avail / | tail -n1`
if [[ $FREE -lt 524288 ]]; then
     echo "less than 500MB free on /"
     exit
fi;
dnf -y remove yum yum-metadata-parser
rm -Rf /etc/yum
cd /etc/yum.repos.d
mkdir backups
mv CentOS-* backups
tee CentOS-Linux-BaseOS.repo<<EOM
[baseos]
name=CentOS Linux \$releasever - BaseOS
baseurl=http://vault.centos.org/8.5.2111/BaseOS/\$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOM
tee CentOS-Linux-AppStream.repo<<EOM
[appstream]
name=CentOS Linux \$releasever - AppStream
baseurl=http://vault.centos.org/8.5.2111/AppStream/\$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOM
dnf upgrade -y https://github.com/fishbone222/OS-prepair/raw/main/centos/7/legacy-rpm/{centos-release-8.1-1.1911.0.8.el8.x86_64.rpm,centos-gpg-keys-8.1-1.1911.0.8.el8.noarch.rpm,centos-repos-8.1-1.1911.0.8.el8.x86_64.rpm}
dnf install -y https://github.com/fishbone222/OS-prepair/raw/main/centos/7/legacy-rpm/{centos-release-8.1-1.1911.0.8.el8.x86_64.rpm,centos-gpg-keys-8.1-1.1911.0.8.el8.noarch.rpm,centos-repos-8.1-1.1911.0.8.el8.x86_64.rpm}
#dnf upgrade -y http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/{centos-linux-repos-8-2.el8.noarch.rpm,centos-linux-release-8.4-1.2105.el8.noarch.rpm,centos-gpg-keys-8-2.el8.noarch.rpm}
dnf -y upgrade https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf clean all
rpm -e `rpm -q kernel`
rpm -e --nodeps sysvinit-tools
dnf upgrade-minimal --refresh -y

dnf -y --releasever=8 --allowerasing --setopt=deltarpm=false distro-sync
dnf -y install kernel-core
dnf -y groupupdate "Core" "Minimal Install" --allowerasing
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/centos/8/dnf_auto.sh | sh -
echo "reboot please"
