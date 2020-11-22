#!/bin/bash

source .env

cat << EOF | kubectl apply -f -
---
apiVersion: networking.k8s.io/v1beta1
#apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  namespace: $NAMESPACE
  name: ingress-lma-kibana
  annotations:
    kubernetes.io/ingress.class: nginx
    cert-manager.io/cluster-issuer: letsencrypt-prod-nginx
    kubernetes.io/tls-acme: "true"
    nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
    nginx.ingress.kubernetes.io/ssl-passthrough: "true"
    #ingress.kubernetes.io/ssl-redirect: "true"

spec:
  tls:
  # Replace the placeholder with your domain name (e.g. ingress.dev.blog.shoot.canary.k8s-hana.ondemand.com)
  - hosts:
    - lma.jupyterbook.com
    secretName: nginx-lma-kibana-prod-secret
  rules:
    # Replace the placeholder with your domain name (e.g. ingress.dev.blog.shoot.canary.k8s-hana.ondemand.com)
    - host: lma.jupyterbook.com
      http:
        paths:
          - path: /
            backend:
              serviceName: lma-kibana-kibana
              servicePort: 5601
---
EOF
