#!/bin/bash
VERSION=1.0.3
cd dash
docker build -t binderhubonline/dash:$VERSION .
docker push binderhubonline/dash:$VERSION
