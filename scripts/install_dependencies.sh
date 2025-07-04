#!/bin/bash

# Install gcloud CLI
apt-get update && apt-get install -y curl unzip gnupg

echo "Installing gcloud CLI..."
curl -sSL https://sdk.cloud.google.com | bash
exec -l $SHELL
gcloud init

# Install Python dependencies
pip3 install --user -r requirements.txt

# Set up dbt folder
mkdir -p ~/.dbt/
