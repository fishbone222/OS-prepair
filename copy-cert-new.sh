domain=$(hostname -d)

scp -4 certificate@opnsense.$domain:/var/etc/acme-client/cert-home/*/\*.$domain/fullchain.cer /tmp/cert.pem
diff /tmp/cert.pem /etc/pki/nginx/server.crt > /dev/null
if [ $? -eq 0 ]; then
        echo "Cert not due to renewal"
        exit 0
fi
scp -4 certificate@opnsense.$domain:/var/etc/acme-client/cert-home/*/\*.$domain/fullchain.cer /etc/pki/nginx/server.crt
scp -4 certificate@opnsense.$domain:/var/etc/acme-client/cert-home/*/\*.$domain/*$domain.cer /etc/pki/nginx/server.single.crt
scp -4 certificate@opnsense.$domain:/var/etc/acme-client/cert-home/*/\*.$domain/*.key /etc/pki/nginx/private/server.key
scp -4 certificate@opnsense.$domain:/var/etc/acme-client/cert-home/*/\*.$domain/ca.cer /etc/pki/nginx/private/ca.crt
systemctl reload nginx
