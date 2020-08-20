#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

helm repo add elastic https://helm.elastic.co
helm repo update

kubectl create ns $NAMESPACE

cd elastic-helm/elasticsearch
helm install . \
  --name $RELEASE \
  --namespace $NAMESPACE \
  --set imageTag=7.6.2 \
  --values values.yaml
