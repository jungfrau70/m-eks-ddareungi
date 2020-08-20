#!/bin/bash
#curl -k -u 'elastic:secret' https://10.43.160.148:9200/_searchguard/license?pretty
curl -u 'kibanaserver:kibanaserver' https://10.43.156.241:9200/_searchguard/license?pretty --cacert $1
