# Wayfinder

## Summary

Wayfinder is a toolkit for curating, testing, and deploying collections of platform capabilities to a Kubernetes cluster in a proven GitOps manner.

Wayfinder publishes a Helm Chart which installs a named collection of dependent Helm Charts to a Kubernetes cluster. We call a named collection of charts with their pre-tested configuration a voyage.

Wayfinder lets you spin up a local dev environment using Docker and Kubernetes KIND in under five minutes to test your voyages.

## Intended Audience

- Platform Engineering teams needing a proven methodology for delivering a “batteries included” Kubernetes service offering.
- Kubernetes administrators or individual developers running Kubernetes clusters who want to follow a “paved path” for base component deployments.
- Contributors wanting to share “known good” collection configurations that satisfy a contextual need such as air-gapped environments, cloud-hosted clusters, dev/prod cluster differences, etc.

## Acknowledgements

Thanks the great work of [Stefan Prodan's](https://github.com/stefanprodan) 🙌 ❤️ [flux-local-dev](https://github.com/stefanprodan/flux-local-dev/blob/main/README.md) for inspiring many patterns and scripts used in Wayfinder.
