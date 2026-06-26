FROM mcr.microsoft.com/devcontainers/python:3.12

# Install OS packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl unzip \
    && rm -rf /var/lib/apt/lists/*

# Google Cloud CLI.
# Pinned for reproducible builds — bump CLOUD_SDK_VERSION to upgrade.
# Download, extract, install and clean up in a single layer so the ~150 MB
# tarball and installer backups never persist in the image history.
ARG CLOUD_SDK_VERSION=574.0.0
ENV CLOUD_SDK_HOME=/opt/google-cloud-sdk
RUN set -eux; \
    arch="$(uname -m)"; \
    case "${arch}" in \
        x86_64) sdk_arch="x86_64" ;; \
        aarch64 | arm64) sdk_arch="arm" ;; \
        *) echo "Unsupported architecture: ${arch}" >&2; exit 1 ;; \
    esac; \
    curl -fsSL -o /tmp/gcloud.tar.gz \
        "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${CLOUD_SDK_VERSION}-linux-${sdk_arch}.tar.gz"; \
    tar -xzf /tmp/gcloud.tar.gz -C /opt; \
    rm /tmp/gcloud.tar.gz; \
    "${CLOUD_SDK_HOME}/install.sh" \
        --quiet \
        --path-update=false \
        --usage-reporting=false \
        --command-completion=false; \
    rm -rf "${CLOUD_SDK_HOME}/.install/.backup"

ENV PATH="${CLOUD_SDK_HOME}/bin:${PATH}"
