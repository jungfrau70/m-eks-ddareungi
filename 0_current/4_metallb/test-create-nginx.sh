#!/bin/bash
kubectl create deploy nginx --image=nginx
kubectl expose deploy nginx --port 80 --type LoadBalancer

