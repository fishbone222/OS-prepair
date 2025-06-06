#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/debian/12/msmtp.sh | bash
apt install -y msmtp msmtp-mta mailutils
cat << EOF > /etc/msmtprc
# Example for a user configuration file ~/.msmtprc
#
# This file focusses on TLS and authentication. Features not used here include
# logging, timeouts, SOCKS proxies, TLS parameters, Delivery Status Notification
# (DSN) settings, and more.


# Set default values for all following accounts.
defaults
logfile         /var/log/msmtp
aliases /etc/aliases

# Use the mail submission port 587 instead of the SMTP port 25.
port 465

# Always use TLS.
tls on

# Set a list of trusted CAs for TLS. The default is to use system settings, but
# you can select your own file.
#tls_trust_file /etc/ssl/certs/ca-certificates.crt

#noreply account
account noreply

# Host name of the SMTP server
host smtp.fischer-siegen.de

# As an alternative to tls_trust_file, you can use tls_fingerprint
# to pin a single certificate. You have to update the fingerprint when the
# server certificate changes, but an attacker cannot trick you into accepting
# a fraudulent certificate. Get the fingerprint with
# $ msmtp --serverinfo --tls --tls-certcheck=off --host=smtp.freemail.example
#tls_fingerprint 00:11:22:33:44:55:66:77:88:99:AA:BB:CC:DD:EE:FF:00:11:22:33

# Envelope-from address
from vcontrold@siegen.fischer-siegen.de

# Authentication. The password is given using one of five methods, see below.
auth on
tls_starttls   off
user noreply@fischer-siegen.de

# Password method 1: Add the password to the system keyring, and let msmtp get
# it automatically. To set the keyring password using Gnome's libsecret:
# $ secret-tool store --label=msmtp #   host smtp.freemail.example #   service smtp #   user joe.smith

# Password method 2: Store the password in an encrypted file, and tell msmtp
# which command to use to decrypt it. This is usually used with GnuPG, as in
# this example. Usually gpg-agent will ask once for the decryption password.
#passwordeval gpg2 --no-tty -q -d ~/.msmtp-password.gpg

# Password method 3: Store the password directly in this file. Usually it is not
# a good idea to store passwords in cleartext files. If you do it anyway, at
# least make sure that this file can only be read by yourself.
password 123456789

# Password method 4: Store the password in ~/.netrc. This method is probably not
# relevant anymore.

# Password method 5: Do not specify a password. Msmtp will then prompt you for
# it. This means you need to be able to type into a terminal when msmtp runs.


# A second mail address at the same freemail service
#account freemail2 : freemail
#from joey@freemail.example


# The SMTP server of your ISP
#account isp
#host mail.isp.example
#from smithjoe@isp.example
#auth on
#user 12345


# Set a default account
account default : noreply
EOF

cat << \EOF > /etc/mail.rc
set sendmail="/usr/bin/msmtp -t"
EOF
echo "set password in /etc/msmtprc"
