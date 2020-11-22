#!/bin/bash

# Generate a Certificate Authority Certificate
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -sha512 -days 3650 \
	-subj "/C=KR/ST=Seoul/L=Seoul/O=kubeflow/OU=Platform/CN=jupyterbook.com" \
	-key ca.key \
	-out ca.crt

# Generate a Server Certificate
openssl genrsa -out jupyterbook.com.key 4096
openssl req -sha512 -new \
	-subj "/C=KR/ST=Seoul/L=Seoul/O=kubeflow/OU=Platform/CN=jupyterbook.com" \
	-key jupyterbook.com.key \
	-out jupyterbook.com.csr
cat > v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=harbor.jupyterbook.com
DNS.2=jupyterbook.com
DNS.3=localhost
EOF
openssl x509 -req -sha512 -days 3650 \
    -extfile v3.ext \
    -CA ca.crt -CAkey ca.key -CAcreateserial \
    -in jupyterbook.com.csr \
    -out jupyterbook.com.crt

#Provide the Certificates to Harbor and Docker
mkdir -p /data/cert
cp jupyterbook.com.crt /data/cert/
cp jupyterbook.com.key /data/cert/
openssl x509 -inform PEM -in jupyterbook.com.crt -out jupyterbook.com.cert
mkdir -p /etc/docker/certs.d/harbor.jupyterbook.com/
cp jupyterbook.com.cert /etc/docker/certs.d/harbor.jupyterbook.com/
cp jupyterbook.com.key /etc/docker/certs.d/harbor.jupyterbook.com/
cp ca.crt /etc/docker/certs.d/harbor.jupyterbook.com/

