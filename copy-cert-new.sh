domain=$(hostname -d)

scp certificate@opnsense.$domain:/var/etc/acme-client/cert-home/*/\*.$domain/fullchain.cer /tmp/cert.pem
diff /tmp/cert.pem /etc/pki/nginx/server.crt > /dev/null
if [ $? -eq 0 ]; then
        echo "Cert not due to renewal"
        exit 0
fi
scp certificate@opnsense.$domain:/var/etc/acme-client/cert-home/*/\*.$domain/fullchain.cer /etc/pki/nginx/server.crt
scp certificate@opnsense.$domain:/var/etc/acme-client/cert-home/*/\*.$domain/*.key /etc/pki/nginx/private/server.key
systemctl reload nginx
