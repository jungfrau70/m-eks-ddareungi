#!/bin/bash
source ./.env

helm upgrade $RELEASE stable/docker-registry \
     --namespace $NAMESPACE \
     --values values.yaml
