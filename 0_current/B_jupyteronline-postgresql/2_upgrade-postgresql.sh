#!/bin/bash

source ./.env

helm upgrade $RELEASE . \
	--namespace $NAMESPACE \
	--values values.yaml
#helm upgrade --install $POSTGRES_RELEASE stable/postgresql --namespace $NAMESPACE --values ./postgresql/values.yaml --timeout 1200

