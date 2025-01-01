FROM mcr.microsoft.com/devcontainers/go:1-1.22-bookworm

RUN go version

# renovate: datasource=github-releases depName=kubernetes/kubernetes versioning=kubernetes-api
ARG KUBECTL_VERSION=v1.27.0
RUN cd /usr/local/bin/ && \
    curl -OL https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x kubectl
RUN kubectl version --client=true

# renovate: datasource=github-releases depName=kubernetes-sigs/kustomize
ARG KUSTOMIZE_VERSION=v5.0.3
RUN cd /usr/local/bin/ && \
    curl -OL https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz && \
    tar xf kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz && \
    chmod +x kustomize
RUN kustomize version

# devpod container expects /tmp to exist
RUN mkdir /tmp && chmod 777 /tmp
