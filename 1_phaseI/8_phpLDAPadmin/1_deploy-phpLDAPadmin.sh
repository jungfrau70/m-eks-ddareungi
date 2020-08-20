#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

helm repo add cetic https://cetic.github.io/helm-charts
helm repo update
kubectl create ns $NAMESPACE

helm install --name $RELEASE cetic/phpldapadmin \
  --namespace $NAMESPACE  \
  --values values.yaml
