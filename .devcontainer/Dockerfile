FROM mcr.microsoft.com/devcontainers/python:3.12

# Install OS packages
RUN apt-get update && apt-get install -y curl unzip && rm -rf /var/lib/apt/lists/*

# Google Cloud SDK
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
RUN tar -xf google-cloud-cli-linux-x86_64.tar.gz && rm google-cloud-cli-linux-x86_64.tar.gz
RUN ./google-cloud-sdk/install.sh --quiet
ENV PATH="/google-cloud-sdk/bin:${PATH}"

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt