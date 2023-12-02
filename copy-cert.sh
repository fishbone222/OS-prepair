domain=$(hostname -d)
scp certificate@pfsense.$domain:/conf/acme/$domain.fullchain /tmp/cert.pem
diff /tmp/cert.pem /etc/pki/nginx/server.crt > /dev/null
if [ $? -eq 0 ]; then
        echo "Cert not due to renewal"
        exit 0
fi
scp certificate@pfsense.$domain:/conf/acme/$domain.fullchain /etc/pki/nginx/server.crt
scp certificate@pfsense.$domain:/conf/acme/$domain.key /etc/pki/nginx/private/server.key
systemctl reload nginx
