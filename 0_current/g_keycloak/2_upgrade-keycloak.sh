#!/bin/bash
source ./.env

helm upgrade $RELEASE . \
        --namespace $NAMESPACE \
	--values values.yaml
