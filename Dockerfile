FROM debian:stable-slim

ARG KUBENT_VERSION=0.7.3
ARG CUE_VERSION=v0.11.0
# ARG UID=1001
# ARG GID=1002
ARG HOME=/root

RUN apt-get update \
  && apt-get install -y \
  build-essential \
  curl \
  git \
  net-tools \
  sudo \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Kubent
RUN curl -LO https://github.com/doitintl/kube-no-trouble/releases/download/${KUBENT_VERSION}/kubent-${KUBENT_VERSION}-linux-amd64.tar.gz \
  && tar xzf kubent-${KUBENT_VERSION}-linux-amd64.tar.gz \
  && mv kubent /usr/local/bin/kubent \
  && chmod +x /usr/local/bin/kubent

RUN curl -sLS https://get.arkade.dev | sh

RUN curl -LO https://github.com/cue-lang/cue/releases/download/${CUE_VERSION}/cue_${CUE_VERSION}_linux_amd64.tar.gz \
  && tar xzf cue_${CUE_VERSION}_linux_amd64.tar.gz \
  && chmod +x cue \
  && mv cue /usr/local/bin/cue

# Create a non-root user and group
# RUN groupadd -g ${GID} nonroot && \
#     useradd -l -m -u ${UID} -g nonroot -s /bin/bash nonroot && \
#     echo 'nonroot ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
#     usermod -aG sudo nonroot

# # Set the working directory
# WORKDIR /home/nonroot/

# # Switch to the non-root user
# USER nonroot

# Default command
CMD ["bash"]    

RUN arkade get cosign \  
  flux \
  gh \
  gomplate \
  helm \
  hey \
  jq \
  krew \  
  kubectl \  
  kustomize \
  kubescape \
  kyverno \  
  sops \  
  vcluster \
  yq \
  --quiet

# move arkade installed binaries to /usr/local/bin for better pipeline support running as non-root
# use chmod to allow all users to read and execute files in /root/.arkade/bin
RUN ls $HOME/.arkade/bin > arkade-binaries.txt && chmod -R 755 $HOME/.arkade/bin && sudo mv $HOME/.arkade/bin/* /usr/local/bin
RUN krew install kuttl && sudo mv $HOME/.krew/bin/* /usr/local/bin

# Download Kubescape Artifacts
RUN kubescape download artifacts && sudo mkdir /kubescape && sudo cp .kubescape/* /kubescape

RUN git config --global --add safe.directory /work