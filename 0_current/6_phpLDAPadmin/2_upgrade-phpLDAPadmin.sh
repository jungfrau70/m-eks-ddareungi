#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

cd chart
helm upgrade $RELEASE cetic/phpldapadmin \
  --namespace $NAMESPACE  \
  --values values.yaml
