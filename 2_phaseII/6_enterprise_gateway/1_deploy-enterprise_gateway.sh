#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env
kubectl create ns $NAMESPACE

helm install --name $RELEASE . \
  --namespace $NAMESPACE  \
  --version 2.1.0 \
  --values values.yaml
