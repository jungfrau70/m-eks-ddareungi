#!/bin/bash

source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

cd chart
helm install $RELEASE . \
       --namespace $NAMESPACE \
       --values values.yaml
