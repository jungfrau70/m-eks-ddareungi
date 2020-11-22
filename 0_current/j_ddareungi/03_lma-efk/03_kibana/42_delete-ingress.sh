#!/bin/bash

source .env

cat << EOF | kubectl delete -f -
---
apiVersion: networking.k8s.io/v1beta1
#apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  namespace: $NAMESPACE
  name: ingress-lma-kibana
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
spec:
  rules:
    - http:
        paths:
          - path: /*
            backend:
              serviceName: lma-kibana
              servicePort: 5601
---
EOF
