curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/rocky/8/defaults.sh | bash
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/rocky/8/dnf_auto.sh | bash
systemctl enable --now sshd
#PowerTools
dnf install dnf-plugins-core -y
dnf config-manager --set-enabled powertools
