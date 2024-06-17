#deb12 lxc unprivileged 8gb ssd
apt update -y
apt upgrade -y
apt install curl lsb-release git -y
systemctl stop apparmor
apt remove apparmor -y
cd /usr/src
#Asterisk 20
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-20-current.tar.gz
tar zxvf asterisk-20-current.tar.gz
rm -rf asterisk-20-current.tar.gz
cd asterisk-20*/
astdir=$(pwd)
astver=${astdir##*-}
contrib/scripts/install_prereq install
./configure
make menuselect
make
make install
make samples
mkdir /etc/asterisk/samples
mv /etc/asterisk/*.*  /etc/asterisk/samples/
make basic-pbx
make config
systemctl enable --now asterisk.service

#freePBX
wget https://github.com/FreePBX/sng_freepbx_debian_install/raw/master/sng_freepbx_debian_install.sh -O /tmp/sng_freepbx_debian_install.sh
bash /tmp/sng_freepbx_debian_install.sh

#chan_dongle
cd /tmp/
git clone https://github.com/wdoekes/asterisk-chan-dongle
cd asterisk-chan-dongle
./bootstrap
./configure --with-astversion=$astver --with-asterisk=$astdir/include
make
make install

echo "add chan_dongle.so to Channel Driver section of /etc/asterisk/modules.conf and restart asterisk"
