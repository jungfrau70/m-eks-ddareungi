#!/bin/bash
source ./.env
watch kubectl get po,svc,ing -A
