#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

helm repo add cetic https://cetic.github.io/helm-charts
helm repo update

cd chart
helm install $RELEASE cetic/phpldapadmin \
  --namespace $NAMESPACE  \
  --values values.yaml
