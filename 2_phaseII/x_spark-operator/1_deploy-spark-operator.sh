source ./.env

kubectl create ns $NAMESPACE

helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
helm repo update

helm install incubator/sparkoperator \
	--name spark-operator \
	--namespace $NAMESPACE \
      --set sparkJobNamespace=default \
      --set enableWebhook=true
    #    --set operatorVersion=latest

kubectl create serviceaccount spark
kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=default:spark --namespace=default
