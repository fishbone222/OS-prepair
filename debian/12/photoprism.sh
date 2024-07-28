#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/debian/12/photoprism.sh | bash
apt install -y curl htop
curl -sLO https://dl.photoprism.app/pkg/linux/deb/amd64.deb
apt install -y --no-install-recommends ./amd64.deb
photoprism -v
