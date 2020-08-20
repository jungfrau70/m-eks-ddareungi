#!/bin/bash
docker build -t binderhubonline/flask-www:1.0.8 .
docker push binderhubonline/flask-www:1.0.8
