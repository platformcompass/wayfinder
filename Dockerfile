FROM debian:stable-20231218-slim

RUN apt-get update \
  && apt-get install -y \
  build-essential \
  curl \
  git

RUN curl -sLS https://get.arkade.dev | sh

RUN curl -LO https://github.com/cue-lang/cue/releases/download/v0.7.0/cue_v0.7.0_linux_amd64.tar.gz \
  && tar xzf cue_v0.7.0_linux_amd64.tar.gz \
  && chmod +x cue \
  && mv cue /usr/local/bin/cue

RUN arkade get cosign \
  dagger \
  flux \
  gh \
  gomplate \
  helm \
  hey \
  istioctl \
  jq \
  krew \
  kube-linter \
  kubectl \
  kubeval \
  kustomize \
  kyverno \
  terraform \
  terragrunt \
  terrascan \
  tfsec \
  timoni \
  trivy \
  sops \
  vault \
  vcluster \
  yq

# move arkade installed binaries to /usr/local/bin for better pipeline support running as non-root
# use chmod to allow all users to read and execute files in /root/.arkade/bin
RUN ls /root/.arkade/bin > arkade-binaries.txt && chmod -R 755 /root/.arkade/bin && mv /root/.arkade/bin/* /usr/local/bin
RUN krew install kuttl && mv /root/.krew/bin/* /usr/local/bin
