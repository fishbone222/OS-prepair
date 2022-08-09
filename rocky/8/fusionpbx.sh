#!/bin/bash
read -n1 -p "Postgresql[1] or mysql[2] ?" sql
case $sql in
  p|P|1) sql=pgsql;;
  m|M|2) sql=mysql;;
  *)  sql=mysql;;
esac
echo ""
echo "You selected: $sql"
echo ""

bash <(curl -s https://raw.githubusercontent.com/fishbone222/OS-prepair/main/rocky/8/defaults.sh)
bash <(curl -s https://raw.githubusercontent.com/fishbone222/OS-prepair/main/rocky/8/dnf_auto.sh)
bash <(curl -s https://github.com/fishbone222/fusionpbx-install.sh/blob/master/centos/pre-install.sh)
