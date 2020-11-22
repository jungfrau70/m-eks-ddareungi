#!/bin/bash

source .env

cat << EOF | kubectl delete -f -
---
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: harbor-gateway
  namespace: $NAMESPACE
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 80
      name: http-harbor
      protocol: HTTP
    hosts:
    - $HOSTNAME
  - port:
      number: 443
      name: https-harbor
      protocol: HTTPS
    hosts:
    - $HOSTNAME
    - $NOTARY_HOSTNAME
    tls:
      mode: PASSTHROUGH
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: harbor-http-virtual-service
  namespace: $NAMESPACE
spec:
  hosts:
  - $HOSTNAME
  gateways:
  - harbor-gateway
  http:
  - match:
    - port: 80
    route:
    - destination:
        host: harbor.$NAMESPACE.svc.cluster.local
        port:
          number: 80
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: harbor-https-virtual-service
  namespace: $NAMESPACE
spec:
  hosts:
  - $HOSTNAME
  gateways:
  - harbor-gateway
  tls:
  - match:
    - port: 443
      sniHosts:
      - $HOSTNAME
    route:
    - destination:
        host: harbor.$NAMESPACE.svc.cluster.local
        port:
          number: 443
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: harbor-notary-virtual-service
  namespace: $NAMESPACE
spec:
  hosts:
  - $NOTARY_HOSTNAME
  gateways:
  - harbor-gateway
  tls:
  - match:
    - port: 443
      sniHosts:
      - $NOTARY_HOSTNAME
    route:
    - destination:
        host: harbor.$NAMESPACE.svc.cluster.local
        port:
          number: 4443
---
EOF
