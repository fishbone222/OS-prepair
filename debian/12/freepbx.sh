#deb12 lxc unprivileged 10gb ssd
apt update -y
apt upgrade -y
apt -y install lsb-release build-essential git curl wget libnewt-dev libssl-dev libncurses5-dev subversion libsqlite3-dev libjansson-dev libxml2-dev uuid-dev default-libmysqlclient-dev htop sngrep lame ffmpeg mpg123 vim expect build-essential openssh-server apache2 mariadb-server mariadb-client bison flex php8.2 php8.2-curl php8.2-cli php8.2-common php8.2-mysql php8.2-gd php8.2-mbstring  php8.2-intl php8.2-xml php-pear curl sox libncurses5-dev libssl-dev mpg123 libxml2-dev libnewt-dev sqlite3  libsqlite3-dev pkg-config automake libtool autoconf git unixodbc-dev uuid uuid-dev libasound2-dev libogg-dev libvorbis-dev libicu-dev libcurl4-openssl-dev odbc-mariadb libical-dev libneon27-dev libsrtp2-dev  libspandsp-dev sudo subversion libtool-bin python-dev-is-python3 unixodbc vim wget libjansson-dev software-properties-common nodejs npm ipset iptables fail2ban php-soap
# not for pve:  linux-headers-`uname -r`
systemctl stop apparmor
apt remove apparmor -y

#Asterisk 20
cd /usr/src
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-20-current.tar.gz
tar xvf asterisk-20-current.tar.gz
cd asterisk-20*/
astdir=$(pwd)
astver=${astdir##*-}
contrib/scripts/get_mp3_source.sh
contrib/scripts/install_prereq install
./configure  --libdir=/usr/lib64 --with-pjproject-bundled --with-jansson-bundled
make menuselect.makeopts
menuselect/menuselect --enable app_macro menuselect.makeopts
make menuselect
make
make install
make samples
make config
ldconfig

groupadd asterisk
useradd -r -d /var/lib/asterisk -g asterisk asterisk
usermod -aG audio,dialout asterisk
chown -R asterisk:asterisk /etc/asterisk
chown -R asterisk:asterisk /var/{lib,log,spool}/asterisk
chown -R asterisk:asterisk /usr/lib64/asterisk
   
sed -i 's|#AST_USER|AST_USER|' /etc/default/asterisk
sed -i 's|#AST_GROUP|AST_GROUP|' /etc/default/asterisk
sed -i 's|;runuser|runuser|' /etc/asterisk/asterisk.conf
sed -i 's|;rungroup|rungroup|' /etc/asterisk/asterisk.conf
echo "/usr/lib64" >> /etc/ld.so.conf.d/x86_64-linux-gnu.conf
ldconfig

sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php/8.2/apache2/php.ini
sed -i 's/\(^memory_limit = \).*/\1256M/' /etc/php/8.2/apache2/php.ini
sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/apache2/apache2.conf
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
a2enmod rewrite
systemctl restart apache2
rm /var/www/html/index.html

cat <<EOF > /etc/odbcinst.ini
[MySQL]
Description = ODBC for MySQL (MariaDB)
Driver = /usr/lib/x86_64-linux-gnu/odbc/libmaodbc.so
FileUsage = 1
EOF

cat <<EOF > /etc/odbc.ini
[MySQL-asteriskcdrdb]
Description = MySQL connection to 'asteriskcdrdb' database
Driver = MySQL
Server = localhost
Database = asteriskcdrdb
Port = 3306
Socket = /var/run/mysqld/mysqld.sock
Option = 3
EOF

#freePBX

cd /usr/local/src
wget http://mirror.freepbx.org/modules/packages/freepbx/freepbx-17.0-latest-EDGE.tgz
tar zxvf freepbx-17.0-latest-EDGE.tgz
cd /usr/local/src/freepbx/
./start_asterisk start
./install -n

fwconsole ma installall
fwconsole reload
fwconsole restart

cat <<EOF > /etc/systemd/system/freepbx.service
[Unit]
Description=FreePBX VoIP Server
After=mariadb.service
[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/sbin/fwconsole start -q
ExecStop=/usr/sbin/fwconsole stop -q
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now freepbx


#chan_dongle
cd /tmp/
git clone https://github.com/wdoekes/asterisk-chan-dongle
cd asterisk-chan-dongle
./bootstrap
./configure --with-astversion=$astver --with-asterisk=$astdir/include
make
make install

cat <<EOF > /etc/asterisk/dongle.conf
[general]

interval=15			; Number of seconds between trying to connect to devices

;------------------------------ JITTER BUFFER CONFIGURATION --------------------------
;jbenable = yes			; Enables the use of a jitterbuffer on the receiving side of a
				; Dongle channel. Defaults to "no". An enabled jitterbuffer will
				; be used only if the sending side can create and the receiving
				; side can not accept jitter. The Dongle channel can't accept jitter,
				; thus an enabled jitterbuffer on the receive Dongle side will always
				; be used if the sending side can create jitter.

;jbforce = no			; Forces the use of a jitterbuffer on the receive side of a Dongle
				; channel. Defaults to "no".

;jbmaxsize = 200		; Max length of the jitterbuffer in milliseconds.

;jbresyncthreshold = 1000	; Jump in the frame timestamps over which the jitterbuffer is
				; resynchronized. Useful to improve the quality of the voice, with
				; big jumps in/broken timestamps, usually sent from exotic devices
				; and programs. Defaults to 1000.

;jbimpl = fixed			; Jitterbuffer implementation, used on the receiving side of a Dongle
				; channel. Two implementations are currently available - "fixed"
				; (with size always equals to jbmaxsize) and "adaptive" (with
				; variable size, actually the new jb of IAX2). Defaults to fixed.

;jbtargetextra = 40		; This option only affects the jb when 'jbimpl = adaptive' is set.
				; The option represents the number of milliseconds by which the new jitter buffer
				; will pad its size. the default is 40, so without modification, the new
				; jitter buffer will set its size to the jitter value plus 40 milliseconds.
				; increasing this value may help if your network normally has low jitter,
				; but occasionally has spikes.

;jblog = no			; Enables jitterbuffer frame logging. Defaults to "no".
;-----------------------------------------------------------------------------------

[defaults]
; now you can set here any not required device settings as template
;   sure you can overwrite in any [device] section this default values

context=default			; context for incoming calls
group=0				; calling group
rxgain=0			; increase the incoming volume; may be negative
txgain=0			; increase the outgoint volume; may be negative
autodeletesms=yes		; auto delete incoming sms
resetdongle=yes			; reset dongle during initialization with ATZ command
u2diag=-1			; set ^U2DIAG parameter on device (0 = disable everything except modem function) ; -1 not use ^U2DIAG command
usecallingpres=yes		; use the caller ID presentation or not
callingpres=allowed_passed_screen ; set caller ID presentation		by default use default network settings
disablesms=no			; disable of SMS reading from device when received
				;  chan_dongle has currently a bug with SMS reception. When a SMS gets in during a
				;  call chan_dongle might crash. Enable this option to disable sms reception.
				;  default = no

language=en			; set channel default language
smsaspdu=yes			; if 'yes' send SMS in PDU mode, feature implementation incomplete and we strongly recommend say 'yes'
mindtmfgap=45			; minimal interval from end of previews DTMF from begining of next in ms
mindtmfduration=80		; minimal DTMF tone duration in ms
mindtmfinterval=200		; minimal interval between ends of DTMF of same digits in ms

callwaiting=auto		; if 'yes' allow incoming calls waiting; by default use network settings
				; if 'no' waiting calls just ignored
disable=no			; OBSOLETED by initstate: if 'yes' no load this device and just ignore this section

initstate=start			; specified initial state of device, must be one of 'stop' 'start' 'remote'
				;   'remove' same as 'disable=yes'

exten=+1234567890		; exten for start incoming calls, only in case of Subscriber Number not available!, also set to CALLERID(ndid)

dtmf=relax			; control of incoming DTMF detection, possible values:
				;   off	   - off DTMF tones detection, voice data passed to asterisk unaltered
				;              use this value for gateways or if not use DTMF for AVR or inside dialplan
				;   inband - do DTMF tones detection
				;   relax  - like inband but with relaxdtmf option
				;  default is 'relax' by compatibility reason

; dongle required settings
[dongle0]
audio=/dev/ttyUSB1		; tty port for audio connection; 	no default value
data=/dev/ttyUSB2		; tty port for AT commands; 		no default value

; or you can omit both audio and data together and use imei=123456789012345 and/or imsi=123456789012345
;  imei and imsi must contain exactly 15 digits !
;  imei/imsi discovery is available on Linux only
imei=123456789012345
imsi=123456789012345

; if audio and data set together with imei and/or imsi audio and data has precedence
;   you can use both imei and imsi together in this case exact match by imei and imsi required
EOF

apt install -y usb-modeswitch

echo "add chan_dongle.so to Channel Driver section of /etc/asterisk/modules.conf and restart asterisk"

echo "@ pve-host"
echo "chown 100000:100020 /dev/ttyUSB*"
echo "set in  /etc/pve/lxc/xxx.conf"
echo "lxc.cgroup2.devices.allow: c 188:* rwm"
echo "lxc.mount.entry: /dev/ttyUSB0 dev/ttyUSB0 none bind,optional,create=file"
echo "lxc.mount.entry: /dev/ttyUSB1 dev/ttyUSB1 none bind,optional,create=file"
echo "lxc.mount.entry: /dev/ttyUSB2 dev/ttyUSB2 none bind,optional,create=file"
