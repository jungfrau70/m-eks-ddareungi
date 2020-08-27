#!/bin/bash

source ./.env

kubectl create ns $NAMESPACE

cd chart
helm install $RELEASE . \
       --namespace $NAMESPACE \
       --values values.yaml
