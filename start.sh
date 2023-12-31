#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/start.sh | bash
git clone https://github.com/fishbone222/OS-prepair/ /tmp/osprepair
cd /tmp/osprepair/
source /etc/os-release
RELEASE=$(echo $VERSION_ID | cut -d '.' -f1)
case $ID in
   almalinux|centos|rhel)
     ID2="el" ;;
   *)
     ID2=$ID ;;
esac
bash $ID2/$RELEASE/defaults.sh
echo "Scripts found for $ID2 Version $RELEASE:"
pwd
ls
