#!/bin/bash
VERSION=1.0.1
cd client
docker build -t binderhubonline/flask-client:$VERSION .
docker push binderhubonline/flask-client:$VERSION
