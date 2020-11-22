#!/bin/bash
source ./.env
watch kubectl -n $NAMESPACE get po,svc,ing
