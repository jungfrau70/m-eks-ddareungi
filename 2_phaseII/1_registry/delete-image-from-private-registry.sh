#!/bin/bash
curl -u admin:2020@alpha -X GET https://docker.jupyteronline.com/v2/_catalog
curl -u admin:2020@alpha -X GET https://docker.jupyteronline.com/v2/jupyteronline-2dbinder-5fexample-5f1-b6dcb4/tags/list
curl -u admin:2020@alpha -X GET https://docker.jupyteronline.com/v2/jupyteronline-2dbinder-5fexample-5f1-b6dcb4/manifests/0301cd7ec31ec30cd1f5f97eb34b86f986008f4e 2>&1 | grep Docker-Content-Digest | awk '{print ($3)}'

