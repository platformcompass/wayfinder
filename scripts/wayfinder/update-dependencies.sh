#!/usr/bin/env bash
set -o errexit

helm dep update --debug ../../chart
