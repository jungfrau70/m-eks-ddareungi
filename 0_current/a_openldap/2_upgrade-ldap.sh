#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

cd chart
helm upgrade $RELEASE stable/openldap \
     --namespace $NAMESPACE \
     --values values.yaml
