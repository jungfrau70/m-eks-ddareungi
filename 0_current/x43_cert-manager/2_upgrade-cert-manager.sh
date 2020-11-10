#!/bin/bash

source ./.env

helm repo add jetstack https://charts.jetstack.io
helm repo update

cd chart
helm upgrade $RELEASE . \
  --namespace $NAMESPACE  \
  --version v0.13.0 \
  --values values.yaml

