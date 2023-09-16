#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/nuclos.sh | bash
#CT: unpreviliged, nesting, 2GB
curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/el/9/defaults.sh | bash
dnf install -y java-11-openjdk-headless java-11-openjdk-devel postgresql-server
/usr/bin/postgresql-setup --initdb
sed -i '0,/ident/{s/ident/trust/}' /var/lib/pgsql/data/pg_hba.conf
systemctl enable --now postgresql
echo use \\password to change postgres password and leave with quit && su postgres -c psql
systemctl restart postgresql
cd /tmp/
wget https://www.nuclos.de/wp-content/uploads/2023/09/nuclos-4.2023.27-installer-generic.jar
java -jar nuclos-4.2023.27-installer-generic.jar -c
