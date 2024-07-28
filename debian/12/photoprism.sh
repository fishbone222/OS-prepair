#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/debian/12/photoprism.sh | bash
apt install -y vim curl htop ffmpeg exiftool darktable libpng-dev libjpeg-dev libtiff-dev libvips imagemagick
apt remove -y nano
curl -sLO https://dl.photoprism.app/pkg/linux/deb/amd64.deb
apt install -y --no-install-recommends ./amd64.deb
useradd --system photoprism
mkdir /var/lib/photoprism
chown -R photoprism:photoprism /var/lib/photoprism /opt/photoprism
cd /var/lib/photoprism
####vim .env

chown photoprism:photoprism .env
chmod 640 .env

#systemctl enable --now photoprism
echo '0 * * * * photoprism export $(grep -v ^# /var/lib/photoprism/.env | xargs) && /opt/photoprism/bin/photoprism import >/dev/null 2>&1' > /etc/cron.d/photoprism

photoprism -v

exit

cat photoprism.service
[Unit]
Description=PhotoPrism service
After=network.target

[Service]
Type=forking
User=photoprism
Group=photoprism
WorkingDirectory=/opt/photoprism
EnvironmentFile=/var/lib/photoprism/.env
ExecStart=/opt/photoprism/bin/photoprism up -d
ExecStop=/opt/photoprism/bin/photoprism down

[Install]
WantedBy=multi-user.target


