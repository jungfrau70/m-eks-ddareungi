#!/bin/bash

kubectl -n kubeflow get deploy tensorboard -o yaml > tensorboard.yaml
kubectl delete -f tensorboard.yaml
