#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

cd chart
helm install $RELEASE . \
        --namespace $NAMESPACE \
	--values values.yaml
#  --set service.type=ClusterIP \
#  --set ingress.enabled=true \
#  --set ingress.hosts[0].name=key.jupyteronline.com

#kubectl get secret --namespace sso keycloak-http -o jsonpath="{.data.password}" | base64 --decode; echo

#kubectl apply -f sso-keycloak-ingress.yaml
