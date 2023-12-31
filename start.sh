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
bash $ID/$RELEASE/defaults.sh
echo "Scripts found for $ID Version $RELEASE:"
pwd
ls
