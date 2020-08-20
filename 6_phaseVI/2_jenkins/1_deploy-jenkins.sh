#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

kubectl create ns $NAMESPACE

cd chart
helm install . \
  --name $RELEASE \
  --namespace $NAMESPACE \
  --values values.yaml
