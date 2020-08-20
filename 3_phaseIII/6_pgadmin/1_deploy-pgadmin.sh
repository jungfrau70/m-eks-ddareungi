#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

helm repo add cetic https://cetic.github.io/helm-charts
helm repo update

kubectl create ns $NAMESPACE

cd chart
helm install . \
  --name $RELEASE \
  --namespace $NAMESPACE \
  --version 0.1.9 --wait \
  --set pgadmin.password="admin" \
  --set pgadmin.tls="false" \
  --set pgadmin.username="admin" \
  --set servers.config.Servers.1.Group="Servers" \
  --set servers.config.Servers.1.Host="pgsql.${MY_DOMAIN}" \
  --set servers.config.Servers.1.MaintenanceDB="postgres" \
  --set servers.config.Servers.1.Name="Patroni PGSQL - external" \
  --set servers.config.Servers.1.Port="5432" \
  --set servers.config.Servers.1.SSLMode="prefer" \
  --set servers.config.Servers.1.Username="postgres" \
  --set servers.config.Servers.2.Group="Servers" \
  --set servers.config.Servers.2.Host="patroni.patroni.svc.cluster.local" \
  --set servers.config.Servers.2.MaintenanceDB="postgres" \
  --set servers.config.Servers.2.Name="Patroni PGSQL - internal" \
  --set servers.config.Servers.2.Port="5432" \
  --set servers.config.Servers.2.SSLMode="prefer" \
  --set servers.config.Servers.2.Username="postgres" \
  --set servers.enabled="true" \
  --set service.type="ClusterIP"

  #--set service.type="ClusterIP"
  #--values values.yaml
  #--set persistence.enabled="false" 

kubectl apply -f ../istio-pgadmin.yaml
