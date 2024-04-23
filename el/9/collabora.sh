wget https://www.collaboraoffice.com/repos/CollaboraOnline/CODE-centos7/repodata/repomd.xml.key && sudo rpm --import repomd.xml.key
yum config-manager --add-repo https://www.collaboraoffice.com/repos/CollaboraOnline/CODE-rpm
yum install coolwsd CODE-brand -y
cp /tmp/*.key /etc/coolwsd/key.pem
cp /tmp/*.fullchain /etc/coolwsd/cert.pem
cp /tmp/*.ca /etc/coolwsd/ca-chain.cert.pem
systemctl restart coolwsd
