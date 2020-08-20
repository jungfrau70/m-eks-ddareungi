#!/bin/bash
#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

kubectl create ns $NAMESPACE

cd charts/argo
helm install --name $RELEASE . \
  --namespace $NAMESPACE  \
  --set installCRD=false \
  --values values.yaml
