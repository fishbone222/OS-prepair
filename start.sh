#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/start.sh | bash
source /etc/os-release
RELEASE=$(echo $VERSION_ID | cut -d '.' -f1)
case $ID in
   almalinux|centos|rhel)
     ID2="el" ;;
   *)
     ID2=$ID ;;
esac
wget https://github.com/fishbone222/OS-prepair/archive/main.tar.gz
tar xaf main.tar.gz
cd /tmp/OS-prepair-main/
bash $ID2/$RELEASE/defaults.sh
echo "Scripts found for $ID2 Version $RELEASE:"
pwd
ls
