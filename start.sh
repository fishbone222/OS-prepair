source /etc/os-release
RELEASE=$(echo $VERSION_ID | cut -d '.' -f1)
bash $ID/$RELEASE/defaults.sh
echo "Scripts found for $ID Version $RELEASE:"
pwd
ls
