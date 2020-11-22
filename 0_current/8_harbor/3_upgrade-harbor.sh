#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

cd chart
helm upgrade $RELEASE . \
  --namespace $NAMESPACE \
  --set harborAdminPassword="admin" \
  --values values.yaml
