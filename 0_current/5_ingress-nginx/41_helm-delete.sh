#!/bin/bash
source ./.env

helm delete -n $NAMESPACE $RELEASE
