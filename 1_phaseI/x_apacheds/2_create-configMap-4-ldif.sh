#!/bin/bash

kubectl create configmap -n sso apacheds-ldif \
                        --from-file=./config/data.ldif
