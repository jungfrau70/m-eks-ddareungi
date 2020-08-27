#!/bin/bash

source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/v0.13.0/deploy/manifests/00-crds.yaml

helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install \
  cert-manager \
  jetstack/cert-manager \
  --namespace cert-manager \
  --version v0.13.0 
