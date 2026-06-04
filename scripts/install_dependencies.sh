#!/bin/bash
set -e 

# Install Python dependencies
pip3 install --user -r requirements.txt

# Set up dbt folder
mkdir -p ~/.dbt/

# Copy profiles template if it exists
if [ -f "scripts/example_profiles.yml" ]; then
    cp scripts/example_profiles.yml ~/.dbt/profiles.yml
    echo "✓ dbt profiles.yml copied"
fi

# Auto-load the local .env (DATABRICKS_TOKEN, DBT_SCHEMA) into every terminal.
# .env is git-ignored: create it as described in the README and paste your token.
ENV_FILE="$(pwd)/.env"
if ! grep -q "Load training .env" ~/.bashrc 2>/dev/null; then
    cat >> ~/.bashrc <<EOF

# Load training .env (Databricks token etc.) if present
set -a
[ -f "$ENV_FILE" ] && . "$ENV_FILE"
set +a
EOF
    echo "✓ .env auto-loading added to ~/.bashrc"
fi