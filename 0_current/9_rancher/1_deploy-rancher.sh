#!/bin/bash

#helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
#helm repo update

source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

cd chart
#helm install rancher-latest/rancher \
helm install $RELEASE . \
  --namespace $NAMESPACE \
  --values values.yaml
