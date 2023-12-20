#!/usr/bin/env bash
set -o errexit

helm template daytrip ../../chart --namespace wayfinder --set GitOps.Flux.enabled=true --set render-subcharts=false --set komodorAgent.apiKey=$KOMOKW_API_KEY --set komodorAgent.clusterName=wayfinder-demo --debug  | tee  out/render-gitops.yaml