#!/bin/bash
source ./.env

helm install stable/openldap \
     --name $RELEASE \
     --namespace $NAMESPACE \
     --values values.yaml
