#!/bin/bash

ls Initial.ldif
kubectl cp Initial.ldif auth/ldap-openldap-86894c68bb-d2zt4:.
kubectl -n auth exec -it ldap-openldap-86894c68bb-d2zt4 -- bash

# Inside Pod
ldapadd -x -W -H ldap://ldap-openldap.auth.svc.cluster.local:389 -D "cn=admin,dc=jupyteronline,dc=com" -f Initial.ldif
