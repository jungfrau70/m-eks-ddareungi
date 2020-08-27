#!/bin/bash
source ./.env

cd chart
helm install $RELEASE stable/openldap \
     --namespace $NAMESPACE \
     --values values.yaml
