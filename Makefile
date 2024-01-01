# Wayfinder local dev environment with Docker and Kubernetes KIND
# Requirements:
# - Docker
# - Homebrew

REPO_ROOT := $(shell git rev-parse --show-toplevel)
BUILD_DIR := $(REPO_ROOT)/build

.POSIX:
.EXPORT_ALL_VARIABLES:

.PHONY: up
up: cluster-up flux-push flux-up ## Create the local cluster and registry, install Flux and the cluster addons
	kubectl -n flux-system wait kustomization/cluster-sync --for=condition=ready --timeout=5m
	kubectl -n flux-system wait kustomization/apps-sync --for=condition=ready --timeout=5m

.PHONY: down
down: cluster-down ## Delete the local cluster and registry

.PHONY: sync
sync: flux-push ## Build, push and reconcile the manifests
	flux reconcile ks cluster-sync --with-source
	flux reconcile ks apps-sync --with-source

.PHONY: check
check: ## Check if the NGINX ingress self-signed TLS works
	curl --insecure https://podinfo.flux.local

.PHONY: tools
tools: ## Install Kubernetes kind, kubectl, FLux CLI and other tools with Homebrew
	brew bundle

.PHONY: validate
validate: ## Validate the Kubernetes manifests (including Flux custom resources)
	scripts/test/validate.sh

.PHONY: cluster-up
cluster-up:
	scripts/kind/up.sh

.PHONY: cluster-down
cluster-down:
	scripts/kind/down.sh

.PHONY: flux-up
flux-up:
	scripts/flux/up.sh

.PHONY: flux-down
flux-down:
	scripts/flux/down.sh

.PHONY: flux-push
flux-push:
	scripts/flux/push.sh

.PHONY: chart
chart:
	@cd scripts/wayfinder && ./chartgen.sh $(ARGS)

.PHONY: full
full:
	@cd scripts/wayfinder && ./render-full.sh $(ARGS)

.PHONY: gitops
gitops:
	@cd scripts/wayfinder && ./render-gitops.sh $(ARGS)

.PHONY: sops
sops:
	@cd scripts/wayfinder && ./setup-encryption.sh $(ARGS)

.PHONY: echo
echo:
	@cd scripts/wayfinder && ./echo.sh  $(ARGS)

.PHONY: help
help:  ## Display this help menu
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: all
all: vet fmt

.PHONY: vet
vet:
	# @cue vet ./... -c
	@cue vet ./pkg/... -c
	@cue vet ./generators/... -c
	# @cue vet ./tools/... -c

.PHONE: fmt
fmt:
	@cue fmt ./...
	@cue fmt ./pkg/...
	@cue fmt ./generators/...
	@cue fmt ./tools/...

.PHONY: mod
mod:
	go get -u k8s.io/api/...
	cue get go k8s.io/api/...
	go get -u github.com/fluxcd/source-controller/api/v1beta2
	cue get go github.com/fluxcd/source-controller/api/v1beta2
	go get -u github.com/fluxcd/kustomize-controller/api/v1beta2
	cue get go github.com/fluxcd/kustomize-controller/api/v1beta2
	go get -u github.com/fluxcd/notification-controller/api/v1beta1
	cue get go github.com/fluxcd/notification-controller/api/v1beta1
	go get -u github.com/fluxcd/helm-controller/api/v2beta1
	cue get go github.com/fluxcd/helm-controller/api/v2beta1
	go get -u github.com/fluxcd/image-reflector-controller/api/v1beta1
	cue get go github.com/fluxcd/image-reflector-controller/api/v1beta1
	go get -u github.com/fluxcd/image-automation-controller/api/v1beta1
	cue get go github.com/fluxcd/image-automation-controller/api/v1beta1

.PHONY: cue-push
cue-push: ## Push the CUE generated manifests to the registry
	scripts/flux/push-cue.sh minnow staging
	scripts/flux/push-cue.sh minnow production
