#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/rocky/8/dnf_auto.sh | bash
dnf install dnf-automatic -y
sed -i 's/upgrade_type = default/upgrade_type = security/g' /etc/dnf/automatic.conf
sed -i 's/apply_update = no/apply_update = yes/g' /etc/dnf/automatic.conf
systemctl enable --now dnf-automatic.timer
