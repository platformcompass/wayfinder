#!/usr/bin/env bash
set -o errexit

cluster_name="wayfinder"
reg_name='kind-registry'

kind delete cluster --name ${cluster_name}

docker rm -f ${reg_name}
