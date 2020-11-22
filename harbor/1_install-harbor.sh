#!/bin/bash

#Please set --with-notary if needs enable Notary in Harbor, and set ui_url_protocol/ssl_cert/ssl_cert_key in harbor.yml bacause notary must run under https.
#Please set --with-clair if needs enable Clair in Harbor
#Please set --with-trivy if needs enable Trivy in Harbor
#Please set --with-chartmuseum if needs enable Chartmuseum in Harbor

./install.sh --with-notary --with-clair --with-trivy --with-chartmuseum
