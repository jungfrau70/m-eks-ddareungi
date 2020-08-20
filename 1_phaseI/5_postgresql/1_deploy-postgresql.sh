source ./.env

kubectl create ns $NAMESPACE

helm upgrade --install $RELEASE . \
       --namespace $NAMESPACE \
       --values values.yaml
