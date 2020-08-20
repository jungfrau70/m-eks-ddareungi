#/bin/bash
kubectl create secret docker-registry docker-registry-users \
       --namespace=docker-registry \
       --docker-server=docker.jupyteronline.com \
       --docker-username=admin \
       --docker-password="2020@alpha" \
       --docker-email=jupyteronline@gmail.com
