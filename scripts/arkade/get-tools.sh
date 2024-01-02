# Multi-platform tool install via arkade: https://github.com/alexellis/arkade
ark get kubectl
ark get kind
ark get yq
ark get jq
ark get helm
ark get kustomize
ark get kubeconform
ark get gomplate
ark get flux
ark get sops
ark get cosign

# TODO: Add version constraints for deterministic installs

# TODO: Add these tools to arkade registry as needed
# # KUbernetes Test TooL (kuttl)
# tap "kudobuilder/tap"
# brew "kuttl-cli"

# # YAML tools
# brew "yamllint"
# brew "homeport/tap/dyff"

# # OCI tools
# brew "oras"

# # Flux
# tap "fluxcd/tap"
# brew "fluxcd/tap/flux"

# # Encryption
# brew "age"
