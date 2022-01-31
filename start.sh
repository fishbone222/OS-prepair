source /etc/os-release
cd $ID
RELEASE=$(echo $VERSION_ID | cut -d '.' -f1)
cd $RELEASE
./defaults.sh
echo "Scripts found for $ID Version $RELEASE:"
pwd
ls
