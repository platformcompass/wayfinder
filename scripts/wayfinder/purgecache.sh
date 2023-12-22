#!/usr/bin/env bash

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

# Remove the old Chart.lock
rm -rf ${script_dir}/../../chart/Chart.lock

# Remove the old charts directory
rm -rf ${script_dir}/../../chart/charts/