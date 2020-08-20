#!/bin/bash

#helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
#helm repo update

source ./.env

kubectl create namespace $NAMESPACE

#helm install rancher-latest/rancher \
helm install . \
  --namespace $NAMESPACE \
  --name $RELEASE \
  --values values.yaml
