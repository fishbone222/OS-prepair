#!/bin/bash

bash <(curl -s https://raw.githubusercontent.com/fishbone222/OS-prepair/main/rocky/8/defaults.sh)
bash <(curl -s https://raw.githubusercontent.com/fishbone222/OS-prepair/main/rocky/8/dnf_auto.sh)
bash <(curl -s https://raw.githubusercontent.com/fishbone222/fusionpbx-install.sh/master/centos/pre-install.sh)

adduser freeswitch -G daemon

dnf -qy module disable postgresql
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf install -y postgresql14-server
ln -s /usr/bin/postgresql-setup /usr/pgsql-14/bin/postgresql-14-setup
ln -s /etc/systemd/system/postgresql-14.service ln -s /etc/systemd/system/postgresql.service

cd /usr/src/fusionpbx-install.sh/centos && ./install.sh
