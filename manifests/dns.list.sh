#!/bin/bash
CNTNAME=$(kubectl get pods -o json | jq -r '.items[] | select(.metadata.name | contains("dns")).metadata.name')
kubectl exec -it ${CNTNAME} -- bind-cli zone.list
