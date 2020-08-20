source ./.env

kubectl create ns $NAMESPACE

helm install stable/docker-registry \
     --name $RELEASE \
     --namespace $NAMESPACE \
     --values values.yaml
