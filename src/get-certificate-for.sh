#!/bin/bash

domain_name=$1
wildcard=$2
dirName="$domain_name-certificate"

if [ "$wildcard" = "true" ]; then
  cert_domain_name="*.$domain_name"
else
  cert_domain_name=$domain_name
fi

mkdir -p $dirName/miscFiles

# Generate certificate signing request
# openssl req -new -newkey rsa:2048 -nodes -keyout ./$dirName/miscFiles/$cert_domain_name.key -out ./$dirName/miscFiles/$cert_domain_name.csr

# Generate self-signed certificate
sudo certbot certonly --manual --preferred-challenges=dns -d $cert_domain_name

sleep 5

# Copy cert and key
sudo cp /etc/letsencrypt/live/${cert_domain_name#\*.}/{fullchain.pem,privkey.pem} ./$dirName