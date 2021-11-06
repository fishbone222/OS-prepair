apt update -y
apt upgrade -y
apt dist-upgrade -y
find /etc/apt/ -type f -iname *.list -exec sed -i -e 's/buster\/updates/bullseye-security/g' -e 's/buster/bullseye/g' {} \;
apt update -y
apt full-upgrade -y
reboot
