#!/bin/bash

bash <(curl -s https://raw.githubusercontent.com/fishbone222/OS-prepair/main/rocky/8/defaults.sh)
bash <(curl -s https://raw.githubusercontent.com/fishbone222/OS-prepair/main/rocky/8/dnf_auto.sh)
bash <(curl -s https://raw.githubusercontent.com/fishbone222/fusionpbx-install.sh/master/centos/pre-install.sh)

adduser freeswitch -G daemon

cd /usr/src/fusionpbx-install.sh/centos && ./install.sh
