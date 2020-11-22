#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

cd chart
helm install $RELEASE bitnami/harbor \
    --namespace $NAMESPACE \
    --set expose.ingress.hosts.core=harbor.jupyterbook.com \
    --set expose.ingress.annotations.'kubernetes\.io/ingress\.class'=contour \
    --set expose.ingress.annotations.'certmanager\.k8s\.io/cluster-issuer'=letsencrypt-prod \
    --set externalURL=https://harbor.jupyterbook.com \
    --set expose.tls.secretName=harbor-ingress-cert \
    --set notary.enabled=true # \
    #--values values.yaml
