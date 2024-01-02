#!/usr/bin/env bash
set -o errexit
# set -x

voyage=$1
environment=$2 # production | staging
artifact_name="wayfinder/voyages/${environment}/${voyage}"
cluster_name='local'
registry='localhost:5050'
cue_dist=".wayfinder/dist"  # path for generated contents
cue_remote=".wayfinder/remote"    # path to store last remote artifact contents

diff_push() {
  artifact_name=$1
  cue_dist=$2
  mkdir -p ${cue_remote}/${artifact_name}
  flux pull artifact oci://${registry}/${artifact_name}:${cluster_name} \
    -o ${cue_remote}/${artifact_name} &>/dev/null || mkdir -p ${cue_remote}
  if [[ $(git diff --no-index --stat ${cue_dist}/${artifact_name} ${cue_remote}/${artifact_name} ) != '' ]]; then
    flux push artifact oci://${registry}/${artifact_name}:${cluster_name} \
      --path="${cue_dist}/${artifact_name}" \
      --source="$(git config --get remote.origin.url)" \
      --revision="$(git rev-parse HEAD)"
  else
    echo "✔ no changes detected in the apps manifests"
  fi
  # rm -rf ${cue_remote}
}

cd specs/voyages/${voyage}
mkdir -p ${cue_dist}/${artifact_name}
cue build -t $environment > "${cue_dist}/${artifact_name}/manifests.yaml"
diff_push ${artifact_name} ${cue_dist}
# rm -rf ${cue_dist}
