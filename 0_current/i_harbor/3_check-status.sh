#!/bin/bash
source ./.env

helm status $RELEASE -n $NAMESPACE
