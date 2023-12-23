# Wayfinder

![Wayfinder Logo](docs/img/wayfinder_200.png)

## Summary

Wayfinder is a toolkit for curating, testing, and deploying collections of platform capabilities to a Kubernetes cluster in a proven GitOps manner.

Wayfinder publishes a Helm Chart which installs a named collection of dependent Helm Charts to a Kubernetes cluster. We call a named collection of charts with their pre-tested configuration a voyage.

Wayfinder lets you spin up a local dev environment using Docker and Kubernetes KIND in under five minutes to test your voyages.

## Intended Audience

- Platform Engineering teams needing a proven methodology for delivering a “batteries included” Kubernetes service offering.
- Kubernetes administrators or individual developers running Kubernetes clusters who want to follow a “paved path” for base component deployments.
- Contributors wanting to share “known good” collection configurations that satisfy a contextual need such as air-gapped environments, cloud-hosted clusters, dev/prod cluster differences, etc.

## How does it work?

This project spins up a Docker Registry container named `kind-registry` and a Kubernetes Kind cluster
named `flux` under the same Docker network. Then it installs Flux and configures it to upgrade itself
from the latest OCI artifact published at `ghcr.io/fluxcd/flux-manifests`. Before an upgrade, Flux
verifies that the OCI artifacts are signed by the Flux team with Cosign and GitHub OIDC.

| Component                                                                                                | Role                            | Host                        |
|----------------------------------------------------------------------------------------------------------|---------------------------------|-----------------------------|
| [Kubernetes KIND](https://kind.sigs.k8s.io/)                                                             | Local cluster                   | Binds to port 80 and 443    |
| [Docker Registry](https://docs.docker.com/registry/)                                                     | Local registry                  | Binds to port 5050          |
| [Flux](https://fluxcd.io)                                                                                | Cluster reconciler              | -                           |
| [ingress-nginx](https://github.com/kubernetes/ingress-nginx)                                             | Ingress for `*.flux.local`      | -                           |
| [cert-manager](https://github.com/cert-manager/cert-manager)                                             | Self-signed ingress certs       | -                           |
| [metrics-server](https://github.com/kubernetes-sigs/metrics-server)                                      | Container resource metrics      | -                           |
| [kube-prometheus-stack](https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack) | Prometheus Operator and Grafana | Binds to grafana.flux.local |
| [weave-gitops](https://github.com/weaveworks/weave-gitops)                                               | Flux UI                         | Binds to ui.flux.local      |
| [podinfo](https://github.com/stefanprodan/podinfo)                                                       | Demo app                        | Binds to podinfo.flux.local |

The Docker registry is exposed on the local machine on `localhost:5050` and inside the cluster
on `kind-registry:5000`. The registry servers two purposes:
- hosts container images e.g. `docker push localhost:5050/podinfo:test1`
- hosts OCI artifacts e.g. `flux push artifact oci://localhost:5050/podinfo-manifests:test1`

To facilitate ingress access to the Flux UI and any other
application running inside the cluster, the Kubernetes Kind container
binds to port `80` and `443` on localhost.
Ingress is handled by Kubernetes ingress-nginx and self-signed TLS certs
are provided by cert-manager.

To monitor how the deployed applications perform on the cluster,
the kube-prometheus-stack and metrics-server Helm charts are installed at
bootstrap along with the Flux Grafana dashboards.

To monitor and debug Flux using a Web UI, the Weave GitOps Helm chart is
installed at bootstrap.


## How to get started?

### Prerequisites

Start by cloning the repository locally:

```shell
git clone https://github.com/bobmhong/wayfinder.git
cd wayfinder
```

Install Kubernetes kind, kubectl, flux and other CLI tools with Homebrew:

```shell
make tools
```

The complete list of tools can be found in the `Brewfile`.

Note that the minimum required version of Flux is `v2.0.0-rc.1`.

### Bootstrap

Start the dev environment with:

```shell
make up
```

The `make up` command performs the following steps:
- creates the Docker registry container if it's not already running
- creates the Kubernetes Kind cluster if it's not already running
- pushes the Kubernetes manifests as OCI artifacts to the local registry
  - `locahost:5050/flux-cluster-sync` is generated from `kubernetes/clusters/local`
  - `locahost:5050/flux-infra-sync` is generated from `kubernetes/infra`
  - `locahost:5050/flux-apps-sync` is generated from `kubernetes/apps`
- installs Flux on the clusters and configures it to self upgrade from `oci://ghcr.io/fluxcd/flux-manifests`
- waits for Flux to reconcile the cluster addons from `oci://kind-registry:5000/flux-infra-sync`
- waits for Flux to reconcile the demo apps from `oci://kind-registry:5000/flux-apps-sync`

### Access Flux UI

![flux-ui](docs/img/weave-gitops.png)

Add the following domains to `/etc/hosts`:

```txt
127.0.0.1 podinfo.flux.local
127.0.0.1 grafana.flux.local
127.0.0.1 ui.flux.local
```

Verify that the NGINX ingress self-signed TLS works:

```shell
make check
```

Access the Flux UI and Grafana using the username `admin` and password `flux`:

- [http://ui.flux.local/applications](http://ui.flux.local/applications)
- [http://grafana.flux.local/d/flux-control-plane](http://grafana.flux.local/d/flux-control-plane/flux-control-plane?orgId=1&refresh=10s) (username: admin, password: flux)
- [http://grafana.flux.local/d/flux-cluster](http://grafana.flux.local/d/flux-cluster/flux-cluster-stats?orgId=1&refresh=10s)

Access the demo application on [http://podinfo.flux.local](http://podinfo.flux.local/).

### Sync local changes

Add a label to the `apps` namespace definition:

```shell
yq eval '.metadata.labels.env="dev"' -i ./kubernetes/apps/namespace.yaml
```

Validate the Kubernetes manifests and Flux custom resources:

```shell
make validate
```

Push the changes to the local registry with:

```shell
make sync
```

Verify that Flux has reconciled the namespace:

```shell
kubectl get ns apps --show-labels
```

### Teardown

Delete the registry and the Kubernetes cluster with:

```shell
make down
```

## Acknowledgements

Thanks the great work of [Stefan Prodan's](https://github.com/stefanprodan) 🙌 ❤️ [flux-local-dev](https://github.com/stefanprodan/flux-local-dev/blob/main/README.md) for inspiring many patterns and scripts used in Wayfinder.
