#!/bin/bash
source ./.env

helm -n $NAMESPACE delete $RELEASE
