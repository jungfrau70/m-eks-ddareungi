#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env
#helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
#helm repo update
#kubectl create ns $NAMESPACE

cd chart
helm upgrade $RELEASE . \
    --namespace $NAMESPACE  \
    --set replicaCount="5" \
    --values values.yaml
