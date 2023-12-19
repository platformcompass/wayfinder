#!/usr/bin/env bash
set -o errexit

helm template daytrip ../../chart --namespace wayfinder --set GitOps.Flux.enabled=true --set render-subcharts=false --set komodor-agent.apiKey=$KOMOKW_API_KEY --set komodor-agent.clusterName=wayfinder-demo --debug  | tee  out/render-gitops.yaml