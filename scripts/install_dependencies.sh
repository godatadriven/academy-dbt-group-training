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

# Initialize gcloud for BigQuery OAuth
echo "============================================"
echo "To authenticate with BigQuery, run:"
echo "  gcloud auth application-default login"
echo "  gcloud auth login"
echo "============================================"
