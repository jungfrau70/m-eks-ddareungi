#!/bin/bash

source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

#kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/v0.13.0/deploy/manifests/00-crds.yaml

#helm repo add jetstack https://charts.jetstack.io
#helm repo update

cd chart
helm install cert-manager . \
  --namespace $NAMESPACE \
  --version v1.0.1 \
  --set installCRDs=true \
  --values values.yaml
