#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

helm repo add harbor https://helm.goharbor.io
helm repo update

kubectl create ns $NAMESPACE

cd chart
helm install $RELEASE . \
  --namespace $NAMESPACE \
  --values values.yaml
