#lxc deb12 unpriv nesting
#curl https://raw.githubusercontent.com/fishbone222/OS-prepair/main/debian/12/docker.sh | bash
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common vim curl nmap htop wget
apt remove -y nano
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
apt-get install docker-ce docker-ce-cli containerd.io nginx -y
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
