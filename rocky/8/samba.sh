curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/rocky/8/defaults.sh | bash
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/rocky/8/dnf_auto.sh | bash
systemctl enable --now sshd
#PowerTools
dnf install dnf-plugins-core -y
dnf config-manager --set-enabled powertools
dnf -y install docbook-style-xsl gcc gdb gnutls-devel gpgme-devel jansson-devel keyutils-libs-devel krb5-workstation libacl-devel libaio-devel libarchive-devel libattr-devel libblkid-devel libtasn1 libtasn1-tools libxml2-devel libxslt lmdb-devel openldap-devel pam-devel perl perl-ExtUtils-MakeMaker perl-Parse-Yapp popt-devel python3-cryptography python3-dns python3-gpg python36-devel readline-devel rpcgen systemd-devel tar zlib-devel
wget https://download.samba.org/pub/samba/stable/samba-4.16.0.tar.gz
tar xaf samba*
