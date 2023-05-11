curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/centos/vault-mirros.sh | bash
dnf install git -y
dnf clean all
cd /tmp/
curl https://raw.githubusercontent.com/rocky-linux/rocky-tools/main/migrate2rocky/migrate2rocky.sh | bash

##alternative:
#git clone https://github.com/rocky-linux/rocky-tools.git
#cd /tmp/rocky-tools/migrate2rocky
#chmod -v +x migrate2rocky.sh
#./migrate2rocky.sh -r

dnf clean all
echo "Check /var/log/migrate2rocky.log"
echo "Please reboot"
